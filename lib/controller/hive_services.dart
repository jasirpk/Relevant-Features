import 'package:flutter_demo/model/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addNotification(String title, String description) async {
  var box = await Hive.openBox<NotificaitonModel>('notifications');
  var note = NotificaitonModel(
    title: title,
    body: description,
  );
  await box.add(note);
}

Future<List<NotificaitonModel>> getNotifications() async {
  var box = await Hive.openBox<NotificaitonModel>('notifications');
  return box.values.toList();
}
