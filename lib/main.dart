import 'package:flutter/material.dart';

import 'main_axis.dart';
import 'object_line.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concave Lens Simulation App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController focusController = TextEditingController();
  TextEditingController shadowDistanceController = TextEditingController();
  TextEditingController shadowHeightController = TextEditingController();
  // tinggi objek sementara
  double heightValue = 20.0;
  // tinggi objek sementara
  double distanceValue = 20.0;
  // jarak titik fokus
  double focusValue = 0.0;
  // validasi height
  bool heightIsInRange = true;
  // validasi distance
  bool distanceIsInRange = true;
  // validasi focus
  bool focusIsInRange = true;

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // jarak bayangan ke cermin
    double shadowDistanceFormula = (1 / focusValue) - (1 / distanceValue);
    double shadowDistance = (1 / shadowDistanceFormula);
    // tinggi bayangan
    double shadowHeight = shadowDistance * heightValue / distanceValue;

    // slider tinggi objek
    var verticalSlider = Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
      ),
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.height / 1.25,
          child: Slider(
            value: heightValue,
            onChanged: (double newHeight) {
              setState(() {
                heightValue = newHeight;
                heightController.text = newHeight.toString();
              });
            },
            min: 20.0,
            max: MediaQuery.of(context).size.height / 1.25 - 20.0,
          ),
        ),
      ),
    );

    var textController = Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 24.0),
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          children: [
            // height controller
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Ukuran Benda:')),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: heightIsInRange ? null : "Out of Range!",
                    ),
                    onChanged: (newValue) {
                      setState(
                        () {
                          if (20.0 <= double.parse(newValue) &&
                              double.parse(newValue) <=
                                  (MediaQuery.of(context).size.height / 1.25 -
                                      20.0)) {
                            heightValue = double.parse(newValue);
                            heightIsInRange = true;
                          } else {
                            heightIsInRange = false;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // distance controller
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Jarak Benda:')),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    controller: distanceController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: distanceIsInRange ? null : "Out of Range!",
                    ),
                    onChanged: (newValue) {
                      setState(
                        () {
                          if (20.0 <= double.parse(newValue) &&
                              double.parse(newValue) <=
                                  (MediaQuery.of(context).size.width / 1.25 -
                                      20.0)) {
                            distanceValue = double.parse(newValue);
                            distanceIsInRange = true;
                          } else {
                            distanceIsInRange = false;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // focus controller
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Titik Fokus Cermin:')),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    controller: focusController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: focusIsInRange ? null : "Out of Range!",
                    ),
                    onChanged: (newValue) {
                      setState(
                        () {
                          if (0.0 <= double.parse(newValue) &&
                              double.parse(newValue) <=
                                  ((MediaQuery.of(context).size.width / 1.5) /
                                      2)) {
                            focusValue = double.parse(newValue);
                            focusIsInRange = true;
                          } else {
                            focusIsInRange = false;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // shadow distance controller
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Jarak Bayangan:')),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    enabled: false,
                    controller: shadowDistanceController,
                    decoration: InputDecoration(
                      hintText: shadowDistance.toString(),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Tinggi Bayangan:')),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    enabled: false,
                    controller: shadowHeightController,
                    decoration: InputDecoration(
                      hintText: shadowHeight.toString(),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Slider jarak benda ke cermin
    var distanceSlider = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Slider(
          value: distanceValue,
          onChanged: (double newDistance) {
            setState(() {
              distanceValue = newDistance;
              distanceController.text = newDistance.toString();
            });
          },
          min: 20.0,
          max: MediaQuery.of(context).size.width / 1.5 - 20.0,
        ),
      ),
    );

    // Slider titik fokus
    var focusSlider = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: Slider(
            value: focusValue,
            onChanged: (double newFocus) {
              setState(() {
                focusValue = newFocus;
                focusController.text = newFocus.toString();
              });
            },
            min: 0.0,
            max: (MediaQuery.of(context).size.width / 1.5) / 2,
          ),
        ),
      ),
    );

    // canvas buat garis
    var canvas = Container(
      margin: const EdgeInsets.only(top: 8.0, right: 24.0, left: 24.0),
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 1.25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const MainAxis(),
          Positioned(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.25,
            child: ObjectLine(
              heightValue: heightValue,
              distanceValue: distanceValue,
              shadowDistance: shadowDistance,
              shadowHeight: shadowHeight,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              focusSlider,
              distanceSlider,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSlider,
              canvas,
              textController,
            ],
          ),
        ],
      ),
    );
  }
}
