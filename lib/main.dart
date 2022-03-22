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
      debugShowCheckedModeBanner: false,
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
  double heightValue = 80.0;
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

    var inputController = Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
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
                const SizedBox(width: 8.0),
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
                          if ((-MediaQuery.of(context).size.height / 2.5) +
                                      80.0 <=
                                  double.parse(newValue) &&
                              double.parse(newValue) <=
                                  (MediaQuery.of(context).size.height / 2.5) -
                                      80.0) {
                            heightValue = -double.parse(newValue) +
                                (MediaQuery.of(context).size.height / 2.5);
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
            const SizedBox(
              height: 8.0,
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
                const SizedBox(width: 16.0),
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
                          if ((-MediaQuery.of(context).size.width / 3) + 20.0 <=
                                  double.parse(newValue) &&
                              double.parse(newValue) <=
                                  ((MediaQuery.of(context).size.width / 3) -
                                      20.0)) {
                            distanceValue = -double.parse(newValue) +
                                (MediaQuery.of(context).size.width / 3);
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
            const SizedBox(
              height: 8.0,
            ),
            // focus controller
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Titik Fokus:')),
                const SizedBox(width: 24.0),
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
          ],
        ));

    var outputController = Padding(
        padding: const EdgeInsets.only(right: 24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: const Text('Jarak Bayangan:')),
                const SizedBox(width: 8.0),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    enabled: false,
                    controller: shadowDistanceController,
                    decoration: InputDecoration(
                      hintText: shadowDistance == 0.0
                          ? null
                          : shadowDistance.toString(),
                      hintStyle: const TextStyle(color: Colors.black),
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
                const SizedBox(width: 8.0),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  width: 120,
                  child: TextField(
                    enabled: false,
                    controller: shadowHeightController,
                    decoration: InputDecoration(
                      hintText: shadowHeight.abs() == 0.0
                          ? null
                          : (-shadowHeight).toString(),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

    // slider tinggi objek
    var heightSlider = Slider(
      value: heightValue,
      onChanged: (double newHeight) {
        setState(() {
          heightValue = newHeight;
          heightController.text = newHeight <
                  (MediaQuery.of(context).size.height / 2.5)
              ? ((newHeight - (MediaQuery.of(context).size.height / 2.5)).abs())
                  .toString()
              : (-(newHeight - (MediaQuery.of(context).size.height / 2.5)))
                  .toString();
        });
      },
      min: 80.0,
      max: MediaQuery.of(context).size.height / 1.25 - 80.0,
    );

    // Slider jarak benda ke cermin
    var distanceSlider = Slider(
      value: distanceValue,
      onChanged: (double newDistance) {
        setState(() {
          distanceValue = newDistance;
          distanceController.text = newDistance <
                  (MediaQuery.of(context).size.width / 3)
              ? ((newDistance - (MediaQuery.of(context).size.width / 3)).abs())
                  .toString()
              : (-(newDistance - (MediaQuery.of(context).size.width / 3)))
                  .toString();
        });
      },
      min: 20.0,
      max: MediaQuery.of(context).size.width / 1.5 - 20.0,
    );

    // Slider titik fokus
    var focusSlider = Slider(
      value: focusValue,
      onChanged: (double newFocus) {
        setState(() {
          focusValue = newFocus;
          focusController.text = newFocus.toString();
        });
      },
      min: 0.0,
      max: (MediaQuery.of(context).size.width / 1.5) / 2,
    );

    var sliderContainer = Expanded(
        child: Container(
      margin: const EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Slider Ukuran Benda:'),
          heightSlider,
          const Text('Slider Jarak Benda:'),
          distanceSlider,
          const Text('Slider Titik Fokus:'),
          focusSlider,
        ],
      ),
    ));

    // canvas buat garis
    var canvas = Expanded(
        child: Container(
      margin: const EdgeInsets.only(top: 16.0, right: 24.0, left: 24.0),
      // width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 1.25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
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
          Transform.translate(
            offset:
                Offset(-focusValue, MediaQuery.of(context).size.height / 60),
            child: const SizedBox(
                width: 10,
                height: 20,
                child: Text("f",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          ),
          Transform.translate(
            offset: Offset(
                -shadowDistance, MediaQuery.of(context).size.height / 60),
            child: const SizedBox(
                width: 10,
                height: 20,
                child: Text("r",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          )
        ],
      ),
    ));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          canvas,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              children: [
                sliderContainer,
                inputController,
                outputController,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
