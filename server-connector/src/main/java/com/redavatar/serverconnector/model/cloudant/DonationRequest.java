package com.redavatar.serverconnector.model.cloudant;

import lombok.Data;

@Data
public class DonationRequest {
  private String donationDate;
  private String donationCenter;
  private RequestStatus status;
}