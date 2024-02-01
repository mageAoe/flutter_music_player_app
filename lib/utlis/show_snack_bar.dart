import 'package:flutter/material.dart';

class ShowSnackBar {
  static showSnackBar({required BuildContext context, required String text}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.purple,
      content: Text(text),
      duration: const Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // margin: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 48.0),
      behavior: SnackBarBehavior.floating,
      // action: SnackBarAction(
      //   label: "close",
      //   onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      // ),
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