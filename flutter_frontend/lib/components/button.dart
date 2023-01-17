import 'package:flutter/material.dart';
import 'package:flutter_frontend/theme/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            foregroundColor: AppColors.whiteOpacity,
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size(200, 50),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/add-product");
          },
          child: const Text(
            "ADD FILME",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
