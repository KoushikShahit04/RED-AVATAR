import { BloodGroup } from "./enums";
import { Donation } from "./donation";

export class Donor {
  public _id: string;
  public _rev: string;
  public donorAadhar: string;
  public donorName: string;
  public bloodGroup: BloodGroup;
  public donations: Donation[];
}
