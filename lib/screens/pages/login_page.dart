import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/login_bloc/login_bloc.dart';
import 'package:travelservices/blocs/login_bloc/login_event.dart';
import 'package:travelservices/blocs/login_bloc/login_state.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/pages/route_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyLoginForm = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.04),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.jpg",
                height: 200,
              ),
              Form(
                key: _keyLoginForm,
                child: Column(
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            prefixIcon: const Icon(Icons.person),
                            label: const Text("Username"),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        );
                      }
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: Icon(Icons.remove_red_eye),
                            label: const Text("Password")
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        );
                      }
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context,state) {
                        if (state.status is SubmittingStatus) {
                          return const CircularProgressIndicator();
                        }
                        if (state.status is FailedStatus) {
                          
                        }
                        if (state.status is SuccessStatus) {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pushNamedAndRemoveUntil(Routes.routesPage, (route) => false);
                          });
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              if (_keyLoginForm.currentState!.validate()){
                                
                                context.read<LoginBloc>().add(LoginUsernameEvent(usernameController.text));
                                context.read<LoginBloc>().add(LoginPasswordEvent(passwordController.text));

                                context.read<LoginBloc>().add(LoginSubmitEvent());
                              
                              }
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
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){}, 
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.black87
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 60),
                            child: Divider(color: Colors.black),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("OR"),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Divider(color: Colors.black),
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: (){}, 
                          icon: Image.asset("assets/images/google.png"),
                          iconSize: 50,
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: (){}, 
                          icon: Image.asset("assets/images/facebook.png"),
                          iconSize: 50,
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: (){}, 
                          icon: Image.asset("assets/images/twitter.png"),
                          iconSize: 50,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: (){}, 
                          child: const Text("Sign Up")
                        )
                      ],
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}