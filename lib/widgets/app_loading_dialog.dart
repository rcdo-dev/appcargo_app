import 'dart:convert';

import 'package:app_cargo/constants/app_colors.dart';

import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/http/api_error.dart';
import 'package:app_cargo/widgets/app_dialog_login_without_birth_date.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

Widget _buildErrorState(
  BuildContext context,
  AsyncSnapshot snapshot, {
  String errorMessage,
}) {
  if (snapshot.data is String) {
    try {
      var data = snapshot.data as String;
      var correctedJson = data.replaceAllMapped(
          RegExp("(?<={|, )([a-zA-Z]+?):"), (Match m) => '"${m[1]}":');
      correctedJson = correctedJson.replaceAllMapped(
          RegExp("(?<=: )([\\w\\u00C0-\\u024F ]+?)([,\\]}])"),
          (Match m) => '"${m[1]}"${m[2]}');

      var json = jsonDecode(correctedJson);
      var errors = ApiError.listFromResponse(json);
      if (errors.length > 0) {
        errorMessage = errors[0].details;
      }
    } catch (e) {}
  }

  Future.delayed(Duration(seconds: 4), () {
    try {
      Navigator.pop(context, errorMessage);
    } catch (ignore) {}
  });

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 666,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(90),
            topLeft: Radius.circular(90),
          ),
          child: Container(
            width: 50,
            height: 50,
            color: AppColors.white,
            alignment: Alignment.center,
            child: SkyText(
              "X",
              fontSize: 40,
              textColor: Colors.red,
            ),
          ),
        ),
      ),
      Container(
        width: 666,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: SkyText(
            errorMessage == 'A data de nascimento do motorista está incorreta\n'
                ? errorMessage +
                    '\nEm instantes você poderá atualizar a data informada.'

                /// Corrigir 'encontradao' no back end <------
                : errorMessage == 'O motorista informado não foi encontradao\n'
                    ? errorMessage + '\nVerifique as informações digitadas'
                    : errorMessage,
            fontSize: 22,
            textColor: Colors.red,
          ),
        ),
      ),
    ],
  );
}

Future<T> showLoadingThenOkDialog<T>(
  BuildContext context,
  Future<T> future, {
  bool barrierDismissible = true,
  bool popTwiceOnOk = false,
  String error =
      "Ocorreu um erro com a sua requisição, tente novamente mais tarde",
}) async {
  Object data;
  bool hasError = false;
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => Container(
      alignment: Alignment.center,
      child: WillPopScope(
          child: SimpleDialog(
            shape: CircleBorder(),
            backgroundColor: Color(0x00ffffff),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            children: <Widget>[
              FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      print(snapshot.toString());

                      if (snapshot.data is List<ApiError>) {
                        print(snapshot.data);
                        String errorCode = "";
                        error = "";
                        List<ApiError> apiErrors = snapshot.data;
                        for (ApiError apiError in apiErrors) {
                          errorCode = apiError.code;
                          error += apiError.details + "\n";
                        }
                        data = null;
                        hasError = true;
                        if (errorCode == "MISSING_BIRTHDATE_EXCEPTION") {
                          Future.delayed(
                            new Duration(milliseconds: 0),
                            () {
                              try {
                                appDialogLoginWithoutBirthDate(context)
                                    .then((_) {
                                  Navigator.pop(context);
                                });
                              } catch (error) {}
                            },
                          );
                          return Container();
                        } else {
                          return _buildErrorState(
                            context,
                            snapshot,
                            errorMessage: error,
                          );
                        }
                      } else {
                        if (snapshot.hasData) {
                          data = snapshot.data;
                        }
                        Future.delayed(
                          new Duration(seconds: 1),
                          () {
                            try {
                              Navigator.pop(context);
                            } catch (error) {}
                          },
                        );
                        return Container(
                          width: 666,
                          alignment: Alignment.center,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.check,
                              color: AppColors.green,
                              size: 40,
                            ),
                          ),
                        );
                      }
                      break;
                    default:
                      return Container(
                        width: 666,
                        alignment: Alignment.center,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: AppColors.white,
                          ),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.green),
                          ),
                        ),
                      );
                      break;
                  }
                  return null;
                },
              ),
            ],
          ),
          onWillPop: () {
            return Future.value(false);
          }),
    ),
  ).then((value) {
    if (popTwiceOnOk && !hasError) {
      Navigator.pop(context);
    } else if (data == null) {
      data = value;
    }
    return data;
  });
}

void showLoadingDialog<T>(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    child: Container(
      alignment: Alignment.center,
      child: SimpleDialog(
        shape: CircleBorder(),
        backgroundColor: Color(0x00ffffff),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: <Widget>[
          Container(
            width: 666,
            alignment: Alignment.center,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: AppColors.white),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
