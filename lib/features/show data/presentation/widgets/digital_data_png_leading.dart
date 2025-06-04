import 'package:flutter/cupertino.dart';

class DigitalDataPngLeading extends StatefulWidget {
  final String label;
  final bool value;
  final String onImage;
  final String offImage;
  const DigitalDataPngLeading({
    super.key,
    required this.value,
    required this.onImage,
    required this.offImage,
    required this.label,
  });

  @override
  State<DigitalDataPngLeading> createState() => _DigitalDataPngLeadingState();
}

class _DigitalDataPngLeadingState extends State<DigitalDataPngLeading> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: w * .45,
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.white,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.value ? Color(0xFF697565) : Color(0xff163f42),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    widget.value ? widget.offImage : widget.onImage,
                    width: 30,
                  ),
                ),
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFECDFCC),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
