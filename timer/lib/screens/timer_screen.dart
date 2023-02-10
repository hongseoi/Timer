import 'dart:async'; //타이머 클래스 제공하는 패키지
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:timer/style/TextStyle.dart';
import 'package:timer/tools/utils.dart';

//time status 선언
enum TimerStatus {running, paused, stopped, resting}

//time screen 선언
class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  //state 정의(앱에서 관리할 상태 변수)
  static const WORK_SECONDS = 25; //*60 min
  static const REST_SECONDS = 5;  //*60

  late TimerStatus _timerStatus; //타이머의 상태
  late int _timer; //타이머 시간
  late int _pomodoroCount; //뽀모도로 개수


  @override
  void initState() { 
    //override 통해 상태 초기값 설정
    super.initState();
    _timerStatus = TimerStatus.stopped; //타이머 상태: 정지상태
    print(_timerStatus.toString());
    _timer = WORK_SECONDS; //남은시간 = WORKSECONDS(25초)
    _pomodoroCount = 0;
  }

  String secondsToString(int seconds){
    return sprintf('%2d:%2d', [seconds ~/60, seconds%60]);

  }

  //타이머 이벤트
  void run(){
    setState(() {
      _timerStatus = TimerStatus.running;
      print("[=>]" + _timerStatus.toString());
      runTimer();//타이머 실행
    });
  }

  void stop(){
    setState(() {
      _timer = WORK_SECONDS; //타이머 시간을 초기값으로 변경
      _timerStatus = TimerStatus.stopped;
      print("[=>]" + _timerStatus.toString());
    });
  }

  void rest(){
    setState(() {   
      _timer = REST_SECONDS;
      _timerStatus = TimerStatus.resting;
      print("[=>]" + _timerStatus.toString());      
    });
  }

  void pause(){
    setState(){
      _timerStatus = TimerStatus.paused;
      print("[=>]" + _timerStatus.toString());
    }
  }

  void resume(){
    run(); //다시시작
  }

  void runTimer() async{
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      switch (_timerStatus){
        case TimerStatus.paused:
          t.cancel(); //0초가 되어 타이머 종료
          break;
        case TimerStatus.stopped:
          t.cancel();
          break;
        case TimerStatus.running:
          if (_timer <= 0){
            showToast("작업 완료!");
            rest();
          }else{
            setState(() {
              _timer -= 1;
            });
          }
          break;
        case TimerStatus.resting:
          if (_timer <= 0){
            setState(() {
              _pomodoroCount += 1;
            });
            showToast('오늘 $_pomodoroCount개의 뽀모도로를 달성했습니다.');
            t.cancel();
            stop();
          }else{
            setState(() {
              _timer -= 1;
            });
          }
          break;
        default:
          break;        
      }
     });
  }


  @override
  Widget build(BuildContext context){
    final List<Widget> _runningButtons = [
      ElevatedButton(
        child: Text(
          1 == 2 ? '계속하기':'일시정지',
          style: TextStyles.dark_15,
        ),
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: _timerStatus == TimerStatus.paused? resume: pause, 

        ),
        ElevatedButton(
          onPressed: stop, 
          child: Text(
            '포기하기',
            style: TextStyles.dark_15,
          ),
          style: ElevatedButton.styleFrom(primary: Colors.grey),
        ),
    ];

    final List<Widget> _stoppedButtons = [
      ElevatedButton(onPressed: run, 
      child: Text(
        '시작하기',
        style: TextStyles.dark_15,
      ),
      style: ElevatedButton.styleFrom(
        primary: 1==2? Colors.green: Colors.blue,
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
            ),
        ]
        ),
    );

  }
}