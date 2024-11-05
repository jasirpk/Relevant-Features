import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class NotificaitonModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String body;

  NotificaitonModel({
    required this.title,
    required this.body,
  });
}
