import 'package:app_cargo/domain/complaint_details/complaint_details.dart';

import 'package:app_cargo/domain/complaint_reply/complaint_reply.dart';

import 'package:app_cargo/domain/complaint_summary/complaint_summary.dart';

import 'package:app_cargo/domain/complaints/complaints.dart';

import 'complaint_service.dart';

String hash = "72543da6-b7ad-11e9-a2a3-2a2ae2dbcce4";
ComplaintDetails defaultComplaintDetails = new ComplaintDetails(
    hash: hash,
    photo: "",
    code: "REC-772384729",
    message: "Tive um problema",
    subject: "Pagamento",
    replies: []);

ComplaintSummary defaultComplaintSummary = new ComplaintSummary(
    subject: "Pagamento", code: "REC-738173918", hash: hash);

Complaints defaultComplaints = new Complaints(
  closed: [
    defaultComplaintSummary,
    defaultComplaintSummary,
    defaultComplaintSummary
  ],
  open: [
    defaultComplaintDetails,
    defaultComplaintDetails,
    defaultComplaintDetails
  ],
);

class ComplaintMockService implements ComplaintService {
  @override
  Future<void> closeComplaint(ComplaintDetails complaintDetails) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<void> createComplaint(ComplaintDetails complaintDetails) {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<ComplaintDetails> getComplaintDetails(
      ComplaintSummary complaintSummary) {
    return Future.delayed(Duration(seconds: 1), () => defaultComplaintDetails);
  }

  @override
  Future<Complaints> getComplaints() {
    return Future.delayed(Duration(seconds: 1), () => defaultComplaints);
  }

  @override
  Future<void> replyComplaint(ComplaintReply complaintReply, String hash) {
    return Future.delayed(Duration(seconds: 1));
  }
}
