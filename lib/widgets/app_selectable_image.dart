import 'dart:io';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/build_data.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:image_picker/image_picker.dart';

void _defaultOnChange() {}

class AppSelectableImage extends StatefulWidget {
  final String title;
  final String message;
  final File imageFile;
  final String imageUrl;

  final double width;
  final double height;

  final bool changeable;

  final Color messageColor;
  final Color titleColor;

  final Function onChange;
  final String defaultImage;

  AppSelectableImage({
    this.title = "",
    this.imageFile,
    this.changeable = true,
    this.width,
    this.height,
    this.defaultImage = "assets/images/camera.jpg",
    this.message = "Definir Foto",
    this.messageColor = AppColors.green,
    this.titleColor = AppColors.blue,
    this.onChange = _defaultOnChange,
    this.imageUrl,
  });

  AppSelectableImage.medium({
    title = "",
    imageFile,
    imageUrl,
    defaultImage = "assets/images/camera.jpg",
    titleColor = AppColors.blue,
    messageColor = AppColors.green,
    message = "Definir Foto",
    onChange = _defaultOnChange,
    changeable = true,
  }) : this(
          height: 180,
          width: 240,
          title: title,
          defaultImage: defaultImage,
          imageFile: imageFile,
          imageUrl: imageUrl,
          message: message,
          titleColor: titleColor,
          messageColor: messageColor,
          onChange: onChange,
          changeable: changeable,
        );

  AppSelectableImage.smallSqr({
    title = "",
    defaultImage,
    imageFile = "assets/images/camera.jpg",
    imageUrl,
    titleColor = AppColors.blue,
    messageColor = AppColors.green,
    message = "Definir Foto",
    changeable = true,
  }) : this(
          height: 90,
          width: 120,
          title: title,
          defaultImage: defaultImage,
          imageFile: imageFile,
          imageUrl: imageUrl,
          message: message,
          titleColor: titleColor,
          messageColor: messageColor,
          changeable: changeable,
        );

  @override
  _AppSelectableImageState createState() => _AppSelectableImageState(
        title,
        message,
        defaultImage,
        imageFile,
        width,
        height,
        changeable,
        messageColor,
        titleColor,
        onChange,
        imageUrl,
      );
}

class _AppSelectableImageState extends State<AppSelectableImage> {
  final String title;
  String message;
  final String defaultImage;
  final String imageUrl;

  File imageFile;

  final double width;
  final double height;

  final bool changeable;

  final Color messageColor;
  final Color titleColor;

  final Function onChange;

  Widget imageWidget;

  _AppSelectableImageState(
    this.title,
    this.message,
    this.defaultImage,
    this.imageFile,
    this.width,
    this.height,
    this.changeable,
    this.messageColor,
    this.titleColor,
    this.onChange,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    decoration = BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: AppColors.blue),
    );

    if (imageFile == null && imageUrl == null) {
      imageWidget = Image.asset(defaultImage, fit: BoxFit.cover);
      message = "Definir foto";
    } else if (imageFile == null && imageUrl != null) {
      imageWidget =
          Image.network(Endpoints.baseUrl + imageUrl, fit: BoxFit.cover);
      message = "Alterar foto";
    } else if (imageFile != null) {
      imageWidget = Image.file(imageFile, fit: BoxFit.cover);
      message = "Alterar foto";
    }

    return Column(
      children: <Widget>[
        if ("" != title) SizedBox(height: 16),
        if ("" != title)
          SkyText(
            title,
            fontSize: 18,
            textColor: titleColor,
            fontWeight: FontWeight.bold,
          ),
        if ("" != title) SizedBox(height: 8),
        Container(
          height: height,
          width: width,
          decoration: decoration,
          child: GestureDetector(
            onTap: _tryToSelectImage,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: imageWidget,
            ),
          ),
        ),
          Container(
            child: SkyFlatButton(
              textColor: messageColor,
              text: message,
              onPressed: _tryToSelectImage,
            ),
          ),
      ],
    );
  }

  void _tryToSelectImage() {
    try {
      if(changeable) {
        showAppConfirmPopup(
          context,
          "De onde deseja obter a imagem?",
          "Escolha uma opção.",
          "Da câmera",
            () {
            Navigator.pop(context);
            ImagePicker.pickImage(
              source: ImageSource.camera,
              maxHeight: 768,
              maxWidth: 1024,
              imageQuality: 80,
            ).then(_onImageSelected);
          },
          cancelOptionTitle: "Da galeria",
          onCancel: () {
            try {
              Navigator.pop(context);
              ImagePicker.pickImage(
                source: ImageSource.gallery,
                maxHeight: 768,
                maxWidth: 1024,
                imageQuality: 80,
              ).then(_onImageSelected);
            } catch (ignore) {}
          },
        );
      }
    } on PlatformException catch (e) {
      showMessageDialog(
        context,
        message: "Você precisa permitir que o AppCargo acesse suas fotos",
      );
    }
  }

  void _onImageSelected(File image) {
    if (null == image) {
      showMessageDialog(
        context,
        message: "Você precisa selecionar uma imagem!",
      );
    } else {
      setState(() {
        imageFile = image;
        onChange(image);
      });
    }
  }
}
