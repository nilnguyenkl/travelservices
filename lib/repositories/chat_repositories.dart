import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelservices/models/firebase_chat_model.dart';

class ChatRepository {
  
  // static createChatRoom(String docRoomId, RoomRequestModel model) async {
  //   final docRoom = FirebaseFirestore.instance.collection("rooms").doc(docRoomId);
  //   await docRoom.set(model.toJson());
  // }

  static sendMessage(ChatRequestModel model) async {
    await FirebaseFirestore.instance.collection("users")
      .doc(model.sendById.toString())
      .collection("messages")
      .doc(model.sendToId.toString())
      .collection('chats')
      .add(model.toJson()).then((value) {
        FirebaseFirestore.instance
        .collection("users")
        .doc(model.sendById.toString())
        .collection("messages")
        .doc(model.sendToId.toString())
        .set({'last_msg' : model.message
      });
    });
    await FirebaseFirestore.instance.collection("users")
      .doc(model.sendById.toString())
      .collection("messages")
      .doc(model.sendById.toString())
      .collection('chats')
      .add(model.toJson()).then((value) {
        FirebaseFirestore.instance
        .collection("users")
        .doc(model.sendToId.toString())
        .collection("messages")
        .doc(model.sendToId.toString())
        .set({'last_msg' : model.message
      });
    });
  }

  // static getListChat() async {
    
  //   List<String> list = [];

  //   var collection = FirebaseFirestore.instance.collection('chatroom');
  //   var querySnapshots = collection.doc().snapshots();

  //   querySnapshots.map((event) {
  //     list.add(event.reference.id);
  //   });

  //   print("HEHE: $list");
    
  //   return FirebaseFirestore.instance
  //   .collection('chatroom')
  //   .get();

  // }

}