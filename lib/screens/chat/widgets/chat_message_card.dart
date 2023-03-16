import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/domain/chat/message/message.dart';
import 'package:app_cargo/screens/chat/chat_audio_screen.dart';
import 'package:app_cargo/screens/chat/chat_full_photo_view_screen.dart';
import 'package:app_cargo/screens/chat/chat_full_video_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

typedef OnLeftSwipe = void Function(Message message);
typedef OnRightSwipe = void Function(Message message);

class ChatMessageCard extends StatefulWidget {
  Message message;
  bool isMe;
  OnLeftSwipe onLeftSwipe;
  OnRightSwipe onRightSwipe;

  ChatMessageCard(this.message, this.isMe,
      {@required this.onLeftSwipe, @required this.onRightSwipe});

  @override
  _ChatMessageCardState createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  @override
  Widget build(BuildContext context) {
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        if (widget.message.content["video"] != null)
          _buildDismissibleMessage(
              _buildVideoMessage(context), Icons.error, Icons.delete),
        if (widget.message.content["image"] != null)
          _buildDismissibleMessage(
              _buildImageMessage(context), Icons.error, Icons.delete),
        if (widget.message.content["audio"] != null)
          _buildDismissibleMessage(
              _buildAudioMessage(context), Icons.error, Icons.delete),
        if (widget.message.content["text"] != null)
          _buildDismissibleMessage(
              _buildTextMessage(context), Icons.error, Icons.delete),
      ],
    );
  }

  Dismissible _buildDismissibleMessage(Widget messageWidget,
      IconData backgroundIcon, IconData secondBackgroundIcon) {
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

  Widget _buildTextMessage(BuildContext context) {
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final backgroundColor =
        widget.isMe ? AppColors.light_blue : AppColors.white;
    final color = widget.isMe ? AppColors.white : AppColors.black;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDateWithoutTime = DateTime(
        widget.message.timestamp.toDate().year,
        widget.message.timestamp.toDate().month,
        widget.message.timestamp.toDate().day);
    final isToday = today == messageDateWithoutTime;
    final radius = widget.isMe
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
                    color: AppColors.black.withOpacity(.12))
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
                      child: SkyText(
                        widget.message.content["text"].toString().trim(),
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
                            "${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                            "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
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
          if (!isToday)
            Container(
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: SkyText(
                  "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                  "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                  "${widget.message.timestamp.toDate().year.toString()}",
                  textColor: AppColors.dark_grey,
                  fontSize: 12.0,
                ))
        ],
      ),
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final backgroundColor =
        widget.isMe ? AppColors.light_blue : AppColors.white;
    final color = widget.isMe ? AppColors.white : AppColors.black;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDateWithoutTime = DateTime(
        widget.message.timestamp.toDate().year,
        widget.message.timestamp.toDate().month,
        widget.message.timestamp.toDate().day);
    final isToday = today == messageDateWithoutTime;
    final CachedNetworkImageProvider image =
        CachedNetworkImageProvider(widget.message.content["image"]);
    final radius = widget.isMe
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
                      color: AppColors.black.withOpacity(.12))
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
                      "${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                      "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
                      textColor: color,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            if (!isToday)
              Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: SkyText(
                    "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                    "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                    "${widget.message.timestamp.toDate().year.toString()}",
                    textColor: AppColors.dark_grey,
                    fontSize: 12.0,
                  )),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatFullPhoto(
                image: image,
                dateInfo: isToday
                    ? "Hoje - ${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                        "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}"
                    : "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                        "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                        "${widget.message.timestamp.toDate().year.toString()} ${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                        "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
              ),
            ));
      },
    );
  }

  Widget _buildVideoMessage(BuildContext context) {
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final backgroundColor =
        widget.isMe ? AppColors.light_blue : AppColors.white;
    final backgroundColorSecondary =
        widget.isMe ? AppColors.white : AppColors.light_blue;
    final color = widget.isMe ? AppColors.white : AppColors.black;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDateWithoutTime = DateTime(
        widget.message.timestamp.toDate().year,
        widget.message.timestamp.toDate().month,
        widget.message.timestamp.toDate().day);
    final isToday = today == messageDateWithoutTime;
    final radius = widget.isMe
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
                      color: AppColors.black.withOpacity(.12))
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
                    "${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                    "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
                    textColor: color,
                    fontSize: 12.0,
                  ),
                ],
              ),
            ),
            if (!isToday)
              Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: SkyText(
                    "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                    "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                    "${widget.message.timestamp.toDate().year.toString()}",
                    textColor: AppColors.dark_grey,
                    fontSize: 12.0,
                  )),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatFullVideo(
                url: widget.message.content["video"],
                dateInfo: isToday
                    ? "Hoje - ${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                        "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}"
                    : "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                        "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                        "${widget.message.timestamp.toDate().year.toString()} ${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                        "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
              ),
            ));
      },
    );
  }

  Widget _buildAudioMessage(BuildContext context) {
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final backgroundColor =
        widget.isMe ? AppColors.light_blue : AppColors.white;
    final backgroundColorSecondary =
        widget.isMe ? AppColors.white : AppColors.light_blue;
    final color = widget.isMe ? AppColors.white : AppColors.black;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDateWithoutTime = DateTime(
        widget.message.timestamp.toDate().year,
        widget.message.timestamp.toDate().month,
        widget.message.timestamp.toDate().day);
    final isToday = today == messageDateWithoutTime;
    final radius = widget.isMe
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
                      color: AppColors.black.withOpacity(.12))
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
                      "${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                      "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
                      textColor: color,
                      fontSize: 12.0,
                    ),
                  )
                ],
              ),
            ),
            if (!isToday)
              Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: SkyText(
                    "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                    "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                    "${widget.message.timestamp.toDate().year.toString()}",
                    textColor: AppColors.dark_grey,
                    fontSize: 12.0,
                  )),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatAudioScreen(
                url: widget.message.content["audio"],
                dateInfo: isToday
                    ? "Hoje - ${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                        "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}"
                    : "${widget.message.timestamp.toDate().day.toString().padLeft(2, '0')}/"
                        "${widget.message.timestamp.toDate().month.toString().padLeft(2, '0')}/"
                        "${widget.message.timestamp.toDate().year.toString()} ${widget.message.timestamp.toDate().hour.toString().padLeft(2, '0')}:"
                        "${widget.message.timestamp.toDate().minute.toString().padLeft(2, '0')}",
              ),
            ));
      },
    );
  }
}
