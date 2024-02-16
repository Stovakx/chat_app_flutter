import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/message.dart';

class ChatService {
  //firestore a firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user Stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snaphot) {
      return snaphot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //vytvoření a odeslání zprávy
  Future<void> sendMessage(String receiverID, message) async {
    //přihlášený uživatel
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //vytvoření zprávy
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    //chatRoom speciální id
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //dostání zprávy 
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    
    //vytvoření chatovací místnosti
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}