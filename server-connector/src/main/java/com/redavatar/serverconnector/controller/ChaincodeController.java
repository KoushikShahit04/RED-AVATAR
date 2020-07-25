package com.redavatar.serverconnector.controller;

import java.util.List;

import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.Donor;
import com.redavatar.serverconnector.service.ChaincodeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/redavatar/blockchain")
public class ChaincodeController {

  @Autowired
  private ChaincodeService service;

  @GetMapping(value = "")
  public ResponseEntity<List<Donor>> getAllDonors() throws Exception {
    return ResponseEntity.ok(this.service.getAllDonors());
  }

  @PostMapping(value = "", consumes = MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<String> createDonor(@RequestBody Donor donor) throws Exception {
    return ResponseEntity.ok(this.service.createDonor(donor));
  }

  @GetMapping("/{group}")
  public ResponseEntity<List<Donor>> findDonors(@PathVariable String group) throws Exception {
    return ResponseEntity.ok(this.service.findDonors(BloodGroup.of(group)));
  }

  @GetMapping("/donor/{donorId}")
  public ResponseEntity<Donor> getDonor(@PathVariable String donorId) throws Exception {
    return ResponseEntity.ok(this.service.getDonor(donorId));
  }

  @PostMapping("/selector")
  public ResponseEntity<List<Donor>> selectDonors(@RequestBody String selector) throws Exception {
    return ResponseEntity.ok(this.service.findDonors(selector));
  }
}