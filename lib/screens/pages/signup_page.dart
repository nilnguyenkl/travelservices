import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_bloc.dart';
import 'package:travelservices/blocs/signup_bloc/signup_event.dart';
import 'package:travelservices/blocs/signup_bloc/signup_state.dart';
import 'package:travelservices/utils/validate.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  final _keySignUpForm = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.04),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.jpg",
                  height: 150,
                ),
                Form(
                  key: _keySignUpForm,
                  child: Column(
                    children: [
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: usernameController,
                            validator: (value) => ValidateForm.isValidUsername(value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              errorText: state.errorUsername,
                              prefixIcon: const Icon(Icons.person),
                              label: const Text("Username"),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: BlocBuilder<SignUpBloc, SignUpState>(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: lastnameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                    label: const Text("Lastname"),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: BlocBuilder<SignUpBloc, SignUpState>(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: firstnameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                    label: const Text("Firstname"),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: emailController,
                            validator: (value) => ValidateForm.isValidEmail(value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              prefixIcon: const Icon(Icons.email),
                              label: const Text("Email"),
                              errorText: state.errorEmail
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: phoneController,
                            validator: (value) => ValidateForm.isValidPhone(value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              prefixIcon: const Icon(Icons.phone),
                              label: const Text("Phone"),
                              errorText: state.errorPhone
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black38),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<SignUpBloc>().add(SignUpGenderEvent("Male"));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: state.gender == "Male" ? Colors.blue.shade600 : Colors.white,
                                        border: Border.all(width: 1, color: Colors.black38),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)
                                        )
                                      ),
                                      child: Text(
                                        "Male",
                                        style: TextStyle(
                                          color: state.gender == "Male" ? Colors.white : Colors.black54
                                        ),
                                      )
                                    ),
                                  )
                                ),
                                const VerticalDivider(
                                  width: 2,
                                  color: Colors.black,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      context.read<SignUpBloc>().add(SignUpGenderEvent("Female"));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: state.gender == "Female" ? Colors.blue.shade600 : Colors.white,
                                        border: Border.all(width: 1, color: Colors.black38),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15)
                                        )
                                      ),
                                      child: Text(
                                        "Female",
                                        style: TextStyle(
                                          color: state.gender == "Female" ? Colors.white : Colors.black54
                                        ),
                                      )
                                    ),
                                  )
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: passwordController,
                            validator: (value) => ValidateForm.isValidPassword(value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<SignUpBloc>().add(SignUpEyePasswordEvent(!state.eyePassword));
                                }, 
                                icon: state.eyePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                              ),
                              label: const Text("Password"),
                            ),
                            obscureText: state.eyePassword,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          );
                        }
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: cnfpasswordController,
                            validator: (value) => ValidateForm.isValidCnfPassword(passwordController.text, value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<SignUpBloc>().add(SignUpEyeCnfPasswordEvent(!state.eyeCnfPassword));
                                }, 
                                icon: state.eyeCnfPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                              ),
                              label: const Text("Confirm Password"),
                            ),
                            obscureText: state.eyeCnfPassword,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          );
                        }
                      ),                
                      const SizedBox(height: 20),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state){
                          print(state.status);
                          if (state.status is SubmittingStatus) {
                            return const CircularProgressIndicator();
                          }
                          if (state.status is SuccessStatus) {
                            print("successsssssssssssssssss");
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (){
                                
                                if (_keySignUpForm.currentState!.validate()) {
                                
                                  context.read<SignUpBloc>().add(SignUpUsernameEvent(usernameController.text));
                                  context.read<SignUpBloc>().add(SignUpEmailEvent(emailController.text));
                                  context.read<SignUpBloc>().add(SignUpPhoneEvent(phoneController.text));
                                  context.read<SignUpBloc>().add(SignUpLastnameEvent(lastnameController.text));
                                  context.read<SignUpBloc>().add(SignUpFirstnameEvent(firstnameController.text));
                                  context.read<SignUpBloc>().add(SignUpPasswordEvent(passwordController.text));

                                  context.read<SignUpBloc>().add(SignUpSubmitEvent());
                                
                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  )
                                ),
                                backgroundColor: MaterialStateProperty.all(Colors.green.shade400)),
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
                          );
                        }
                      )
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
