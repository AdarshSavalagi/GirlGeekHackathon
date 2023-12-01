import 'package:flutter/material.dart';
import 'package:hackathon_frontend/utils/constants.dart';
import 'package:lottie/lottie.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding * 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 600,
                width: 750,
                child: Lottie.asset("static/vector.json"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
