import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification(context) async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  //ios에서 앱 로드시 유저에게 권한요청
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);
  await notifications.initialize(initializationSettings,
      //알림 누를때 함수실행하고 싶으면 onSelectNotification: 함수명추가
      onSelectNotification: (payload) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Text('Redirected Page')));
  });
}

showNotification() async {
  var androidDetails = AndroidNotificationDetails(
    'flutter_dev', // 유니크한 알림 채널ID
    'Local Notification dev test', // 알림 종류 설명
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(
      1, // 개별 알림 ID
      '제목 부분 테스트',
      '내용이 나타나는 부분 테스트',
      NotificationDetails(android: androidDetails, iOS: iosDetails));
}
