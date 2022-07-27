import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentStep = 0;
  bool isCompleted = false;

  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final age = TextEditingController();
  final number = TextEditingController();
  final road = TextEditingController();
  final province = TextEditingController();
  final postcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('- F o r m -'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.indigo)),
        child: Stepper(
          steps: getSteps(),
          type: StepperType.vertical,
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              setState(() => isCompleted = true);
              print('Completed');
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text('Account'),
            content: Column(
              children: <Widget>[
                TextFormField(
                    controller: firstname,
                    decoration: InputDecoration(labelText: 'Firstname')),
                TextFormField(
                    controller: lastname,
                    decoration: InputDecoration(labelText: 'Lastname')),
                TextFormField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(labelText: 'Age')),
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Address'),
            content: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                      controller: number,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(labelText: 'Number')),
                  TextFormField(
                      controller: road,
                      decoration: InputDecoration(labelText: 'Road')),
                  TextFormField(
                      controller: province,
                      decoration: InputDecoration(labelText: 'Province')),
                  TextFormField(
                      controller: postcode,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(labelText: 'Postal Code')),
                ],
              ),
            )),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text('Complete'),
          content: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('FirstName : ${firstname.text}'),
                Text('Lastname : ${lastname.text}'),
                Text('Age : ${age.text}'),
                Text('Number : ${number.text}'),
                Text('Road : ${road.text}'),
                Text('Province : ${province.text}'),
                Text('Post Code : ${postcode.text}'),
              ],
            ),
          ),
        ),
      ];
}
