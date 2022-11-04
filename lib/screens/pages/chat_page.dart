import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/screens/arguments/current_user_arguments.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments as CurrentArguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Contacts",
          style: TextStyle(
            color: Colors.black
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue.shade600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1), 
          child: Container(
            color: searchbar, 
            width: double.infinity, 
            height: 1
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: paddingWidth),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: searchbar,
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
                hintText: "Search",
                hintStyle: const TextStyle(
                  color: hintText
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
                )
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(args.id.toString())
                  .collection('messages')
                  .snapshots(),
                builder:(context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No Chats Available"),
                      );
                    } else {
                      return Column(
                        children: List.generate(snapshot.data!.docs.length, (index) {
                          var friendId = snapshot.data!.docs[index].id;
                          var lastMsg = snapshot.data!.docs[index]['last_msg'];
                          return FutureBuilder(
                            future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                            builder:(context, asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                var friend = asyncSnapshot.data as DocumentSnapshot;
                                return GestureDetector(
                                  onTap: () {
                                    print("1");
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(friend['avatar'].isEmpty ? avatarDefault : friend['avatar']),
                                                radius: 35,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        friend['firstname'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        lastMsg,
                                                        style: const TextStyle(
                                                          fontSize: 17
                                                        ),
                                                      ),       
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.red,
                                                ),
                                                child: Text("12"),
                                              )                              
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(thickness: 2)
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        }),
                      );
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ),
          )
        ],
      )
    );
  }
}