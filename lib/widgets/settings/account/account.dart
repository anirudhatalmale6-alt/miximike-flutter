import 'package:flutter/material.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  "assets/images/avatar.png",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "Luciano Sepúlveda",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Vogue Bold'
                    ),
                  ),
                  Text(
                    "correo@correounico.com",
                    style: TextStyle(
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
