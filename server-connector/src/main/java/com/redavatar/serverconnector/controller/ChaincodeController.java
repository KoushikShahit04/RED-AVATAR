package com.redavatar.serverconnector.controller;

import java.util.List;

import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.blockchain.Donor;
import com.redavatar.serverconnector.service.ChaincodeService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
public class ChaincodeController {
  private static final Logger logger = LogManager.getLogger(ChaincodeController.class);

  @Autowired
  private ChaincodeService service;

  @GetMapping(value = "/redavatar/blockchain")
  public ResponseEntity<List<Donor>> getAllDonors() throws Exception {
    logger.info("Inside getAllDonors");
    List<Donor> body = this.service.getAllDonors();
    logger.info(body);
    return ResponseEntity.ok(body);
  }

  @PostMapping(value = "/redavatar/blockchain")
  public ResponseEntity<String> createDonor(@RequestBody Donor donor) throws Exception {
    logger.info("Inside createDonor");
    String body = this.service.createDonor(donor);
    logger.info(body);
    return ResponseEntity.ok(body);
  }

  @GetMapping("/redavatar/blockchain/{group}")
  public ResponseEntity<List<Donor>> findDonors(@PathVariable String group) throws Exception {
    logger.info("Inside findDonors");
    List<Donor> body = this.service.findDonors(BloodGroup.of(group));
    logger.info(body);
    return ResponseEntity.ok(body);
  }

  @GetMapping("/redavatar/blockchain/donor/{donorId}")
  public ResponseEntity<Donor> getDonor(@PathVariable String donorId) throws Exception {
    logger.info("Inside getDonor");
    Donor body = this.service.getDonor(donorId);
    logger.info(body);
    return ResponseEntity.ok(body);
  }

  @PostMapping("/redavatar/blockchain/selector")
  public ResponseEntity<List<Donor>> selectDonors(@RequestBody String selector) throws Exception {
    logger.info("Inside selectDonors");
    List<Donor> body = this.service.findDonors(selector);
    logger.info(body);
    return ResponseEntity.ok(body);
  }
}