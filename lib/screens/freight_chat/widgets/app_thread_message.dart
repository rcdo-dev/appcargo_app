import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/domain/new_freight/message/thread_message.dart';
import 'package:app_cargo/screens/chat/chat_audio_screen.dart';
import 'package:app_cargo/screens/chat/chat_full_photo_view_screen.dart';
import 'package:app_cargo/screens/chat/chat_full_video_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

typedef OnLeftSwipe = void Function(ThreadMessage message);
typedef OnRightSwipe = void Function(ThreadMessage message);

class AppThreadMessage extends StatefulWidget {
  final ThreadMessage message;
  final String threadHash;
  final OnLeftSwipe onLeftSwipe;
  final OnRightSwipe onRightSwipe;

  AppThreadMessage(
    this.message,
    this.threadHash, {
    @required this.onLeftSwipe,
    @required this.onRightSwipe,
  });

  @override
  _AppThreadMessageCardState createState() => _AppThreadMessageCardState();
}

class _AppThreadMessageCardState extends State<AppThreadMessage> {
  final regExpPhoneNumber = RegExp(
    '[0-9]{2}\-?[0-9]{4,5}\-?[0-9]{4}',
    multiLine: true,
  );

  final regExpWebLink = RegExp(
    r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?",
    multiLine: true,
  );

