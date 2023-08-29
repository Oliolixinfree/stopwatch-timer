import 'dart:async';
import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = const Duration();
  Timer? timer;
  bool isCountdown = false;

  @override
  void initState() {
    super.initState();

    // starTimer();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds <= 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }

      duration = Duration(seconds: seconds);
    });
  }

  void starTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTime(),
              const SizedBox(
                height: 80,
              ),
              buildButtons(),
            ],
          ),
        ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  fixedSize: const Size(100, 50),
                ),
                onPressed: () {
                  if (isRunning) {
                    stopTimer(resets: false);
                  } else {
                    starTimer(resets: false);
                  }
                },
                child: Text(
                  isRunning ? 'STOP' : 'RESUME',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  fixedSize: const Size(100, 50),
                ),
                onPressed: stopTimer,
                child: const Text(
                  'CANCEL',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          )
        : TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              fixedSize: const Size(150, 50),
            ),
            onPressed: () {
              starTimer();
            },
            child: const Text(
              'Start Timer',
              style: TextStyle(fontSize: 18),
            ),
          );
  }

  Widget buildTime() {
    // 9 --> 09
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTimeCard(time: hours, header: 'hours'),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: minutes, header: 'minutes'),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: seconds, header: 'seconds'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 72),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            header.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );
}
