import { Component, OnInit } from "@angular/core";
import { Donation } from "./model/donation";
import { FormControl, FormGroup } from "@angular/forms";
import { DonationStatus } from "./model/enums";
import { CloudantService } from "./cloudant.service";

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.css"],
})
export class AppComponent {
  donations: Donation[];
  donation: Donation;
  donorDetailsForm: FormGroup;
  showDetails: boolean = false;

  page = 1;
  pageSize = 10;
  noOfDonations = 0;

  constructor(private cloudantService: CloudantService) {
    this.cloudantService.getDocs().subscribe((response: any) => {
      console.log(response.rows[0].doc);
      this.noOfDonations = response.rows.length;
      this.donations = [];

      response.rows.forEach((row) => {
        this.donations.push(row.doc as Donation);
        this.donation = this.donations[0];
      });
    });
  }

  selectDonation(donation: Donation) {
    this.donation = donation;
    this.showDetails = true;
  }

  approve() {
    this.donation.donationStatus = DonationStatus.APPROVED;
    console.log("Updated donation: " + JSON.stringify(this.donation));
  }

  reject() {
    this.donation.donationStatus = DonationStatus.REJECTED;
    console.log("Updated donation: " + JSON.stringify(this.donation));
  }
}
