import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {

  const Calculator ({super.key});

  @override
  State<Calculator> createState() => _State();

}

class _State extends State<Calculator> {



  //main calculator backand Functionality

  String _outpurt = '0';
  String _input = '0';
  String _ope = '0';
  double num1 = 0;
  double num2 = 0;
  //total variable

  void buttonPress(String value)
  {
    print(value);
    setState(() {
      if(value == 'AC'){
        _outpurt = '0';
        _input = '0';
        _ope= '';
        num1 = 0;
        num2 = 0;
      }
      else if (value == 'D') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _outpurt = _input.isEmpty ? '0' : _input;
        }
      }
      else if(value == '='){
        num2 = double.parse(_input);
        if(_ope == '+'){
          _outpurt = (num1+num2).toString();
        }else if(_ope == '-'){
          _outpurt = (num1-num2).toString();

        }else if(_ope == 'x'){
          _outpurt = (num1*num2).toString();
        }else if(_ope == '÷'){
          _outpurt = (num2 !=0) ? (num1/num2).toString() : 'Error';
        }
        _input = _outpurt;
      }
      else if(['+','-','x','÷','%'].contains(value)){
        num1 = double.parse(_input);
        _ope = value;
        _input= '';

      }
      else{
        if(_input == '0'){
          _input = value;
        }else{
          _input += value;

        }
        _outpurt = _input;

      }
    });


  }


  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Calculator',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(ScreenWidth*0.05),
                child: Text(_outpurt,style: TextStyle(
                  fontSize: ScreenWidth*0.01,
                  fontWeight: FontWeight.bold,
                  color:Colors.white,
                ),),
              ),
            ),

            Row(
              children: [
                CalculatorButton(onClick: ()=> buttonPress('AC'), color: Colors.redAccent,text:'AC',),
                CalculatorButton(onClick: ()=> buttonPress('D'), color: Colors.yellow[800],text:'D',),
                CalculatorButton(onClick: ()=> buttonPress('%'), color: Colors.green[800],text:'%',),
                CalculatorButton(onClick: ()=> buttonPress('÷'), color: Colors.green[800],text:'÷',),
              ],
            ),
            Row(
              children: [
                CalculatorButton(onClick: ()=> buttonPress('7'), color: Colors.grey[800],text:'7',),
                CalculatorButton(onClick: ()=> buttonPress('8'), color: Colors.grey[800],text:'8',),
                CalculatorButton(onClick: ()=> buttonPress('9'), color: Colors.grey[800],text:'9',),
                CalculatorButton(onClick: ()=> buttonPress('x'), color: Colors.green[800],text:'x',),
              ],
            ),
            Row(
              children: [
                CalculatorButton(onClick: ()=> buttonPress('4'), color: Colors.grey[800],text:'4',),
                CalculatorButton(onClick: ()=> buttonPress('5'), color: Colors.grey[800],text:'5',),
                CalculatorButton(onClick: ()=> buttonPress('6'), color: Colors.grey[800],text:'6',),
                CalculatorButton(onClick: ()=> buttonPress('-'), color: Colors.green[800],text:'-',),
              ],
            ),
            Row(
              children: [
                CalculatorButton(onClick: ()=> buttonPress('1'), color: Colors.grey[800],text:'1',),
                CalculatorButton(onClick: ()=> buttonPress('2'), color: Colors.grey[800],text:'2',),
                CalculatorButton(onClick: ()=> buttonPress('3'), color: Colors.grey[800],text:'3',),
                CalculatorButton(onClick: ()=> buttonPress('+'), color: Colors.green[800],text:'+',),
              ],
            ),
            Row(
              children: [
                CalculatorButton(onClick:()=> buttonPress('0'), color: Colors.grey[800],text:'0',),
                CalculatorButton(onClick:()=> buttonPress('.'), color: Colors.grey[800],text:'.',),
                CalculatorButton(onClick: ()=> buttonPress('='), color: Colors.green[800],text:'=',),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


