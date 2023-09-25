import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_flutter/core/constant/color.dart';
import 'package:task_flutter/core/constant/imageasset.dart';

class CustomNoData extends StatelessWidget {
  const CustomNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: Get.height / 5,
          ),
          const Text(
            "No Data",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              "Make sure you are connected to the Internet \n or turn on a VPN,\n and then scroll down the page ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.5),
            ),
          ),
          Lottie.asset(AppImageAsset.noData,
              width: 250, height: 250),
        ],
      ),
    );
  }
}
