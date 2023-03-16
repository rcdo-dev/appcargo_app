part of 'make_complaint.dart';

class MakeComplaintController {
  TextEditingController subject;
  TextEditingController message;
  String photo;

  MakeComplaintController() {
    subject = new TextEditingController();
    message = new TextEditingController();
    photo = "";
  }

  ComplaintDetails getComplaintDetails() {
    return new ComplaintDetails(
      photo: photo,
      subject: subject.text,
      message: message.text,
    );
  }
}
