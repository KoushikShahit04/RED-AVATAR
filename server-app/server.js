require("dotenv").config({ silent: true });

const express = require("express");
const bodyParser = require("body-parser");

const assistant = require("./lib/assistant.js");
const port = process.env.PORT || 3000;

// const cloudant = require("./lib/cloudant.js");
const redavatar_db = require("./lib/redavatar_db");
// const blockchain_db = require("./lib/blockchain_db");

const path = require("path");
const fs = require("fs");

const app = express();
app.use(bodyParser.json());
const { Wallets, Gateway } = require("fabric-network");
const ccpPath = path.resolve(__dirname, "connection-org1.json");
let ccp = JSON.parse(fs.readFileSync(ccpPath, "utf8"));
const gateway = new Gateway();

const testConnections = () => {
  const status = {};
  return assistant
    .session()
    .then(() => {
      status["assistant"] = "ok";
      return status;
    })
    .catch((err) => {
      console.error(err);
      status["assistant"] = "failed";
      return status;
    })
    .then(() => {
      return redavatar_db.info();
    })
    .then(() => {
      status["cloudant"] = "ok";
      return status;
    })
    .catch((err) => {
      console.error(err);
      status["cloudant"] = "failed";
      return status;
    });
};

const handleError = (res, err) => {
  const status = err.code !== undefined && err.code > 0 ? err.code : 500;
  return res.status(status).json(err);
};

app.all("/*", function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE,OPTIONS");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  next();
});

/**
 * Health check URL
 *
 * Return the status of cloudant and watson assistant connections.
 */
app.get("/", (req, res) => {
  testConnections().then((status) => res.json({ status: status }));
});

/**
 * Get a session ID
 *
 * Returns a session ID that can be used in subsequent message API calls.
 */
app.get("/api/session", (req, res) => {
  assistant
    .session()
    .then((sessionid) => res.send(sessionid))
    .catch((err) => handleError(res, err));
});

/**
 * Post process the response from Watson Assistant
 *
 * We want to see if this was a request for resources/supplies, and if so
 * look up in the Cloudant DB whether any of the requested resources are
 * available. If so, we insert a list of the resources found into the response
 * that will sent back to the client.
 *
 * We also modify the text response to match the above.
 */
function post_process_assistant(result) {
  let resource;
  // First we look to see if a) Watson did identify an intent (as opposed to not
  // understanding it at all), and if it did, then b) see if it matched a supplies entity
  // with reasonable confidence. "supplies" is the term our trained Watson skill uses
  // to identify the target of a question about resources, i.e.:
  //
  // "Where can i find face-masks?"
  //
  // ....should return with an enitity == "supplies" and entitty.value = "face-masks"
  //
  // That's our trigger to do a lookup - using the entitty.value as the name of resource
  // to to a datbase lookup.
  if (result.intents.length > 0) {
    result.entities.forEach((item) => {
      if (item.entity == "supplies" && item.confidence > 0.3) {
        resource = item.value;
      }
    });
  }
  if (!resource) {
    return Promise.resolve(result);
  } else {
    // OK, we have a resource...let's look this up in the DB and see if anyone has any.
    return cloudant.find("", resource, "").then((data) => {
      let processed_result = result;
      if (data.statusCode == 200 && data.data != "[]") {
        processed_result["resources"] = JSON.parse(data.data);
        processed_result["generic"][0]["text"] =
          "There is" + "\xa0" + resource + " available";
      } else {
        processed_result["generic"][0]["text"] =
          "Sorry, no" + "\xa0" + resource + " available";
      }
      return processed_result;
    });
  }
}

/**
 * Post a message to Watson Assistant
 *
 * The body must contain:
 *
 * - Message text
 * - sessionID (previously obtained by called /api/session)
 */
app.post("/api/message", (req, res) => {
  const text = req.body.text || "";
  const sessionid = req.body.sessionid;
  console.log(req.body);
  assistant
    .message(text, sessionid)
    .then((result) => {
      return post_process_assistant(result);
    })
    .then((new_result) => {
      res.json(new_result);
    })
    .catch((err) => handleError(res, err));
});

/**
 * @description Find a donor with donor id
 * @param id the donorId of the donor to be fetched
 * @returns The donor json if found
 */
