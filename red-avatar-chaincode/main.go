package main

import (
	"bytes"
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	"github.com/hyperledger/fabric/protos/peer"
)

// Chaincode is the definition of the chaincode structure.
type Chaincode struct {
}

// Init is called when the chaincode is instantiated by the blockchain network.
func (cc *Chaincode) Init(stub shim.ChaincodeStubInterface) peer.Response {
	// params := stub.GetStringArgs()
	// fmt.Println("Init()", params)
	// if len(params) != 3 {
	// 	return shim.Error("Incorrect arguments. Expecting a key and a value")
	// }

	// asBytes, err := json.Marshal(params[2])
	// if err != nil {
	// 	log.Panic(err)
	// }
	// err = stub.PutState(params[1], asBytes)
	// handleError(err)
	return shim.Success(nil)
}

// Invoke is called as a result of an application request to run the chaincode.
func (cc *Chaincode) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	fcn, params := stub.GetFunctionAndParameters()
	fmt.Println("Invoke()", fcn, params)

	if fcn == "createDonor" {
		return cc.createDonor(stub, params)
	} else if fcn == "getDonor" {
		return cc.getDonor(stub, params)
	} else if fcn == "findDonors" {
		return cc.findDonors(stub, params)
	} else if fcn == "getAllDonors" {
		return cc.getAllDonors(stub)
	}

	fmt.Println("Invoke did not find func: " + fcn) //error
	return shim.Error("Received unknown function invocation")
}

func (cc *Chaincode) createDonor(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	if len(args) != 2 {
		return shim.Error("Incorrect arguments. Expecting a key and a value")
	}

	err := stub.PutState(args[0], []byte(args[1]))
	if err != nil {
		return shim.Error(err.Error())
	}

	result, err := stub.GetState(args[0])
	if err != nil {
		return shim.Error(err.Error())
	}
	return shim.Success(result)
}

func (cc *Chaincode) getDonor(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect arguments. Expecting a key only")
	}
	donorID := args[0]

	asBytes, err := stub.GetState(donorID)
	if err != nil {
		return shim.Error(err.Error())
	}
	fmt.Printf("- getDonor result:\n%s\n", string(asBytes))
	return shim.Success(asBytes)
}

func (cc *Chaincode) getAllDonors(stub shim.ChaincodeStubInterface) peer.Response {
	startKey := "D0001"
	endKey := "D9999"

	resultsIterator, err := stub.GetStateByRange(startKey, endKey)
	if err != nil {
		return shim.Error(err.Error())
	}
	defer resultsIterator.Close()

	// buffer is a JSON array containing QueryResults
	buffer, err := constructQueryResponseFromIterator(resultsIterator)
	if err != nil {
		return shim.Error(err.Error())
	}
	fmt.Printf("- getAllDonors queryResult:\n%s\n", buffer.String())
	return shim.Success(buffer.Bytes())
}

func (cc *Chaincode) findDonors(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	if len(args) != 1 {
		return shim.Error("Incorrect arguments. Expecting a selector only")
	}
	queryString := args[0]

	resultsIterator, err := stub.GetQueryResult(queryString)
	if err != nil {
		return shim.Error(err.Error())
	}
	defer resultsIterator.Close()

	buffer, err := constructQueryResponseFromIterator(resultsIterator)
	if err != nil {
		return shim.Error(err.Error())
	}
	fmt.Printf("- findDonors queryResult:\n%s\n", buffer.String())
	return shim.Success(buffer.Bytes())
}

func constructQueryResponseFromIterator(resultsIterator shim.StateQueryIteratorInterface) (*bytes.Buffer, error) {
	// buffer is a JSON array containing QueryResults
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		// Record is a JSON object, so we write as-is
		buffer.WriteString(string(queryResponse.Value))
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	return &buffer, nil
}

func main() {
	err := shim.Start(new(Chaincode))
	if err != nil {
		panic(err)
	}
}
