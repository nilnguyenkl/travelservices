import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: List.generate(10, (index) {
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
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(avatarDefault),
                                  radius: 35,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Nguyen Quoc Nil",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "assadasdasdasdasdasdadsadsad",
                                          style: TextStyle(
                                            fontSize: 17
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Container(
                                          constraints: BoxConstraints(minWidth: 100, maxWidth: MediaQuery.of(context).size.width*2.61/4),
                                          // color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          child: const Text(
                                            "2022-11-10",
                                            style: TextStyle(
                                              fontSize: 14
                                            ),
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
                }),
              ),
            ),
          )
        ],
      )
    );
  }
}