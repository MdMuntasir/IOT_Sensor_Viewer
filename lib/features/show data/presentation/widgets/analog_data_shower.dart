import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class AnalogDataShower extends StatefulWidget {
  final String sensor;
  final double value;
  final double minVal;
  final double maxVal;
  const AnalogDataShower({
    super.key,
    required this.value,
    this.maxVal = 100,
    this.minVal = 0,
    required this.sensor,
  });

  @override
  State<AnalogDataShower> createState() => _AnalogDataShowerState();
}

class _AnalogDataShowerState extends State<AnalogDataShower> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        AnimatedRadialGauge(
          duration: Duration(seconds: 1),
          value: widget.value,
          radius: 70,
          axis: GaugeAxis(
            min: widget.minVal,
            max: widget.maxVal,
            degrees: 180,
            style: const GaugeAxisStyle(
              cornerRadius: Radius.circular(20),
              thickness: 20,
              background: Color(0xFFECDFCC),
              segmentSpacing: 4,
            ),
            pointer: GaugePointer.needle(
              position: GaugePointerPosition.surface(
                offset: Offset(0, 12),
              ),
              border: GaugePointerBorder(
                color: Colors.white,
                width: 1.5,
              ),
              width: 15,
              height: 23,
              color: Color(0xFF181C14),
            ),
            progressBar: const GaugeProgressBar.rounded(
              color: Color(0xFF697565),
            ),
          ),
          builder: (context, child, value) => RadialGaugeLabel(
            value: value,
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFFECDFCC),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          widget.sensor,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFFECDFCC),
          ),
        )
      ],
    );
  }
}
