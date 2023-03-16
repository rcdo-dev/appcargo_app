import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/600x400.png",
                  width: 160,
                  height: 160,
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Carregando..."),
            )
          ],
        ),
      ),
    );
  }
}
