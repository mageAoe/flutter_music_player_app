import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowSnackBar {
  static showSnackBar({required BuildContext context, required String text}) {
    final snackBar = SnackBar(
      backgroundColor: const Color.fromRGBO(243,244,246,1),
      content: Text(text, style:  TextStyle(color: Colors.black, fontSize: 40.sp, fontWeight: FontWeight.bold)),
      duration: const Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 48.0),
      margin: const EdgeInsets.only(bottom: 0.0),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showSnackBarIcon({required BuildContext context, required String text}) {
    final snackBar = SnackBar(
      elevation: 0,
      dismissDirection: DismissDirection.down,
      backgroundColor: Colors.grey[400],
      content: Row(children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Container(
            height: 0,
          ),
        ),
        Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 24,
            width: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.account_balance),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        ),
      ]),
      duration: const Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}