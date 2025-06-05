import 'package:contact_book/DBHelper.dart';
import 'package:contact_book/HomePage.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DBHelper().initDatacall().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("my_image/contact_image.png"))),
        ),
      ),
    );
  }
}
