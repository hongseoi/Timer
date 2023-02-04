import 'dart:html';

import 'package:flutter/material.dart';
import 'package:timer/style/TextStyle.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context){
    final List<Widget> _runningButtons = [
      ElevatedButton(
        onPressed: (){}, 
        child: Text(
          1 == 2 ? '계속하기':'일시정지',
          style: TextStyles.dark_15,
        ),
        style: ElevatedButton.styleFrom(primary: Colors.red),
        ),
        ElevatedButton(
          onPressed: (){}, 
          child: Text(
            '포기하기',
            style: TextStyles.dark_15,
          ),
          style: ElevatedButton.styleFrom(primary: Colors.grey),
        ),
    ];

    final List<Widget> _stoppedButtons = [
      ElevatedButton(onPressed: (){}, 
      child: Text(
        '시작하기',
        style: TextStyles.dark_15,
      ),
      style: ElevatedButton.styleFrom(
        primary: 1 == 2? Colors.green: Colors.blue,
      ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('타이머'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.height*0.5,
            child: Center(
              child: Text(
              '00:00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: 1 == 2 ? Colors.green:Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 1 == 2? 
            const [] : 1== 2? 
            _stoppedButtons:_runningButtons,
            )

        ]
        ),
    );

  }
}