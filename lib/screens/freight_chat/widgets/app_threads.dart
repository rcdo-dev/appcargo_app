import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/domain/new_freight/driver_threads.dart';
import 'package:app_cargo/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:intl/intl.dart';

class AppThreads extends StatelessWidget {
  DriverThreads driverThreads;

  AppThreads({this.driverThreads});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.vibrate();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Remover frete",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                "Deseja mesmo remover este frete?",
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                SkyButton(
                  text: "Cancelar",
                  borderRadius: 5,
                  textColor: AppColors.black,
                  fontSize: 15,
                  buttonColor: AppColors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SkyButton(
                  text: "Apagar para mim",
                  borderRadius: 5,
                  textColor: AppColors.white,
                  fontSize: 15,
                  buttonColor: AppColors.green,
                  onPressed: () {},
                )
              ],
            );
          },
        );
      },
      onTap: () {
        Navigator.pushNamed(context, Routes.threadsDetails,
            arguments: {"thread_hash": this.driverThreads.hash});
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Origem: ${this.driverThreads.threadFreightSummary.from.cityName} "
                  "- ${this.driverThreads.threadFreightSummary.from.stateAcronym}",
                ),
                Text(
                    "Destino: ${this.driverThreads.threadFreightSummary.to.cityName} "
                    "- ${this.driverThreads.threadFreightSummary.to.stateAcronym}"),
                // Text("Recebido em: ${DateTime.parse(this.driverThreads.lastMessageSentAt)}"),
                Text(
                    "Recebido em: ${DateFormat("dd/MM/yyyy")
                        .format(DateTime.parse(this.driverThreads.lastMessageSentAt))}"
                    " às ${DateFormat("hh:mm").format(DateTime.parse(this.driverThreads.lastMessageSentAt))}"),
              ],
            ),
            // for (int i = 0; i < 24; i++)
            //   if (snapshot.data[index].durationTime ==
            //       i)
            //     Image.asset(
            //       "assets/images/ic_${snapshot.data[index].durationTime}_hours.png",
            //       // "assets/images/ic_2_hours.png",
            //       color: AppColors.green,
            //       height: 40,
            //     ),

                Image.asset(
                  "assets/images/ic_2_hours.png",
                  // "assets/images/ic_2_hours.png",
                  color: AppColors.green,
                  height: 40,
                ),
          ],
        ),
      ),
    );
  }
}
