import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled2/widget/button_widget.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key});

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final TextEditingController controller = TextEditingController();
  static const maxSeconds = 110;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          stopTimer(reset: false);
        }
      },
    );
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(35),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    setState(() {
                      seconds = int.parse(controller.text);
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              buildTimer(),
              const SizedBox(height: 40),
              buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'Pause' : 'Resume',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                  } else {
                    startTimer(reset: false);
                  }
                },
                backgroundColor: Colors.teal,
              ),
              const SizedBox(width: 15),
              ButtonWidget(
                text: 'Reset',
                onClicked: () {
                  stopTimer();
                },
                backgroundColor: Colors.teal,
              )
            ],
          )
        : ButtonWidget(
            text: 'Start',
            onClicked: () {
              startTimer();
            },
            backgroundColor: Colors.orangeAccent,
          );
  }

  Widget buildTimer() => SizedBox(
        height: 180,
        width: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              value: seconds / maxSeconds,
              backgroundColor: Colors.teal,
            ),
            Center(
              child: buildTime(),
            ),
          ],
        ),
      );

  Widget buildTime() {
    if (seconds == 0) {
      return const Icon(
        Icons.done,
        color: Colors.teal,
        size: 75,
      );
    } else {
      final hours = seconds ~/ 3600;
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      final showSeconds = remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';
      final showHours = hours < 10 ? '0$hours' : '$hours';
      final showMinutes = minutes < 10 ? '0$minutes' : '$minutes';
      final timeStr = hours > 0 ? '${showHours}hr :${showMinutes}min :${showSeconds}sec' : '${showMinutes}min :${showSeconds}sec';
      return Text(
        timeStr,
        style: const TextStyle(
          fontSize: 30,
        ),
      );
    }
  }
}
