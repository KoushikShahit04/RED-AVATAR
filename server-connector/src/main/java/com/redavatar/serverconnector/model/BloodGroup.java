package com.redavatar.serverconnector.model;

import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum BloodGroup {
  A_PLUS("A+"), A_MINUS("A-"), B_PLUS("B+"), B_MINUS("B-"), AB_PLUS("AB+"), AB_MINUS("AB-"), O_PLUS("O+"),
  O_MINUS("O-");

  private String group;

  private BloodGroup(String group) {
    this.group = group;
  }

  @JsonValue
  public String getGroup() {
    return this.group;
  }

  public static BloodGroup of(String group) {
    return Arrays.asList(BloodGroup.values()).parallelStream().filter(bg -> group.equals(bg.group)).findFirst()
        .orElse(null);
  }
}