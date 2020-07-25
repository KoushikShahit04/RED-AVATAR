package com.redavatar.serverconnector;

import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

public class Test {
  public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeySpecException {
    byte[] decoded = Base64.getDecoder().decode(
        "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg+46uKV8ebSqqllhcTEp1wnYyIssbLzfLIbKyVfdp95OhRANCAARqSB/An8hE1rZpKAP0qXwNDZTXA7AFaMYH2rN7iuBr73F1Vf1HK8g4ZyTq6hbP90Oh1K5i7ru/YZcjPUMUuezG");
    KeyFactory kf = KeyFactory.getInstance("EC");
    PKCS8EncodedKeySpec keySpecPKCS8 = new PKCS8EncodedKeySpec(decoded);
    PrivateKey privKey = kf.generatePrivate(keySpecPKCS8);
    System.out.println(privKey);
  }
}