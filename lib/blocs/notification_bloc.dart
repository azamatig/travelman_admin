import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:admin/config/config.dart';
import 'package:flutter/foundation.dart';

class NotificationBloc extends ChangeNotifier {
  

  Future sendNotification (title, description) async{
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Config().serverToken}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': description,
            'title': title
          },
          'priority': 'normal',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "/topics/all",
        },
      ),
    );
  }



  Future saveToDatabase(String timestamp, String title, String description) async {
    final DocumentReference ref = FirebaseFirestore.instance.collection('notifications').doc(timestamp);
    await ref.set({
      
      'title': title,
      'description': description,
      'created_at': DateTime.now(),
      'timestamp': timestamp,
      
    });
  }




}
