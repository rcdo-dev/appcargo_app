import 'dart:io';

import 'package:app_cargo/http/transformers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'truck_trailer.g.dart';

@JsonSerializable()
class TruckTrailer {

  @JsonKey(toJson: genericStringCleaner)
  String plate;

  @JsonKey(toJson: genericStringCleaner)
  String renavam;

  @JsonKey(toJson: genericStringCleaner)
  String vin;

  String extras;

  @JsonKey(ignore: true)
  File documentationPhoto;

  String documentationPhotoUrl;
  String hash;

  TruckTrailer({this.plate, this.renavam, this.vin, this.extras, this.documentationPhotoUrl, this.documentationPhoto, this.hash});

  static fromJson(Map<String, dynamic> json) => _$TruckTrailerFromJson(json);

  static toJson(TruckTrailer trailer) => _$TruckTrailerToJson(trailer);
}