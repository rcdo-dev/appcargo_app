import 'package:app_cargo/domain/complaint_details/complaint_details.dart';
import 'package:app_cargo/domain/complaint_reply/complaint_reply.dart';
import 'package:app_cargo/domain/complaint_summary/complaint_summary.dart';
import 'package:app_cargo/domain/complaints/complaints.dart';
import 'package:app_cargo/http/app_cargo_client.dart';

Complaints _mapToComplaints(Map<String, dynamic> json) {
  return Complaints.fromJson(json);
}

ComplaintDetails _mapToComplaintDetails(Map<String, dynamic> json) {
  return ComplaintDetails.fromJson(json);
}

class ComplaintService {
  AppCargoClient _dioClient;

  ComplaintService(this._dioClient);

  Future<Complaints> getComplaints() {
    return this._dioClient.get("/v1/complaints", _mapToComplaints);
  }

  Future<dynamic> createComplaint(ComplaintDetails complaintDetails) {
    return this._dioClient.post(
          "/v1/complaints",
          null,
          data: ComplaintDetails.toJson(complaintDetails),
        );
  }

  Future<dynamic> getComplaintDetails(ComplaintSummary complaintSummary) {
    return this
        ._dioClient
        .get("/v1/complaints/${complaintSummary.hash}", _mapToComplaintDetails);
  }

  Future<dynamic> replyComplaint(ComplaintReply complaintReply, String hash) {
    return this._dioClient.post(
          "/v1/complaints/$hash",
          null,
          data: ComplaintReply.toJson(complaintReply),
        );
  }

  Future<dynamic> closeComplaint(ComplaintDetails complaintDetails) {
    return this._dioClient.post(
          "/v1/complaints/${complaintDetails.hashCode}/close",
          null,
        );
  }
}
