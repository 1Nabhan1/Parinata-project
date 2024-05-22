import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parinata_project/presentation/home_screen/controller/Home_Controller.dart';
import 'package:parinata_project/presentation/home_screen/widgets/Clock_widget/Clock_widget.dart';

import 'models/datas/Drop_datas.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Obx(
          () => Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: homeController.selectedImage.value.isNotEmpty
                    ? DecorationImage(
                        image: AssetImage(homeController.selectedImage.value),
                        fit: BoxFit.cover)
                    : DecorationImage(image: AssetImage(''))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ClockWidget(),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Select the Day',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey.shade200),
                        child: DropdownButton<String>(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 5),
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: Colors.grey,
                          icon: Icon(Icons.expand_circle_down),
                          hint: const Text('Select the Day'),
                          value: homeController.selectedDay.value.isEmpty
                              ? null
                              : homeController.selectedDay.value,
                          items: day.map((String day) {
                            return DropdownMenuItem<String>(
                              value: day,
                              child: Text(day),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              homeController.setSelectedDay(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Select the Activity here',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey.shade200),
                        child: DropdownButton<String>(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 5),
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: Colors.grey,
                          icon: Icon(Icons.expand_circle_down),
                          hint: const Text('Select an activity'),
                          value: homeController.selectedActivity.value.isEmpty
                              ? null
                              : homeController.selectedActivity.value,
                          items: activities.map((String activity) {
                            return DropdownMenuItem<String>(
                              value: activity,
                              child: Text(activity),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              homeController.setSelectedActivity(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Adjust timer',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.shade200),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton<int>(
                              value: homeController.selectedHour.value,
                              items: hoursList.map((int hour) {
                                return DropdownMenuItem<int>(
                                  value: hour,
                                  child:
                                      Text("$hour hour${hour > 1 ? 's' : ''}"),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  homeController.setHour(newValue);
                                }
                              },
                            ),
                            DropdownButton<int>(
                              value: homeController.selectedMinute.value,
                              items: minutesList.map((int minute) {
                                return DropdownMenuItem<int>(
                                  value: minute,
                                  child: Text(
                                      "$minute minute${minute > 1 ? 's' : ''}"),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                if (newValue != null) {
                                  homeController.setMins(newValue);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: CircularProgressIndicator(
                            value: homeController.progress.value,
                            strokeWidth: 10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                homeController.timeDisplay,
                                style: TextStyle(fontSize: 48),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: CircleBorder()),
                        onPressed: homeController.startTimer,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.green,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: CircleBorder()),
                        onPressed: homeController.stopTimer,
                        child: Icon(
                          Icons.stop,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
