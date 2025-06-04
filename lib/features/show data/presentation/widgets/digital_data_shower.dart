import 'package:flutter/material.dart';

class DigitalDataShower extends StatefulWidget {
  final String label;
  final IconData iconData;
  final bool value;
  const DigitalDataShower({
    super.key,
    required this.label,
    required this.iconData,
    required this.value,
  });

  @override
  State<DigitalDataShower> createState() => _DigitalDataShowerState();
}

class _DigitalDataShowerState extends State<DigitalDataShower> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: w * .45,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white, width: .5),
          ),
          tileColor: Color(0xFF181C14),
          title: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFFECDFCC),
            ),
          ),
          leading: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.value ? Color(0xFF697565) : Color(0xff3d3100),),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                widget.iconData,
                size: 25,
                color: widget.value ? Color(0xFFECDFCC) : Color(0xFFffc412),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
