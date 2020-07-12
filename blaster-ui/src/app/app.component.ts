import { Component, OnInit } from "@angular/core";
import { Donor } from "./model/donor";
import { FormControl, FormGroup } from "@angular/forms";
import { DonationStatus } from "./model/enums";
import { CloudantService } from "./cloudant.service";
import { environment } from "src/environments/environment";

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.css"],
})
export class AppComponent {
  donors: Donor[];
  donor: Donor;
  donorDetailsForm: FormGroup;
  showDetails: boolean = false;

  page = 1;
  pageSize = 10;
  noOfDonations = 0;

  constructor(private cloudantService: CloudantService) {
    this.cloudantService
      .getDocs(environment.BLASTER_DB)
      .subscribe((response: any) => {
        console.log(response.rows[0].doc);
        this.noOfDonations = response.rows.length;
        this.donors = [];

        response.rows.forEach((row) => {
          this.donors.push(row.doc as Donor);
          this.donor = this.donors[0];
        });
      });
  }

  selectDonation(donation: Donor) {
    this.donor = donation;
    this.showDetails = true;
  }

  approve() {
    this.donor.donationStatus = DonationStatus.APPROVED;
    console.log("Updated donation: " + JSON.stringify(this.donor));
  }

  reject() {
    this.donor.donationStatus = DonationStatus.REJECTED;
    console.log("Updated donation: " + JSON.stringify(this.donor));
  }
}
