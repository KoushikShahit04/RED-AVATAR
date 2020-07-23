import { Component, OnInit } from "@angular/core";
import { Donor } from "../model/donor";
import { FormGroup, FormControl, Validators } from "@angular/forms";
import { environment } from "src/environments/environment";
import { NgbModalRef, NgbModal } from "@ng-bootstrap/ng-bootstrap";
import { CloudantService } from "../cloudant.service";
import { DonationRequestStatus, BagStatus, BloodGroup } from "../model/enums";
import { BlockchainDonor } from "../model/blockchain.donor";
import { Donation } from "../model/donation";

@Component({
  selector: "app-request",
  templateUrl: "./request.component.html",
  styleUrls: ["./request.component.css"],
})
export class RequestComponent implements OnInit {
  ngOnInit(): void {}

  donors: Donor[];
  selectedDonor: Donor;
  donorDetailsForm: FormGroup;
  showDetails: boolean = false;

  page = 1;
  pageSize = 5;
  noOfDonations = 0;
  modalRef: NgbModalRef;

  bagId = new FormControl("", [Validators.required]);
  showRequired: boolean = false;

  bloodGroups: string[] = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  bagStatusList: BagStatus[] = [
    BagStatus.COLLECTED,
    BagStatus.TESTED,
    BagStatus.APPROVED,
    BagStatus.REJECTED,
    BagStatus.ISSUED,
    BagStatus.USED,
  ];
  addBloodForm = new FormGroup({
    bagId: new FormControl("", [Validators.required]),
    donorId: new FormControl("", [Validators.required]),
    bloodGroup: new FormControl("A+", [Validators.required]),
    collectionDate: new FormControl("", [Validators.required]),
    bagStatus: new FormControl("", [Validators.required]),
    collectedAt: new FormControl(environment.INST_ID, [Validators.required]),
  });

  constructor(
    private cloudantService: CloudantService,
    private modalService: NgbModal
  ) {
    this.cloudantService
      .getDocs(environment.BLASTER_DB)
      .subscribe((response: any) => {
        console.log(response.rows[0].doc);
        this.noOfDonations = response.rows.length;
        this.donors = [];

        response.rows.forEach((row: any) => {
          let donor = row.doc as Donor;
          if (
            donor.donationRequest != null &&
            donor.donationRequest.status == DonationRequestStatus.REQUESTED
          ) {
            this.donors.push(donor);
          }
        });
        this.selectedDonor = null;
      });
  }

  open(content: any) {
    this.modalRef = this.modalService.open(content, {
      ariaLabelledBy: "modal-basic-title",
    });
  }

  addBloodBag() {
    if (this.addBloodForm.valid) {
      let formValue = this.addBloodForm.value;
      let newDonation = new Donation(
        formValue.bagId,
        formValue.collectionDate,
        formValue.bagStatus,
        formValue.collectedAt
      );
      this.cloudantService
        .findBlockchainDonor(environment.BLOCKCHAIN_DB, formValue.donorId)
        .subscribe((response: any) => {
          if (response.docs && (response.docs as []).length > 0) {
            let donor = response.docs[0] as BlockchainDonor;
            donor.donationDetails.push(newDonation);
            this.cloudantService
              .updateDoc(
                environment.BLOCKCHAIN_DB,
                donor._id,
                JSON.stringify(donor)
              )
              .subscribe((response: any) => {
                console.log("Donation details added");
                alert("Donation details added");
              });
          }
        });
    }
  }
}
