package com.redavatar.serverconnector.model;

import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonValue;
import com.google.gson.annotations.SerializedName;

public enum BloodGroup {
  @SerializedName("A+")
  A_PLUS("A+"),

  @SerializedName("A-")
  A_MINUS("A-"),

  @SerializedName("B+")
  B_PLUS("B+"),

  @SerializedName("B-")
  B_MINUS("B-"),

  @SerializedName("AB+")
  AB_PLUS("AB+"),

  @SerializedName("AB-")
  AB_MINUS("AB-"),

  @SerializedName("O+")
  O_PLUS("O+"),

  @SerializedName("O-")
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