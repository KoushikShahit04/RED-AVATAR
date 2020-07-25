package com.redavatar.serverconnector.service;

import java.util.Collections;
import java.util.List;

import com.cloudant.client.api.Database;
import com.cloudant.client.api.model.Response;
import com.cloudant.client.api.query.QueryResult;
import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.cloudant.Donor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CloudantService {

  @Autowired
  private Database database;

  public Donor getDonor(String donorId) {
    String selector = String.format("{\"selector\":{\"donorId\": \"%s\"}}", donorId);
    QueryResult<Donor> result = database.query(selector, Donor.class);
    if (result != null && result.getDocs() != null && !result.getDocs().isEmpty()) {
      return result.getDocs().get(0);
    }
    return null;
  }

  public String updateDonor(Donor donor) {
    Response response = database.update(donor);
    return response.getRev();
  }

  public List<Donor> findDonorsWithBloodGroup(BloodGroup bloodGroup) {
    String selector = String.format(
        "{\"selector\": {\"bloodGroup\": \"%s\",\"donationRequest\": {\"status\": \"REQUESTED\"}}}",
        bloodGroup.getGroup());
    QueryResult<Donor> result = database.query(selector, Donor.class);
    if (result != null) {
      return result.getDocs();
    }

    return Collections.emptyList();
  }
}