import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../models/datas/Drop_datas.dart';

class HomeController extends GetxController {
  var selectedActivity = ''.obs;
  var selectedDay = ''.obs;
  var selectedImage = ''.obs;
  var selectedHour = 1.obs;
  var selectedMinute = 5.obs;
  var totalSeconds = 0.obs;
  RxDouble progress = 1.0.obs;
  var initialTotalSeconds = 0.obs;
  Timer? timer;
  String timeDisplay = "00:00:00";
  AudioPlayer audioPlayer = AudioPlayer();

  void setSelectedActivity(String activity) {
    selectedActivity.value = activity;
    selectedImage.value = activityImages[activity] ?? '';
  }

  void setSelectedDay(String day) {
    selectedDay.value = day;
  }

  void setHour(int hour) {
    selectedHour.value = hour;
  }

  void setMins(int mins) {
    selectedMinute.value = mins;
  }

  void startTimer() {
    totalSeconds.value =
        (selectedHour.value * 3600) + (selectedMinute.value * 60);
    initialTotalSeconds.value = totalSeconds.value;
    progress.value = 1.0;

    timer?.cancel(); // Cancel any existing timer

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (totalSeconds.value > 0) {
        totalSeconds.value--;
        int hours = totalSeconds.value ~/ 3600;
        int minutes = (totalSeconds.value % 3600) ~/ 60;
        int seconds = totalSeconds.value % 3600 % 60;
        timeDisplay =
            "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        progress.value = totalSeconds.value / initialTotalSeconds.value;
      } else {
        timer.cancel();
        playSound();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Future<void> playSound() async {
    await audioPlayer.play(AssetSource('assets/alarm.mp3'));
  }

  @override
  void dispose() {
    timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }
}
