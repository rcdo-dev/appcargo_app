import 'dart:async';

import 'package:flutter/material.dart';

import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/new_freight/driver_threads.dart';
import 'package:app_cargo/screens/freight_chat/widgets/app_threads.dart';
import 'package:app_cargo/services/freight_chat/freight_chat_service.dart';

import '../../routes.dart';

class FreightChatScreen extends StatefulWidget {
  @override
  _FreightChatScreenState createState() => _FreightChatScreenState();
}

class _FreightChatScreenState extends State<FreightChatScreen> {
  final FreightChatService _freightChatService = DIContainer().get<FreightChatService>();
  bool isLoad = true;

  void timerProgressIndicator() {
    Timer.periodic(Duration(seconds: 6), (time) {
      setState(() {
        isLoad = false;
      });
      time.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    timerProgressIndicator();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fretes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 18,
              margin: EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 5.0,
              ),
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.public,
                  color: AppColors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                color: AppColors.green,
                label: Text(
                  "PUBLICIDADE",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    Routes.attendanceChannel,
                  );
                },
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: driverThreadsStream(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<DriverThreads>> snapshot,
                ) {
                  if (snapshot.data == null || snapshot.data.isEmpty || snapshot.data.length == 0) {
                    if (isLoad) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.light_green,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.green,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("Nenhum frete encontrado"));
                    }
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return AppThreads(
                        driverThreads: snapshot.data[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<DriverThreads>> driverThreadsStream() async* {
    List<DriverThreads> freights;
    while (true) {
      List<DriverThreads> freights = await _freightChatService.getDriverThreads();
      yield freights;
      await Future.delayed(Duration(seconds: 60));
    }
  }
}
