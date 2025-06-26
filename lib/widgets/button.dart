import 'package:flutter/material.dart';
class CalculatorButton extends StatelessWidget {
  String text ;
  // Color? someSymbolColor;
  Color? color;
  final VoidCallback onClick;

  CalculatorButton({
    super.key,
    required this.onClick,
    required this.color,
    required this.text,
    // required this.someSymbolColor,
  });

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ScreenWidth*0.015),
        child: SizedBox(
          height: ScreenHeight*0.09,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenWidth*0.02)
                ),
                backgroundColor: color ?? Colors.grey[800],
              ),
              onPressed:onClick,
              child: Text(text,style: TextStyle(
                fontWeight:FontWeight.bold,
                fontSize: ScreenWidth*0.06,
                color: Colors.white,
              ),)),
        ),
      ),
    );
  }
}