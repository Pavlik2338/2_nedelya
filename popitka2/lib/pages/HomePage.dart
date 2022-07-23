import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popitka2/CustomWidget/DropDownWIdget.dart';
import 'package:popitka2/CustomWidget/ColorWidget.dart';
import 'package:popitka2/CustomWidget/Widget_data.dart';
import 'package:popitka2/const/Text.dart';
import 'package:popitka2/const/Icon.dart';
import 'package:popitka2/const/Color.dart';
import 'package:popitka2/CustomWidget/DropMenuWidget.dart';
import 'package:popitka2/CustomWidget/DropMenuWidget.dart';

enum Prior { high, low, medium }

extension fromExtension on Prior {
  String get priorName {
    switch (this) {
      case (Prior.high):
        return appText.high;
      case (Prior.low):
        return appText.low;
      case (Prior.medium):
        return appText.medium;
    }
    return appText.low;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userAdd; //для добавлении новых таск, лучше не трогать
  bool missChooseDate = true;
  bool missChoose = true;
  void detected() {
    if (missChoose == true) {
      subTitle.add(subTitle.first);
      colorOfLevel.add(appColors.lowPriority);

      missChoose = false;
    }
  }

  void detectedDate() {
    if (missChooseDate == true) {
      taskDate.add(taskDate.first);
      taskDateOld.add(taskDateOld.first);
      missChooseDate = false;
    }
  }

  List<String> todoList = [
    appText.firstTask,
  ];
  List<Color> colorOfLevel = [
    appColors.lowPriority,
  ];
  List<String> subTitle = [
    appText.low,
  ];
  List<DateTime> taskDateOld = [
    DateTime.now(),
  ];

  List<String> taskDate = [
    DateFormat(appText.patternOfDate).format(
      DateTime.now(),
    ),
  ];

  void choose(item) {
    switch (item) {
      case (appText.low):
        {
          subTitle.add(item);
          colorOfLevel.add(appColors.lowPriority);
          missChoose = !missChoose;
        }

        break;
      case (appText.high):
        {
          subTitle.add(item);

          colorOfLevel.add(appColors.highPriority);
          missChoose = !missChoose;
        }
        break;
      case (appText.medium):
        {
          subTitle.add(item);
          colorOfLevel.add(appColors.mediumPriority);
          missChoose = !missChoose;
        }
        break;
    }
  }

  void change(item, index) {
    subTitle.removeAt(index);
    colorOfLevel.removeAt(index);
    switch (item) {
      case (appText.low):
        {
          subTitle.insert(index, item);
          colorOfLevel.insert(index, appColors.lowPriority);
        }

        break;
      case (appText.high):
        {
          subTitle.insert(index, item);
          colorOfLevel.insert(index, appColors.highPriority);
        }
        break;
      case (appText.medium):
        {
          subTitle.insert(index, item);
          colorOfLevel.insert(index, appColors.mediumPriority);
        }
        break;
    }
  }

  void dateCallbackAdd(newdate) {
    taskDate.add(newdate);
  }

  void dateCallbackChange(newDate, index) {
    taskDate.removeAt(index);
    taskDate.insert(index, newDate);
  }

  @override
  Widget build(BuildContext context) {
    // List<List> test=[todoList,colorOfLevel,subTitle,taskDate,taskDateOld];
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: appColors.maincolor,
      appBar: AppBar(
        backgroundColor: appColors.appBarColor,
        title: const Text(
          appText.appName,
          style: TextStyle(color: appColors.appBarText),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  onDismissed: (direction) {
                    setState(() {
                      colorOfLevel.removeAt(index);
                      todoList.removeAt(index);
                      subTitle.removeAt(index);
                      taskDate.removeAt(index);
                    });
                  },
                  key: Key(todoList[index]),
                  child: Column(
                    children: [
                      Card(
                        color: appColors.cardColor,
                        shadowColor: appColors.shadow,
                        elevation: 10,
                        child: ListTile(
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ColorWidget(
                                  priorColor: colorOfLevel[index],
                                  text: subTitle[index]),
                              Text(taskDate[index])
                            ],
                          ),
                          trailing: TextButton(
                              onPressed: () {
                                setState(() {
                                  colorOfLevel.removeAt(index);
                                  todoList.removeAt(index);
                                  subTitle.removeAt(index);
                                  taskDate.removeAt(index);
                                });
                              },
                              child: const Text(
                                appText.finish,
                                style: TextStyle(
                                    color: appColors.textColor,
                                    fontFamily: 'Foundation'),
                              )),
                          onLongPress: () {
                            var textControllerTask = TextEditingController();
                            textControllerTask.text = todoList[index];
                            userAdd = textControllerTask.text;
                            showDialog(
                              //окно изменить задачу
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: appColors.dialogColor,
                                  title: const Text(appText.changeTask),
                                  content: TextField(
                                    controller: textControllerTask,
                                    decoration: const InputDecoration(
                                      fillColor: appColors.white,
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        userAdd = value;
                                      });
                                    },
                                  ),
                                  actions: [
                                    DataTimeChange(
                                      callback: dateCallbackChange,
                                      oldDate: taskDateOld[index],
                                      index: index,
                                    ),
                                    // тут выпадающий список
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        DropWidgetChange(
                                            callback: change,
                                            name: subTitle[index],
                                            lastColor: colorOfLevel[index],
                                            index: index),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                todoList[index] = userAdd;
                                                Navigator.of(context).pop();
                                                textControllerTask.clear();
                                              });
                                            },
                                            child: const Text(appText.change)),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              textControllerTask.clear();
                                            },
                                            child: appIcon.cancel),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          title: Text(todoList[index]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: appColors.buttonColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: appColors.dialogColor,
                    title: const Text(appText.addTask),
                    content: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: appColors.white,
                          filled: true),
                      onChanged: (String value) {
                        setState(() {
                          userAdd = value;
                        });
                      },
                    ),
                    actions: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: DataTime(
                          callback: dateCallbackAdd,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropWidget(
                            callback: choose,
                            name: subTitle.last,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  detected();
                                  detectedDate();
                                  todoList.add(userAdd);
                                  missChoose = true;
                                  missChooseDate = true;
                                });
                                Navigator.of(context).pop();
                              },
                              child: appIcon.iconAdd),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: appIcon.cancel),
                        ],
                      )
                    ],
                  );
                });
          },
          child: appIcon.iconAdd),
    );
  }
}
