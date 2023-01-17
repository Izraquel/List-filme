import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frontend/theme/app_colors.dart';
import 'package:flutter_frontend/theme/app_images.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight * 2.2,
    backgroundColor: AppColors.appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    flexibleSpace: SafeArea(
        child: Column(
      children: [
        Image.asset(AppImages.logo),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "NODEJS - CRUD APP",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    )),
  );
}
