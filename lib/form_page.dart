import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'control_model.dart' as model;

class MyHomePage extends StatefulWidget {
  model.ControlsModel? controlForm;
  MyHomePage({this.controlForm, super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late model.ControlsModel controlModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controlForm == null) {
      var data = {
        "form": {
          "id": "12318391",
          "header": "Header of the form",
          "controls": [
            {
              "name": "Name of Project",
              "type": "Textbox",
              "header": "Project",
              "values": [],
              "defaultValue": "",
            },
            {
              "name": "Description",
              "type": "TextArea",
              "header": "Project Description",
              "values": [],
              "defaultValue": "",
            },
            {
              "name": "Coutries",
              "type": "Dropdown",
              "header": "Select Countries",
              "values": [
                "India",
                "US",
                "UK",
              ],
              "defaultValue": ""
            },
            {
              "name": "Country rank",
              "type": "RadioButton",
              "header": "Ranking",
              "values": [
                "1",
                "3",
              ],
              "defaultValue": "1",
            },
            {
              "name": "Hobbies",
              "type": "CheckBox",
              "header": "Hobbies",
              "values": [
                "Reading",
                "Cricket",
                "Footbool",
              ],
              "selectedValues": [
                "Cricket",
              ],
            },
            {
              "name": "Birth Date",
              "type": "Date",
              "header": "Birth Date",
              "values": [],
              "defaultValue": "",
              "minDate": "1996-05-18",
              "maxDate": "",
            },
          ]
        }
      };
      controlModel = model.ControlsModel.fromJson(data);
      print(controlModel);
    } else {
      controlModel = widget.controlForm!;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(controlModel.form.header),
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            itemCount: controlModel.form.controls.length,
            itemBuilder: (BuildContext context, int index) {
              var control = controlModel.form.controls[index];
              if (control.type == 'Textbox') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      control.header ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: control.name),
                      initialValue: control.defaultValue ?? '',
                      onChanged: (value) {
                        control.defaultValue = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    )
                  ],
                );
              } else if (control.type == 'TextArea') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      control.header ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: control.name),
                      initialValue: control.defaultValue ?? '',
                      minLines: 3,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        control.defaultValue = value;
                      },
                    )
                  ],
                );
              } else if (control.type == 'RadioButton') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      control.header ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: control.values!.length,
                        itemBuilder: (context, indexVal) {
                          var valuesData = control.values![indexVal];
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                child: Radio<String>(
                                  value: valuesData,
                                  groupValue: control.defaultValue,
                                  onChanged: (val) {
                                    control.defaultValue = val;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Text(valuesData),
                            ],
                          );
                        })
                  ],
                );
              } else if (control.type == 'CheckBox') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      control.header ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: control.values!.length,
                      itemBuilder: (context, indexVal) {
                        var valuesData = control.values![indexVal];
                        var selectedValue = control.selectedValues!.where((element) => element == valuesData).singleOrNull;
                        return Row(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Checkbox(
                                  value: selectedValue == null ? false : true,
                                  onChanged: (val) {
                                    setState(() {
                                      var selectedValue = control.selectedValues!.where((element) => element == valuesData).singleOrNull;
                                      if (selectedValue == null) {
                                        control.selectedValues!.add(valuesData);
                                      } else {
                                        control.selectedValues!.remove(selectedValue);
                                      }
                                    });
                                  }),
                            ),
                            Text(valuesData),
                          ],
                        );
                      },
                    )
                  ],
                );
              } else if (control.type == 'Dropdown') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      control.header ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(hintText: control.name),
                      value: control.defaultValue!.isEmpty ? null : control.defaultValue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      items: control.values!
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        control.defaultValue = value;
                      },
                    )
                  ],
                );
              } else if (control.type == 'Date') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      control.header ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: control.name),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      //initialValue: control.defaultValue ?? '',
                      controller: TextEditingController(text: control.defaultValue ?? ''),
                      onTap: () async {
                        try {
                          DateFormat inputFormat = DateFormat('yyyy-MM-dd');
                          var date = DateTime.now();
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: control.defaultValue!.isEmpty ? date : inputFormat.parse(control.defaultValue!),
                            firstDate: control.minDate!.isEmpty
                                ? (DateTime.now())
                                : DateTime.parse(control.minDate!), //DateTime.now() - not to allow to choose before today.
                            lastDate: control.maxDate!.isEmpty ? (DateTime.now()) : DateTime.parse(control.maxDate!),
                          );
                          if (pickedDate != null) {
                            print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = inputFormat.format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            //_dateController.text = formattedDate;
                            setState(() {
                              control.defaultValue = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        } catch (ex) {
                          print(ex);
                        }
                      },
                    )
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
      bottomNavigationBar: widget.controlForm == null
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    backgroundColor: Colors.deepPurple,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //controlModel.form.controls.where(test)
                    print("Data");
                    print(jsonEncode(controlModel.form.controls));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                controlForm: controlModel,
                              )),
                    );
                  }
                },
              ),
            )
          : SizedBox(
              height: 0,
            ),
    );
  }
}
