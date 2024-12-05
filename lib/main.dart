import 'package:bmi_calculator/widgets/inputWidgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen)
            .copyWith(surface: Colors.lightGreen[100]),
        // brightness: Brightness.dark,
      ),
      home: const MyHomePage(
        title: 'BMI Calculator',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var inchController = TextEditingController();
  var feetController = TextEditingController();
  var weightController = TextEditingController();

  var result = "";
  dynamic bgColor = const LinearGradient(
    colors: [Color(0xffd4fc79), Color(0xff96e6a1)],
  );
  var message = "";
  var redColor = Colors.red[300];
  var greenColor = Colors.green[600];
  var dangerRed = Colors.red;
  var warningColor = Colors.orange[600];
  // ignore: prefer_typing_uninitialized_variables
  var msgColor;

  // Clearing function for text editing controller
  void clearText() {
    weightController.clear();
    feetController.clear();
    inchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        //color: bgColor,
        decoration: BoxDecoration(
          gradient: bgColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "BMI",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputField(
                    textController: weightController,
                    hintText: "Enter your weight in KG",
                    label: "Weight(kg)",
                    prefixIcon: const Icon(Icons.line_weight),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputField(
                    textController: feetController,
                    hintText: "Enter your height in feet",
                    label: "Height(ft)",
                    prefixIcon: const Icon(Icons.height),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  InputField(
                    textController: inchController,
                    hintText: "Enter your height in inch",
                    label: "Height(inch)",
                    prefixIcon: const Icon(Icons.height),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var weight = weightController.text;
                      var feet = feetController.text;
                      var inch = inchController.text;

                      if (weight != "" && feet != "" && inch != "") {
                        var intWeight = double.parse(weight);
                        var intFeet = double.parse(feet);
                        var intInch = double.parse(inch);

                        var heightInMeter = (intFeet * 12 + intInch) * 0.0254;
                        var bmi = (intWeight / (heightInMeter * heightInMeter));
                        var bmiString =
                            (intWeight / (heightInMeter * heightInMeter))
                                .toStringAsFixed(2);
                        result = "Your BMI is $bmiString";
                        setState(() {
                          if (bmi <= 18.5) {
                            message =
                                "Opps! you are Underweighted dude\nPlease eat more and sleep more";

                            // bgColor = orangeColor;
                            msgColor = Colors.red[300];
                          } else if (bmi > 18.5 && bmi <= 25) {
                            message =
                                "Congratulations! buddy \nYou are Healthy, Maintain it";
                            msgColor = greenColor;
                            // bgColor = greenColor;
                          } else if (bmi > 25 && bmi < 30) {
                            message =
                                "Opps! You are Overweighted\nIncrease your physical activity";
                            // bgColor = redColor;
                            msgColor = warningColor;
                          } else {
                            message =
                                "Oh no!!! Obesity\nKnow and Control Your Heart Health Numbers";
                            // bgColor = dangerRed;
                            msgColor = dangerRed;
                          }
                          clearText();
                        });
                      } else {
                        setState(() {
                          result = "Please fill all the required field";
                        });
                      }
                    },
                    child: const Text(
                      "Calculate",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      message = "";
                      result = "";
                      setState(() {});
                    },
                    child: const Text(
                      "Refresh",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: msgColor),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 18, color: msgColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
