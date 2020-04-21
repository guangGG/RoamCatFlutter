import 'package:flutter/material.dart';

///全局静态的ProgressDialog
class ProgressDialog {
  static OverlayEntry _overlayEntry;

  static void show(BuildContext context, {String msg}) {
    dismiss();
    OverlayEntry entry = new OverlayEntry(
      builder: (BuildContext context) {
        return Container(
          color: Colors.black38,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                //使用全局背景色
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              width: 160,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor),
                  ),
                  (msg != null)
                      ? Container(height: 15, width: 0)
                      : Container(width: 0),
                  (msg != null)
                      ? Text(
                          msg,
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Container(width: 0),
                ],
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(entry);
    _overlayEntry = entry;
  }

  static dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
