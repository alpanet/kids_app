import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/theme.dart';

class CountdownComponent extends StatefulWidget {
  final Function onCompleteCallback;
  final CountDownController controller;
  const CountdownComponent(
      {super.key, required this.onCompleteCallback, required this.controller});

  @override
  _CountdownComponentState createState() => _CountdownComponentState();
}

class _CountdownComponentState extends State<CountdownComponent> {
  late final CountDownController _controller = widget.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 100,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2.5,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: AppTheme.secondBackgoundColor,
      fillGradient: null,
      backgroundColor: Colors.transparent,
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 33.0,
        color: AppTheme.secondBackgoundColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
        widget
            .onCompleteCallback();
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "00:00";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
