import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/chat/chat.dart';
import 'package:app_cargo/domain/driver_sign_up/driver_sign_up.dart';
import 'package:app_cargo/domain/chat/message/message.dart';
import 'package:app_cargo/screens/signup/signup_controller.dart';
import 'package:app_cargo/screens/signup/signup_screen.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/driver/driver_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_text_button.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ntp/ntp.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

abstract class SignUpStep extends StatelessWidget {
  final DriverService driverService = DIContainer().get<DriverService>();
  final ConfigurationService configurationService =
      DIContainer().get<ConfigurationService>();
  final ChatService chatMessageService = DIContainer().get<ChatService>();

  final FacebookAppEvents facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();
  FirebaseAnalytics firebaseAnalytics = DIContainer().get<FirebaseAnalytics>();

  Widget buildContent(BuildContext context);

  Future<bool> validate(
      SignUpController signUpController, BuildContext context);

  void _endSignUpProcess(BuildContext context) {
    facebookAppEvents.logEvent(name: AnalyticsEventsConstants.finishSignup);
    facebookAppEvents.logCompletedRegistration(
        registrationMethod: "Email and Password");
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.finishSignup);
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.finishSignup02);
    firebaseAnalytics.logEvent(name: AnalyticsEventsConstants.finishSignup03);

    Navigator.popAndPushNamed(context, Routes.endSignUp);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpModel>(
      builder: (context, signUpModel, _) {
        return Consumer<SignUpController>(
          builder: (context, signUpController, _) {
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              margin: EdgeInsets.only(top: 5, bottom: 20),
              decoration: new BoxDecoration(
                // color: AppColors.white,
                borderRadius: new BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  this.buildContent(context),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.signIn);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Já sou cadastrado!",
                        style: TextStyle(
                            color: AppColors.black,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 7,
                          decoration: BoxDecoration(
                              color: signUpModel.completionPercentage < 0.5
                                  ? AppColors.green
                                  : AppColors.grey,
                              shape: BoxShape.circle),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 7,
                          decoration: BoxDecoration(
                              color: signUpModel.completionPercentage >= 0.5 &&
                                      signUpModel.completionPercentage < 0.75
                                  ? AppColors.green
                                  : AppColors.grey,
                              shape: BoxShape.circle),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 7,
                          decoration: BoxDecoration(
                              color: signUpModel.completionPercentage >= 0.75
                                  ? AppColors.green
                                  : AppColors.grey,
                              shape: BoxShape.circle),
                        ),
                      ],
                    ),
                  ),
                  AppSaveButtonSecondUI(
                    signUpModel.completionPercentage >= 0.75
                        ? "Feito!"
                        : "CONTINUAR",
                    textColor: AppColors.black,
                    onPressed: () {
                      validate(signUpController, context).then((value) {
                        if (value) {
                          if (signUpModel.step == 1) {
                            // showMessageDialog(context,
                            //     type: DialogType.INFO,
                            //     message:
                            //         "A sua senha será a sua data de nascimento sem as barras: ${signUpController.birthDate.text.replaceAll("/", "")}");
                          }
                          if (signUpModel.canIncrement) {
                            if (!signUpModel.canDecrement) {
                              signUpModel.incrementStep();
                            } else {
                              signUpModel.incrementStep();
                            }
                          } else {
                            DriverSignUp driver =
                                signUpController.getDriverSingUp();
                            print(DriverSignUp.toJson(driver));
                            showLoadingThenOkDialog(
                                    context, driverService.signUp(driver),
                                    barrierDismissible: false,
                                    error:
                                        "Já existe um usuário cadastrado com este e-mail. Por favor, utilize outro.")
                                .then(
                              (loginResponse) {
                                if (loginResponse != null) {
                                  configurationService.setAccessToken(
                                      loginResponse.accessToken);
                                  configurationService
                                      .setDriverHash(loginResponse.hash);

                                  configurationService.setLuckyNumber(
                                      loginResponse.luckyNumber);

                                  configurationService.driverHash
                                      .then((driverHash) {
                                    NTP.now().then((now) {
                                      String appcargoHash =
                                          "6EbSAxD61qP0GlfO67N47p";

                                      List<String> membersHash = [
                                        driverHash,
                                        appcargoHash
                                      ];

                                      Chat chat = Chat(
                                          hidden: false,
                                          members: membersHash,
                                          lastSent: Timestamp.fromDate(now));

                                      Message message = Message(
                                          timestamp: Timestamp.fromDate(now),
                                          hashSender: appcargoHash,
                                          content: {
                                            "text":
                                                "Seja bem-vindo(a) ao AppCargo! Use o ZapCargo para se comunicar conosco e receber ofertas de frete."
                                          });

                                      chatMessageService
                                          .saveChat(chat)
                                          .then((hash) {
                                        chatMessageService.saveMessage(
                                            chat, message, hash);
                                      });
                                    });
                                  });

                                  this._endSignUpProcess(context);
                                }
                              },
                            ).catchError(
                              (errors) {
                                print(errors);
                              },
                            );
                          }
                        }
                      }).catchError((error) {
                        print(error);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> getCameraAndAudioPermission() async {
    List<Permissions> permissions = await Permission.getPermissionsStatus(
        [PermissionName.Microphone, PermissionName.Camera]);

    if (!hasCameraAndAudioPermission(permissions)) {
      permissions = await Permission.requestPermissions(
          [PermissionName.Microphone, PermissionName.Camera]);
      if (!hasCameraAndAudioPermission(permissions)) {
        throw "Permission denied for access to the camera.";
      }
    }

    return true;
  }

  bool hasCameraAndAudioPermission(List<Permissions> permissions) {
    bool hasAllPermissions = true;

    for (Permissions permission in permissions) {
      if (permission.permissionStatus != PermissionStatus.allow) {
        hasAllPermissions = false;
      }
    }

    return hasAllPermissions;
  }
}
