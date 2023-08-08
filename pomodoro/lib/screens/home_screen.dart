import 'package:flutter/material.dart';
import 'dart:async'; // Timer 사용하기 위해 import 함

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer;
  void onTick(Timer timer) {
    // periodic이 실행하는 함수는 그 인자로 Timer 자체를 받는다.
    if (totalSeconds == 0) {
      setState(() {
        totalSeconds = twentyFiveMinutes;
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds); // 초를 타이머로 바꿔준다.
    var timer = duration.toString().split(".").first.substring(2, 7);
    return timer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    format(totalSeconds),
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 89,
                        fontWeight: FontWeight.w600),
                  ),
                )),
            Flexible(
                flex: 2,
                child: Center(
                  child: IconButton(
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: isRunning
                          ? const Icon(Icons.pause_circle_outline)
                          : const Icon(Icons.play_circle_outlined)),
                )),
            Flexible(
                child: Row(
              children: [
                Expanded(
                  // 왼쪽에 있는 부분을 옆까지 확장시켜줌
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // 수직으로 가운데
                        children: [
                          Text('Pomodors',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color)),
                          Text("$totalPomodoros",
                              style: TextStyle(
                                  fontSize: 58,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color)),
                        ]),
                  ),
                ),
              ],
            ))
          ],
        ));
  }
}
