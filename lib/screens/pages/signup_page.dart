import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.04),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.jpg",
                  height: 150,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          prefixIcon: const Icon(Icons.person),
                          label: const Text("Username"),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                prefixIcon: const Icon(Icons.person),
                                label: const Text("Lastname"),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                prefixIcon: const Icon(Icons.person),
                                label: const Text("Firstname"),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          prefixIcon: const Icon(Icons.email),
                          label: const Text("Email"),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          label: const Text("Phone"),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black38
                          ),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: (){},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Male",
                                    style: TextStyle(
                                      color: Colors.black54
                                    ),
                                  )
                                ),
                              )
                            ),
                            const VerticalDivider(width: 2, color: Colors.black,),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: (){},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Female",
                                    style: TextStyle(
                                      color: Colors.black54
                                    ),
                                  )
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          prefixIcon: const Icon(Icons.key),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          label: const Text("Password"),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          prefixIcon: const Icon(Icons.key),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          label: const Text("Confirm Password"),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.green.shade400)
                          ), 
                          child: const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  )
                )
              ],
            )
          ),
        ),
      )
    );
  }
}