import 'package:flutter/material.dart';
import 'package:popitka2/const/Color.dart';
import 'package:popitka2/const/Icon.dart';
import 'package:popitka2/const/Text.dart';

class DropWidget extends StatefulWidget {
  final Function callback;
  final String? name;

  DropWidget({
    required this.callback,
    required this.name,
  });
  @override
  DropWidgetState createState() => DropWidgetState();
}

class DropWidgetState extends State<DropWidget> {
  String valueOfDownButton = appText.low;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(8),
      value: valueOfDownButton,
      icon: appIcon.arrowDown,
      underline: Container(
        color: appColors.dialogColor,
        height: 2,
      ),
      items: <String>[appText.high, appText.low, appText.medium]
          .map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? item) {
        setState(() {
          widget.callback(
            item,
          );
          valueOfDownButton = item!;
        });
      },
    );
  }
}

class DropWidgetChange extends StatefulWidget {
  final Function callback;
  final String? name;
  final Color lastColor;
  final int index;
  DropWidgetChange(
      {required this.callback,
      required this.name,
      required this.lastColor,
      required this.index});
  @override
  DropWidgetChangeState createState() => DropWidgetChangeState();
}

class DropWidgetChangeState extends State<DropWidgetChange> {
  String valueOfDownButton = appText.low;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(8),
      value: valueOfDownButton,
      icon: appIcon.arrowDown,
      underline: Container(
        color: appColors.dropDownButton,
        height: 2,
      ),
      items: <String>[appText.high, appText.low, appText.medium]
          .map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? item) {
        setState(() {
          widget.callback(item, widget.index);
          valueOfDownButton = item!;
        });
      },
    );
  }
}
