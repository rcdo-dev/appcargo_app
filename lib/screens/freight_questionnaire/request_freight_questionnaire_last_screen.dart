import 'package:flutter/material.dart';

import 'package:app_cargo/constants/app_colors.dart';

class RequestFreightQuetionaireLastScreen extends StatefulWidget {
  const RequestFreightQuetionaireLastScreen({
    Key key,
  }) : super(key: key);

  @override
  _RequestFreightQuetionaireLastScreenState createState() => _RequestFreightQuetionaireLastScreenState();
}

class _RequestFreightQuetionaireLastScreenState extends State<RequestFreightQuetionaireLastScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: size.height / 36,
            ),
            Text(
              'Sua solicitação de frete\nfoi feita com sucesso!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Container(
              height: size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Aguarde\num momento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: size.height / 5,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: size.height / 42,
                          right: size.width / 1.30,
                          child: Opacity(
                            opacity: 0.7,
                            child: Image.asset(
                              'assets/icons/ativo_4.png',
                              width: size.width / 2,
                              color: AppColors.gradient_green,
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height / 42,
                          left: size.width / 4,
                          child: Image.asset(
                            'assets/icons/ativo_8.png',
                            width: size.width / 2,
                          ),
                        ),
                        Positioned(
                          top: size.height / 42,
                          left: size.width / 1.30,
                          child: Opacity(
                            opacity: 0.7,
                            child: Image.asset(
                              'assets/icons/ativo_4.png',
                              width: size.width / 2,
                              color: AppColors.gradient_green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Estamos procurando os\nmelhores frete para você',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: size.width / 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Ok',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
