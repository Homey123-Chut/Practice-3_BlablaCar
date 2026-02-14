import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/ui/widgets/actions/bla_button.dart';


class ButtonTestScreen extends StatelessWidget {
  const ButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BlaButton Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlaButton(
              text: "Primary Button",
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            BlaButton(
              text: "Primary + Icon",
              icon: Icons.add,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            BlaButton(
              text: "Secondary Button",
              isPrimary: false,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            BlaButton(
              text: "Secondary + Icon",
              isPrimary: false,
              icon: Icons.edit,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            BlaButton(
              text: "Disabled Button",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: ButtonTestScreen(),
    ),
  );
}
