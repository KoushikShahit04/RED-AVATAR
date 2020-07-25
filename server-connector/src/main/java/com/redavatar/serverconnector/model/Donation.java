package com.redavatar.serverconnector.model;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Donation {
  private String bagId;
  private LocalDate donationDate;
  private BagStatus bagStatus;
  private String collectedInstitute;
}