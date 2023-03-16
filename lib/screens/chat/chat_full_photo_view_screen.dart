import 'package:app_cargo/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ChatFullPhoto extends StatelessWidget {
  final String dateInfo;
  final CachedNetworkImageProvider image;

  ChatFullPhoto({
    Key key,
    @required this.image,
    this.dateInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text(dateInfo),
      ),
      body: ChatFullPhotoScreen(image: image),
    );
  }
}

class ChatFullPhotoScreen extends StatefulWidget {
  final CachedNetworkImageProvider image;

  ChatFullPhotoScreen({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  State createState() => new ChatFullPhotoScreenState(image: image);
}

class ChatFullPhotoScreenState extends State<ChatFullPhotoScreen> {
  final CachedNetworkImageProvider image;

  ChatFullPhotoScreenState({
    Key key,
    @required this.image,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: image,
        minScale: PhotoViewComputedScale.contained,
        maxScale: 4.0,
      ),
    );
  }
}
