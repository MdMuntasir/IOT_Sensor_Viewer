import 'package:flutter/material.dart';

class SubscribeTopic extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback function;
  const SubscribeTopic({
    super.key,
    required this.controller,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      height: h * .25,
      width: w * .7,
      decoration: BoxDecoration(
          color: Color(0xFFECDFCC),
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [BoxShadow()]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            TextField(
              controller: controller,
              style: TextStyle(color: Color(0xFF181C14)),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                labelText: "Subscribe Topic",
              ),
            ),
            ElevatedButton(
              onPressed: function,
              child: Text("Subscribe"),
            )
          ],
        ),
      ),
    );
  }
}
