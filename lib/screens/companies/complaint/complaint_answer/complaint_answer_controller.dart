part of 'complaint_answer.dart';

class ComplaintAnswerController {
  TextEditingController message;
  String photo;

  ComplaintAnswerController() {
    message = new TextEditingController();
    photo = "";
  }

  ComplaintReply getComplaintReply() {
    return new ComplaintReply(
        message: message.text, photo: photo, isFreightCo: false);
  }
}
