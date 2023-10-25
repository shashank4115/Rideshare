import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String latitude;
  final String longitude;
  final Timestamp timestamp;

  Location(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.latitude,
      required this.longitude,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}
