import 'package:flutter/material.dart';
import 'package:fluuter_chatgpt/widgets/drop_down.dart';

import '../constants/constant.dart';

class Services {
  static Future<void> showModalSheet(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: scaffoldBgCol,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Chosen Model:",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Flexible(
                flex: 2,
                child: ModelsDropDownWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
