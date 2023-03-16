part of 'settings_change_password.dart';

class SettingsChangePasswordController {
  TextEditingController oldPassword;
  TextEditingController newPassword;
  TextEditingController repeatNewPassword;

  SettingsChangePasswordController() {
    this.oldPassword = new TextEditingController(text: "");
    this.newPassword = new TextEditingController(text: "");
    this.repeatNewPassword = new TextEditingController(text: "");
  }

  PasswordUpdate getPasswordUpdate() {
    return new PasswordUpdate(
        newPassword: newPassword.text,
        oldPassword: oldPassword.text,
        repeatNewPassword: repeatNewPassword.text);
  }
}
