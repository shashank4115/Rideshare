import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ridesharev2/model/location.dart';

class LocationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Send location
  Future<void> sendLocation(
      String reveiverID, double latitude, double longitude) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Location newLocation = Location(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: reveiverID,
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, reveiverID];
    ids.sort();
    String locationRoomId = ids.join("_");

    await _firestore
        .collection('location_rooms')
        .doc(locationRoomId)
        .collection('location')
        .add(newLocation.toMap());
  }

  //Get location
  Stream<QuerySnapshot> getLocation(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String locationRoomId = ids.join("_");

    return _firestore
        .collection('location_rooms')
        .doc(locationRoomId)
        .collection('locations')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