app.get("/redavatar/donor/:id", (req, res) => {
  const donorId = req.params.id;

  redavatar_db
    .find(donorId)
    .then((data) => {
      if (data.statusCode != 200) {
        res.sendStatus(data.statusCode);
      } else {
        res.send(data.data);
      }
    })
    .catch((err) => handleError(res, err));
});

/**
 * @description update a donor json
 * @param id - The donorId of the donor to be patched
 * @returns The new revision of the donor
 */
app.patch("/redavatar/donor/:id", (req, res) => {
  console.log(req.body);
  let donor = req.body;
  if (!donor.donorId) {
    return res
      .status(422)
      .json({ errors: "Donor id must be provided for update" });
  }
  if (!donor._rev) {
    return res
      .status(422)
      .json({ errors: "_rev must be provided for updates" });
  }
  redavatar_db
    .update(donor)
    .then((data) => {
      console.log("Data from update: " + data);
      if (data.statusCode != 200) {
        res.sendStatus(data.statusCode);
      } else {
        res.send(data.data);
      }
    })
    .catch((err) => handleError(res, err));
});

/**
 * @description Find the required blood group from available donors
 * @param group - The blood group to be searched
 * @returns List of donors
 */
app.get("/redavatar/blood/:group", (req, res) => {
  console.log("Inside get blood api");
  if (!req.params.group) {
    return res.status(422).json({ errors: "Blood group must be provided" });
  }
  const bloodGroup = req.params.group;
  redavatar_db
    .findBlood(bloodGroup)
    .then((data) => {
      if (data.statusCode != 200) {
        res.sendStatus(data.statusCode);
      } else {
        res.send(data.data);
      }
    })
    .catch((err) => handleError(res, err));
});

/**
 * @description Find the required blood from bloodbank
 * @param group - The blood group to be searched
 * @returns List of donors from blockchain
 */
app.get("/redavatar/blockchain/:group", (req, res) => {
  console.log("Searching blood in blockchain");
  if (!req.params.group) {
    return res.status(422).json({ errors: "Blood group must be provided" });
  }

  const bloodGroup = req.params.group;

  let selector = { bloodGroup: bloodGroup };

  invokeChaincode("findDonors", JSON.stringify(selector))
    .then((result) => {
      res.send(result);
    })
    .catch((err) => handleError(res, err));
});

app.get("/redavatar/blockchain", (req, res) => {
  console.log("Get all donors from blockchain");
  invokeChaincode("getAllDonors")
    .then((result) => {
      res.send(result.toString());
    })
    .catch((err) => {
      console.log(err);
      handleError(res, err);
    });
});

app.post("/redavatar/blockchain", (req, res) => {
  console.log("Create donor in blockchain");
  if (!req.body) {
    return res.status(422).json({ errors: "Donor json data required in body" });
  }
  var key = req.body.donorId;
  var value = JSON.stringify(req.body);
  invokeChaincode("createDonor", key, value)
    .then((result) => {
      res.send(result.toString());
    })
    .catch((err) => handleError(res, err));
});

app.get("/redavatar/blockchain/donor/:donorId", (req, res) => {
  console.log("Get donor from blockchain");
  if (!req.params.donorId) {
    return res.status(422).json({ errors: "Donor id required in parameters" });
  }
  invokeChaincode("getDonor", req.params.donorId)
    .then((result) => {
      if (result) {
        res.send(result);
      } else {
        result.send(null);
      }
    })
    .catch((err) => handleError(res, err));
});

/**
 * @description Helper function to invoke chaincode with gateway
 * @param {String} funcName
 * @param  {...String} args
 */
function invokeChaincode(funcName, ...args) {
  return new Promise((resolve, reject) => {
    const walletPath = path.join(process.cwd(), "wallet");
    Wallets.newFileSystemWallet(walletPath)
      .then((wallet) => {
        gateway
          .connect(ccp, {
            wallet,
            identity: "admin",
            discovery: { enabled: true, asLocalhost: true },
          })
          .then(() => {
            const network = gateway.getNetwork("mychannel");
            const contract = network.getContract("bloodchain");
            contract
              .submitTransaction(funcName, args)
              .then((buffer) => {
                resolve(buffer.toString());
              })
              .catch((err) => reject(err));
          })
          .catch((err) => reject(err));
      })
      .catch((err) => reject(err));
  });
}

const server = app.listen(port, () => {
  const host = server.address().address;
  console.log(`redavatarServer listening at http://${host}:${port}`);
});
