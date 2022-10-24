import 'package:flutter/material.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/typeloginarguments.dart';
import 'package:travelservices/screens/pages/login_page.dart';

class BottomSheetCustom {

  static void requestLoginFunction(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
      ),
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return SizedBox(
          height: 180,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(paddingWidth, paddingWidth, paddingWidth, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.login, arguments: TypeLogin(false, "Admin"));
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
                        "Login with admin",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(paddingWidth),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.login, arguments: TypeLogin(true, "Customer"));
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
                        "Login with customer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  } 
}