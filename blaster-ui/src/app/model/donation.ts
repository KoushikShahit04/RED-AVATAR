import { BloodGroup, DonorStatus, DonationStatus } from "./enums";

export class Donation {
  public donorAadhar: string;
  public donorName: string;
  public bloodGroup: BloodGroup;
  public donationDate: Date;
  public donorStatus: DonorStatus;
  public donorMobileNumber: string;
  public donorEmail: string;
  public donationStatus: DonationStatus;
}
