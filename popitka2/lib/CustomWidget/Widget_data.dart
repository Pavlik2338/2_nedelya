import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popitka2/const/Text.dart';

class DataTime extends StatefulWidget {
  final Function callback;

  DataTime({required this.callback});
  @override
  State<DataTime> createState() => _DataTimeState();
}

class _DataTimeState extends State<DataTime> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${date.year}/${date.month}/${date.day}'),
        ElevatedButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            setState(() {
              date = newDate;
              widget
                  .callback(DateFormat(appText.patternOfDate).format(newDate));
            });
          },
          child: const Text(appText.changeDate),
        )
      ],
    );
  }
}

class DataTimeChange extends StatefulWidget {
  final Function callback;
  DateTime oldDate;
  final int index;
  DataTimeChange(
      {required this.callback, required this.oldDate, required this.index});
  @override
  State<DataTimeChange> createState() => _DataTimeChangeState();
}

class _DataTimeChangeState extends State<DataTimeChange> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.oldDate.year}/${widget.oldDate.month}/${widget.oldDate.day}',
        ),
        ElevatedButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.oldDate,
                  firstDate: widget.oldDate,
                  lastDate: DateTime(2100));
              if (newDate == null) return;
              widget.oldDate = newDate;

              setState(() {
                widget.callback(
                    DateFormat(appText.patternOfDate).format(newDate),
                    widget.index);
              });
            },
            child: const Text(appText.changeDate))
      ],
    );
  }
}
