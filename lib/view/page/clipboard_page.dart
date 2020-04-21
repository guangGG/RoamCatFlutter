import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/view/widget/no_ripple_scroll_behavior.dart';

class ClipboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClipboardPageState();
  }
}

class _ClipboardPageState extends State<ClipboardPage> {
  String _text = "";

  @override
  void initState() {
    super.initState();
    updateText();
  }

  void updateText() {
    Clipboard.getData('text/plain').then((ClipboardData data) {
      setState(() {
        _text = data.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).clipboard),
        actions: <Widget>[
          Container(width: 15),
          Center(
            child: InkWell(
              child: Text(S.of(context).refresh),
              onTap: () {
                updateText();
              },
            ),
          ),
          Container(width: 15),
        ],
      ),
      body: buildNoRippleScrollWidget(Container(
        margin: EdgeInsets.all(10),
        child: Expanded(
          child: ListView(children: <Widget>[SelectableText(_text)]),
        ),
      )),
    );
  }
}
