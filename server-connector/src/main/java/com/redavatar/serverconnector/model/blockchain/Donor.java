package com.redavatar.serverconnector.model.blockchain;

import java.util.List;

import com.redavatar.serverconnector.model.BloodGroup;
import com.redavatar.serverconnector.model.DonorStatus;

import lombok.Data;

@Data
public class Donor {
  private String donorId;
  private String donorName;
  private BloodGroup bloodGroup;
  private DonorStatus donorStatus;
  private String donorMobileNumber;
  private String donorEmail;
  private List<Donation> donationDetails;
}