import 'package:flutter/material.dart';
import 'package:flutter_demo/controller/hive_services.dart';
import 'package:flutter_demo/model/hive_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Future<List<NotificaitonModel>> fetchNotifications() async {
    return await getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('Notifications'),
        actions: [
          SizedBox(
            width: 20,
          ),
          Badge(
              label: Text('4'),
              isLabelVisible: true,
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.notifications,
                size: 40,
              )),
          SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder<List<NotificaitonModel>>(
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching notifications'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications'));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 20,
                          backgroundImage: AssetImage(
                            'assets/images/flight.jpg',
                          ),
                        ),
                        title: Text(notification.title),
                        subtitle: Text(notification.body),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
