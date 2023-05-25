import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  double? batteryPower;
  double? fc;
  double? intMemory;
  double? mobileWt;
  double? pxHeight;
  double? pxWidth;
  double? ram;
  double? scW;
  double? talkTime;

  Data({
    required this.batteryPower,
    required this.fc,
    required this.intMemory,
    required this.mobileWt,
    required this.pxHeight,
    required this.pxWidth,
    required this.ram,
    required this.scW,
    required this.talkTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'battery_power': batteryPower,
      'fc': fc,
      'int_memory': intMemory,
      'mobile_wt': mobileWt,
      'px_height': pxHeight,
      'px_width': pxWidth,
      'ram': ram,
      'sc_w': scW,
      'talk_time': talkTime,
    };
  }
}

Future<String> sendPredictionRequest(Data data) async {
  final url = Uri.parse('http://10.0.2.2:8000/predict');
  final headers = {'Content-Type': 'application/json'};
  final requestBody = json.encode(data.toJson());

  final response = await http.post(url, headers: headers, body: requestBody);

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData['prediction'];
  } else {
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}

class PageOne extends StatefulWidget {
  PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final _formKey = GlobalKey<FormState>();
  late Data _data;

  @override
  void initState() {
    super.initState();
    _data = Data(
      batteryPower: 0,
      fc: 0,
      intMemory: 0,
      mobileWt: 0,
      pxHeight: 0,
      pxWidth: 0,
      ram: 0,
      scW: 0,
      talkTime: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Price Prediction'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Battery Power'),
                  onChanged: (value) =>
                  _data.batteryPower = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Front Camera'),
                  onChanged: (value) => _data.fc = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Internal Memory'),
                  onChanged: (value) => _data.intMemory = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Mobile Weight'),
                  onChanged: (value) => _data.mobileWt = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Pixel Height'),
                  onChanged: (value) => _data.pxHeight = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Pixel Width'),
                  onChanged: (value) => _data.pxWidth = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'RAM'),
                  onChanged: (value) => _data.ram = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Screen Width'),
                  onChanged: (value) => _data.scW = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Talk Time'),
                  onChanged: (value) => _data.talkTime = double.parse(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendPredictionRequest(_data).then((prediction) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Prediction Result'),
                              content: Text('Prediction: $prediction'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }).catchError((error) {
                        // Handle request error
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(error.toString()),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
