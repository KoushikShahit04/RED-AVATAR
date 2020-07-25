package com.redavatar.serverconnector;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.Gateway;
import org.hyperledger.fabric.gateway.Identity;
import org.hyperledger.fabric.gateway.Network;
import org.hyperledger.fabric.gateway.Wallet;
import org.hyperledger.fabric.gateway.Wallets;
import org.hyperledger.fabric.gateway.impl.identity.X509IdentityImpl;
import org.hyperledger.fabric.sdk.helper.Config;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		System.setProperty(Config.SERVICE_DISCOVER_AS_LOCALHOST, "true");
		SpringApplication.run(DemoApplication.class, args);
	}

	private PrivateKey getPrivateKey() throws NoSuchAlgorithmException, InvalidKeySpecException {
		byte[] decoded = Base64.getDecoder().decode(
				"MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg+46uKV8ebSqqllhcTEp1wnYyIssbLzfLIbKyVfdp95OhRANCAARqSB/An8hE1rZpKAP0qXwNDZTXA7AFaMYH2rN7iuBr73F1Vf1HK8g4ZyTq6hbP90Oh1K5i7ru/YZcjPUMUuezG");
		KeyFactory kf = KeyFactory.getInstance("EC");
		PKCS8EncodedKeySpec keySpecPKCS8 = new PKCS8EncodedKeySpec(decoded);
		return kf.generatePrivate(keySpecPKCS8);
	}

	private Gateway.Builder gatewayBuilder()
			throws IOException, NoSuchAlgorithmException, InvalidKeySpecException, CertificateException {
		Wallet wallet = Wallets.newFileSystemWallet(Paths.get("src", "main", "resources", "wallet"));
		InputStream inStream = new ByteArrayInputStream(
				"-----BEGIN CERTIFICATE-----\nMIICWDCCAf+gAwIBAgIUbwifsIDglkKk825fbLUYt/KhLygwCgYIKoZIzj0EAwIw\nfzELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNh\nbiBGcmFuY2lzY28xHzAdBgNVBAoTFkludGVybmV0IFdpZGdldHMsIEluYy4xDDAK\nBgNVBAsTA1dXVzEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjAwNzIyMTYxODAw\nWhcNMjEwNzIyMTYyMzAwWjBdMQswCQYDVQQGEwJVUzEXMBUGA1UECBMOTm9ydGgg\nQ2Fyb2xpbmExFDASBgNVBAoTC0h5cGVybGVkZ2VyMQ8wDQYDVQQLEwZjbGllbnQx\nDjAMBgNVBAMTBWFkbWluMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEakgfwJ/I\nRNa2aSgD9Kl8DQ2U1wOwBWjGB9qze4rga+9xdVX9RyvIOGck6uoWz/dDodSuYu67\nv2GXIz1DFLnsxqN7MHkwDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAwHQYD\nVR0OBBYEFO9kWeFaVo/s5JHkKLwYnnqJ4oExMB8GA1UdIwQYMBaAFBdnQj2qnoI/\nxMUdn1vDmdG1nEgQMBkGA1UdEQQSMBCCDmRvY2tlci1kZXNrdG9wMAoGCCqGSM49\nBAMCA0cAMEQCIEyA9j2PqRF+Un0DlrPxDT6bvaIXhrz8IcXRXItGG2bfAiAQw9jR\nZNlTFvBXdq7QU1PW1YGe9Q498Aj+xnPsgnPuHg==\n-----END CERTIFICATE-----"
						.getBytes());
		X509Certificate certificate = (X509Certificate) CertificateFactory.getInstance("X.509")
				.generateCertificate(inStream);
		Identity identity = new X509IdentityImpl("Org1MSP", certificate, getPrivateKey());
		wallet.put("admin", identity);

		this.getClass().getClassLoader();
		return Gateway.createBuilder().identity(wallet, "admin")
				.networkConfig(ClassLoader.getSystemResourceAsStream("Org1_connection.json")).discovery(true);
	}

	@Bean
	public Contract contract()
			throws NoSuchAlgorithmException, InvalidKeySpecException, CertificateException, IOException {
		Gateway gateway = gatewayBuilder().connect();
		Network network = gateway.getNetwork("mychannel");
		return network.getContract("bloodchain");
	}

	// @Bean
	// public Database database(CloudantClient cloudantClient,
	// @Value("${cloudant.db}") String redavatarDB) {
	// return cloudantClient.database(redavatarDB, false);
	// }
}
