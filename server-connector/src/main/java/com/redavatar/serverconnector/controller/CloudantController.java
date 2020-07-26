package com.redavatar.serverconnector.controller;

import java.util.List;

import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.cloudant.Donor;
import com.redavatar.serverconnector.service.CloudantService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
public class CloudantController {

  @Autowired
  private CloudantService service;
  Logger logger = LogManager.getLogger(CloudantController.class);

  @GetMapping("/redavatar/donor/{donorId}")
  public ResponseEntity<Donor> findDonor(@PathVariable String donorId) {
    Donor body = this.service.getDonor(donorId);
    logger.info("Response: {}", body);
    return ResponseEntity.ok(body);
  }

  @PatchMapping("/redavatar/donor/{donorId}")
  public ResponseEntity<String> updateDonor(@PathVariable String donorId, @RequestBody Donor donor) {
    String body = this.service.updateDonor(donor);
    logger.info("Response: {}", body);
    return ResponseEntity.ok(this.service.updateDonor(donor));
  }

  @GetMapping("/redavatar/blood/{bloodGroup}")
  public ResponseEntity<List<Donor>> findBlood(@PathVariable String bloodGroup) {
    List<Donor> body = this.service.findDonorsWithBloodGroup(BloodGroup.of(bloodGroup));
    logger.info("Response: {}", body);
    return ResponseEntity.ok(body);
  }
}