  @override
  Widget build(BuildContext context) {
    final align = widget.message.sentByDriver
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    Widget content;
    if (widget.message != null) {
      if (widget.message.content != null) {
        content = _buildDismissibleMessage(
          _buildTextMessage(context),
          Icons.error,
          Icons.delete,
        );
      } else if (widget.message.media != null) {
        if (widget.message.mediaContentType.contains("image")) {
          content = _buildDismissibleMessage(
            _buildImageMessage(context),
            Icons.error,
            Icons.delete,
          );
        } else if (widget.message.mediaContentType.contains("video")) {
          content = _buildDismissibleMessage(
            _buildVideoMessage(context),
            Icons.error,
            Icons.delete,
          );
        } else if (widget.message.mediaContentType.contains("audio")) {
          content = _buildDismissibleMessage(
            _buildAudioMessage(context),
            Icons.error,
            Icons.delete,
          );
        } else {
          if (widget.message.media.endsWith('.jpg')) {
            content = _buildDismissibleMessage(
              _buildImageMessage(context),
              Icons.error,
              Icons.delete,
            );
          } else if (widget.message.media.endsWith('.m4a')) {
            content = _buildDismissibleMessage(
              _buildAudioMessage(context),
              Icons.error,
              Icons.delete,
            );
          } else if (widget.message.media.endsWith('.mp4')) {
            content = _buildDismissibleMessage(
              _buildVideoMessage(context),
              Icons.error,
              Icons.delete,
            );
          } else {
            content = _buildDismissibleMessage(
              _buildUnrecognizedFileMessage(context),
              Icons.error,
              Icons.delete,
            );
          }
        }
      } else {
        content = _buildDismissibleMessage(
          _buildUnrecognizedFileMessage(context),
          Icons.error,
          Icons.delete,
        );
      }
    }

    // Continuar aqui!

    // else {
    //   content = CircularProgressIndicator();
    // }

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[content],
    );
  }

  Dismissible _buildDismissibleMessage(
    Widget messageWidget,
    IconData backgroundIcon,
    IconData secondBackgroundIcon,
  ) {
    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            widget.onLeftSwipe(this.widget.message);
          });
        } else if (direction == DismissDirection.startToEnd) {
          setState(() {
            widget.onRightSwipe(this.widget.message);
          });
        }
      },
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        color: AppColors.yellow,
        child: Icon(
          backgroundIcon,
          color: Colors.white,
          size: 30,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          secondBackgroundIcon,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: messageWidget,
    );
  }

  List<InlineSpan> _getLinkText({String text, Color fontColor}) {
    List<String> str = text.split(' ');
    var inlinetSpan = <InlineSpan>[];

    str.forEach((element) {
      if (regExpPhoneNumber.hasMatch(element)) {
        inlinetSpan.add(
          _buildLink(
            text: '$element',
            color: fontColor,
            onTap: () {
              _redirectionLink(number: element);
            },
          ),
        );
      } else if (regExpWebLink.hasMatch(element)) {
        inlinetSpan.add(
          _buildLink(
            text: '$element',
            color: fontColor,
            onTap: () {
              _redirectionLink(text: element);
            },
          ),
        );
      } else {
        inlinetSpan.add(
          TextSpan(
            text: ' $element ',
            style: TextStyle(
              fontSize: 16,
              color: fontColor,
            ),
          ),
        );
      }
    });

    return inlinetSpan;
  }

  TextSpan _buildLink({String text, Color color, VoidCallback onTap}) {
    return TextSpan(
      text: text,
      recognizer: TapGestureRecognizer()..onTap = onTap,
      style: TextStyle(
        color: color,
        fontSize: 16,
        decoration: TextDecoration.underline,
        decorationColor: color,
        decorationThickness: 1.8,
      ),
    );
  }

  Future<void> _redirectionLink({String number, String text}) async {
    final urlNumber = 'tel:$number';
    final urlText = text;

    if (number != null) {
      if (await canLaunch(urlNumber)) {
        await launch(urlNumber);
      }
    } else if (text != null) {
      if (await canLaunch(urlText)) {
        await launch(urlText);
      }
    } else {
      throw Exception('Erro ao redirecionar o link recebido!');
    }
  }

  Widget _buildTextMessage(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final align = widget.message.sentByDriver
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final backgroundColor =
        widget.message.sentByDriver ? AppColors.light_blue : AppColors.white;
    final color =
        widget.message.sentByDriver ? AppColors.white : AppColors.black;

    final radius = widget.message.sentByDriver
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            // width: size.width / 1.4,
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: AppColors.black.withOpacity(.12),
                )
              ],
              color: backgroundColor,
              borderRadius: radius,
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 48.0),
                      child: regExpPhoneNumber
                              .hasMatch(widget.message.content.trim())
                          ? RichText(
                              text: TextSpan(
                                children: _getLinkText(
                                  text: widget.message.content.trim(),
                                  fontColor: color,
                                ),
                              ),
                            )
                          : regExpWebLink
                                  .hasMatch(widget.message.content.trim())
                              ? RichText(
                                  text: TextSpan(
                                    children: _getLinkText(
                                      text: widget.message.content.trim(),
                                      fontColor: color,
                                    ),
                                  ),
                                )
                              : SkyText(
                                  widget.message.content.trim(),
                                  textColor: color,
                                  textAlign: TextAlign.left,
                                  fontSize: 16.0,
                                ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Row(
                        children: <Widget>[
                          SkyText(
                            "${DateFormat("HH:mm").format(
                              DateTime.parse(widget.message.sentAt),
                            )}",
                            textColor: color,
                            fontSize: 12.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    final align = widget.message.sentByDriver
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final backgroundColor =
        widget.message.sentByDriver ? AppColors.light_blue : AppColors.white;
    final color =
        widget.message.sentByDriver ? AppColors.white : AppColors.black;

    final CachedNetworkImageProvider image = CachedNetworkImageProvider(
      "https://plataforma.appcargo.com.br${widget.message.media}",
    );

    final radius = widget.message.sentByDriver
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Column(
          crossAxisAlignment: align,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: AppColors.black.withOpacity(.12),
                  )
                ],
                color: backgroundColor,
                borderRadius: radius,
              ),
              child: Column(
                children: <Widget>[
                  Image(
                    image: image,
                    width: 120.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: SkyText(
                      "${DateFormat("HH:mm").format(
                        DateTime.parse(widget.message.sentAt),
                      )}",
                      textColor: color,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatFullPhoto(
              image: image,
              dateInfo: "${DateFormat("dd-MM-yyyy HH:mm").format(
                DateTime.parse(widget.message.sentAt),
              )}",
            );
          }),
        );
      },
    );
  }

  Widget _buildAudioMessage(BuildContext context) {
    final align = widget.message.sentByDriver
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final backgroundColor =
        widget.message.sentByDriver ? AppColors.light_blue : AppColors.white;
    final backgroundColorSecondary =
        widget.message.sentByDriver ? AppColors.white : AppColors.light_blue;
    final color =
        widget.message.sentByDriver ? AppColors.white : AppColors.black;

    final radius = widget.message.sentByDriver
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Column(
          crossAxisAlignment: align,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: AppColors.black.withOpacity(.12),
                  )
                ],
                color: backgroundColor,
                borderRadius: radius,
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.mic,
                    color: backgroundColorSecondary,
                    size: 60.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: SkyText(
                      "${DateFormat("HH:mm").format(
                        DateTime.parse(widget.message.sentAt),
                      )}",
                      textColor: color,
                      fontSize: 12.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ChatAudioScreen(
              url: "https://plataforma.appcargo.com.br${widget.message.media}",
              dateInfo: "${DateFormat("dd-MM-yyyy HH:mm").format(
                DateTime.parse(widget.message.sentAt),
              )}",
            );
          },
        ));
      },
    );
  }

  Widget _buildVideoMessage(BuildContext context) {
    final align = widget.message.sentByDriver
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final backgroundColor =
        widget.message.sentByDriver ? AppColors.light_blue : AppColors.white;
    final backgroundColorSecondary =
        widget.message.sentByDriver ? AppColors.white : AppColors.light_blue;
    final color =
        widget.message.sentByDriver ? AppColors.white : AppColors.black;

    final radius = widget.message.sentByDriver
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Column(
          crossAxisAlignment: align,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(3.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: AppColors.black.withOpacity(.12),
                  )
                ],
                color: backgroundColor,
                borderRadius: radius,
              ),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.ondemand_video,
                    color: backgroundColorSecondary,
                    size: 70.0,
                  ),
                  SkyText(
                    "${DateFormat("HH:mm").format(
                      DateTime.parse(widget.message.sentAt),
                    )}",
                    textColor: color,
                    fontSize: 12.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatFullVideo(
              url: "https://plataforma.appcargo.com.br${widget.message.media}",
              dateInfo: "${DateFormat("dd-MM-yyyy HH:mm").format(
                DateTime.parse(widget.message.sentAt),
              )}",
            );
          }),
        );
      },
    );
  }

  Widget _buildUnrecognizedFileMessage(BuildContext context) {
    final align = widget.message.sentByDriver
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final backgroundColor =
        widget.message.sentByDriver ? AppColors.light_blue : AppColors.white;
    final backgroundColorSecondary =
        widget.message.sentByDriver ? AppColors.white : AppColors.light_blue;
    final color =
        widget.message.sentByDriver ? AppColors.white : AppColors.black;

    final radius = widget.message.sentByDriver
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );

    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: AppColors.black.withOpacity(.12),
                )
              ],
              color: backgroundColor,
              borderRadius: radius,
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: backgroundColorSecondary,
                  size: 70.0,
                ),
                SkyText(
                  "Arquivo não suportado\n\n${DateFormat("HH:mm").format(
                    DateTime.parse(widget.message.sentAt),
                  )}",
                  textColor: color,
                  fontSize: 12.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
