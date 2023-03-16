import 'package:app_cargo/domain/driver_contact_data/driver_contact_data.dart';
import 'package:app_cargo/domain/driver_emergency_data/driver_emergency_data.dart';
import 'package:app_cargo/domain/driver_personal_data/driver_personal_data.dart';
import 'package:app_cargo/domain/driver_social_data/driver_social_data.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/domain/vehicle_data/vehicle_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_summary.g.dart';

@JsonSerializable()
class ProfileSummary {
  /// List with all proposals that the driver has
  @JsonKey(fromJson: ProfileSummary.fromJsonFreightDetailsList)
  List<FreightDetails> proposals;

  /// Current driver's freight and all its information
  @JsonKey(toJson: FreightDetails.toJson, fromJson: FreightDetails.fromJson)
  FreightDetails current;

  @JsonKey(toJson: VehicleData.toJson, fromJson: VehicleData.fromJson)
  VehicleData vehicle;

  @JsonKey(
      fromJson: DriverContactData.fromJson, toJson: DriverContactData.toJson)
  DriverContactData contact;

  @JsonKey(
      toJson: DriverPersonalData.toJson, fromJson: DriverPersonalData.fromJson)
  DriverPersonalData personal;

  @JsonKey(toJson: DriverSocialData.toJson, fromJson: DriverSocialData.fromJson)
  DriverSocialData social;

  @JsonKey(
      fromJson: DriverEmergencyData.fromJson,
      toJson: DriverEmergencyData.toJson)
  DriverEmergencyData emergency;

  String declineReasonsListLastUpdate;

  String voucherOwnershipLastUpdate;

  ProfileSummary({
    this.current,
    this.proposals,
    this.contact,
    this.declineReasonsListLastUpdate,
    this.voucherOwnershipLastUpdate,
    this.emergency,
    this.social,
    this.personal,
    this.vehicle,
  });

  static Map<String, dynamic> toJson(ProfileSummary profileSummary) {
    return _$ProfileSummaryToJson(profileSummary);
  }

  static ProfileSummary fromJson(Map<String, dynamic> json) {
    return _$ProfileSummaryFromJson(json);
  }

  static List<FreightDetails> fromJsonFreightDetailsList(List<dynamic> json) {
    List<FreightDetails> proposals = new List<FreightDetails>();

    for (Map<String, dynamic> freight in json) {
      proposals.add(FreightDetails.fromJson(freight));
    }

    return proposals;
  }
}
