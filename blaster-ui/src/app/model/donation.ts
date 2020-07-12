import { DonorStatus, DonationStatus } from "./enums";
export class Donation {
  public donationDate: Date;
  public donorStatus: DonorStatus;
  public donorMobileNumber: string;
  public donorEmail: string;
  public donationStatus: DonationStatus;
}
