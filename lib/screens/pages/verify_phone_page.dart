import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:travelservices/screens/arguments/signupform.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var codeSMS = "";
  @override
  Widget build(BuildContext context) {
    final formData = ModalRoute.of(context)!.settings.arguments as SignUpForm;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
            borderRadius: BorderRadius.circular(20),
          ),
        );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        title: const Text(
          "Verification",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Verification code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  "We have sent the code verification to",
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  formData.phone,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                )
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onChanged: (value) {
                      codeSMS = value;
                    },
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.35,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.grey.shade400)
                          ), 
                          child: const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.35,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: formData.verify, smsCode: codeSMS);
                            await auth.signInWithCredential(credential).then((value) {
                              if (value.user != null) {
                                print("Success");
                              } else {
                                print("Failed");
                              }
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.green.shade400)
                          ), 
                          child: const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      )
                    ],    
                  )
                ],
              )
            ]
          ),
        ),
      )
    );
  }
}