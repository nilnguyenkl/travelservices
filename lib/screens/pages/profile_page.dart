import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/blocs/profile_bloc/profile_bloc.dart';
import 'package:travelservices/blocs/profile_bloc/profile_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/change_profile_arguments.dart';
import 'package:travelservices/screens/arguments/status_order_arguments.dart';
import 'package:travelservices/utils/bottom_sheet.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black
            ),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Api.getTokenLogin(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Text(
                      "Sign in to use more features. Moreover, it makes your experience even better.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(paddingWidth),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          BottomSheetCustom.requestLoginFunction(context);
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.blue.shade400)
                        ), 
                        child: const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Sign In/Sign Up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              );
            } else {
              return SafeArea(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder:(context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 1,
                                      child: SizedBox(
                                        height: 180,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${state.user?.infor.firstname ?? ""} ${state.user?.infor.lastname ?? ""}",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blue.shade400
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: hintText,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${state.user?.numOrderApproved ?? 0}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.blue.shade400
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 8,
                                                    ),
                                                    child: Container(
                                                      height: 35,
                                                      width: 3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(100),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(context, Routes.productByStatus, arguments: StatusOrderArguments(status: "waiting"));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: hintText,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${state.user?.numOrderWaiting ?? 0}",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.blue.shade400
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 4, color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color: Colors.black.withOpacity(0.1)
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(state.user?.infor.avatar ?? avatarDefault)
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: paddingWidth),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            child: Divider(
                                              thickness: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: paddingWidth),
                                            child: Text(
                                              "About the app",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              thickness: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          menuProfile("Introduce", Icons.info, (){
                                            Navigator.pushNamed(context, Routes.aboutAppPage);
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: paddingWidth),
                                          child: Text(
                                            "Manage",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        menuProfile("My Profile", Icons.person, (){
                                          Navigator.pushNamed(context, Routes.myprofilePage, arguments: ChangeProfileArguments(
                                            firstname: state.user?.infor.firstname, 
                                            lastname: state.user?.infor.lastname, 
                                            email: state.user?.infor.email, 
                                            phone: state.user?.infor.phone ?? "", 
                                            gender: state.user?.infor.sex ?? ""
                                          ));
                                        }),
                                        menuProfile("Change Password", Icons.key, (){
                                          Navigator.pushNamed(context, Routes.changepasswordPage);
                                        }),
                                        menuProfile(
                                          "Logout", 
                                          Icons.logout, 
                                          () async {
                                            // context.read<CartBloc>().add(CartResetEvent());
                                            SharedPreferencesCustom.setBoolCustom("isLogined", false);
                                            SharedPreferencesCustom.setStringCustom("accessToken", "");
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ),
                      ),
                    );
                  },
                )
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Text(
                    "Sign in to use more features. Moreover, it makes your experience even better.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(paddingWidth),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        BottomSheetCustom.requestLoginFunction(context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue.shade400)
                      ), 
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Sign In/Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                ),
              ],
            );
          }
        }
      ),
    );
  }

  Widget menuProfile(String text, IconData icon, GestureTapCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: const Color.fromARGB(255, 236, 235, 235),
          primary: Colors.black
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Icon(
                icon,
                size: 25,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: hintText,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              size: 35,
              color: Colors.blue.shade600,
            ),
          ]
        ),
      ),
    );
  }
}