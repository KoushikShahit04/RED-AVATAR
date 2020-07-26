package com.redavatar.serverconnector.controller;

import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
public class TwilioController {
  private static final PhoneNumber TWILIO_NUMBER = new PhoneNumber("+12058435755");

  @PostMapping(value = "/redavatar/alert/{phone}", produces = MediaType.TEXT_PLAIN_VALUE)
  public ResponseEntity<String> sendAlerts(@PathVariable String phone, @RequestBody String messageText) {
    Message message = Message.creator(new PhoneNumber(phone), TWILIO_NUMBER, messageText).create();
    return ResponseEntity.ok(message.getStatus().name());
  }
}