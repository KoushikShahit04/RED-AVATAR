package com.redavatar.serverconnector.service;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.concurrent.TimeoutException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.Donor;

import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.ContractException;
import org.hyperledger.fabric.gateway.Gateway;
import org.hyperledger.fabric.gateway.Network;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChaincodeService {

  @Autowired
  private Gateway.Builder gatewayBuilder;
  @Autowired
  private ObjectMapper mapper;

  TypeReference<List<Donor>> typeReference = new TypeReference<List<Donor>>() {
  };

  public List<Donor> findDonors(BloodGroup bloodGroup)
      throws ContractException, TimeoutException, InterruptedException, JsonProcessingException {
    String response = invokeChaincode("findDonors",
        String.format("{\"selector\":{\"bloodGroup\": \"%s\"}}", bloodGroup.getGroup()));
    return mapper.readValue(response, typeReference);
  }

  public Donor getDonor(String donorId)
      throws ContractException, TimeoutException, InterruptedException, JsonProcessingException {
    String donorString = invokeChaincode("getDonor", donorId);
    return mapper.readValue(donorString, Donor.class);
  }

  public String createDonor(Donor donor)
      throws ContractException, JsonProcessingException, TimeoutException, InterruptedException {
    return invokeChaincode("createDonor", donor.getDonorId(), mapper.writeValueAsString(donor));
  }

  public List<Donor> getAllDonors()
      throws ContractException, TimeoutException, InterruptedException, JsonProcessingException {
    String response = invokeChaincode("getAllDonors");
    return mapper.readValue(response, typeReference);
  }

  public List<Donor> findDonors(String queryString)
      throws ContractException, TimeoutException, InterruptedException, JsonProcessingException {
    String response = invokeChaincode("findDonors", queryString);
    return mapper.readValue(response, typeReference);
  }

  private String invokeChaincode(String funcName, String... args)
      throws ContractException, TimeoutException, InterruptedException {
    try (Gateway gateway = this.gatewayBuilder.connect()) {
      Network network = gateway.getNetwork("mychannel");
      Contract contract = network.getContract("bloodchain");
      byte[] byteResult = contract.submitTransaction(funcName, args);
      return new String(byteResult, StandardCharsets.UTF_8);
    }
  }
}