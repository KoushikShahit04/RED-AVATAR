package com.redavatar.serverconnector.model.cloudant;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.SerializedName;
import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.DonorStatus;

import lombok.Data;

@Data
public class Donor {
  @JsonProperty("_id")
  @SerializedName("_id")
  private String id;

  @SerializedName("_rev")
  @JsonProperty("_rev")
  private String rev;

  private String donorId;
  private String donorName;
  private BloodGroup bloodGroup;
  private DonorStatus donorStatus;
  private String donorMobileNumber;
  private String donorEmail;
  private DonorCategory donorCategory;
  private String rewardPoint;
  private DonationRequest donationRequest;
  private List<Award> donorAwards;
}