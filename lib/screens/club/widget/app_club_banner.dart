import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AppClubBanner extends StatelessWidget {
  final String photo;
  final VoidCallback onClick;

  const AppClubBanner(
    this.photo, {
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: 666,
        child: Stack(
          children: <Widget>[
            if (null != photo) Center(child: CircularProgressIndicator()),
            if (null != photo)
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: photo,
                ),
              ),
            if (null == photo) Center(child: Text("Sem foto"))
          ],
        ),
      ),
      onTap: onClick,
    );
  }
}
