import 'package:app_thuchi/widgets/thuchi_icon.dart';
import 'package:app_thuchi/widgets/thuchi_icons.dart';
import 'package:app_thuchi/widgets/thuchi_palette.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class FrappeAlert {
  static showAlert({
    @required String? icon,
    @required String? title,
    String? subtitle,
    @required BuildContext? context,
    @required MaterialColor? color,
    Duration aleartDuration = const Duration(seconds: 5),
  }) {
    FToast fToast = FToast();
    fToast.init(context!);

    var toast = Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: color![100],
      ),
      child: ListTile(
        title: Row(
          children: [
            FrappeIcon(
              icon!,
              color: color,
            ),
            SizedBox(
              width: 12.0,
            ),
            Flexible(
              child: Text(
                title!,
                style: TextStyle(
                  color: color[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: subtitle != null
            ? Row(
                children: [
                  SizedBox(
                    width: 36.0,
                  ),
                  Flexible(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: color[600],
                      ),
                    ),
                  )
                ],
              )
            : null,
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: aleartDuration,
    );
  }

  static infoAlert({
    @required String? title,
    String? subtitle,
    @required BuildContext? context,
  }) {
    FrappeAlert.showAlert(
      icon: FrappeIcons.info,
      title: title,
      context: context,
      color: FrappePalette.blue,
      subtitle: subtitle,
    );
  }

  static warnAlert({
    @required String? title,
    String? subtitle,
    @required BuildContext? context,
  }) {
    FrappeAlert.showAlert(
      icon: FrappeIcons.warning,
      title: title,
      context: context,
      color: FrappePalette.yellow,
      subtitle: subtitle,
    );
  }

  static errorAlert({
    @required String? title,
    String? subtitle,
    @required BuildContext? context,
  }) {
    FrappeAlert.showAlert(
      icon: FrappeIcons.error,
      title: title,
      context: context,
      color: FrappePalette.red,
      subtitle: subtitle,
    );
  }

  static successAlert({
    @required String? title,
    String? subtitle,
    @required BuildContext? context,
  }) {
    FrappeAlert.showAlert(
      icon: FrappeIcons.success,
      title: title,
      context: context,
      color: FrappePalette.darkGreen,
      subtitle: subtitle,
    );
  }
}
