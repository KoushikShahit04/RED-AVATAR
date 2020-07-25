package com.redavatar.serverconnector.model.cloudant;

import lombok.Data;

@Data
public class Award {
  private String awardName;
  private String awardDate;
  private String awardedBy;
}