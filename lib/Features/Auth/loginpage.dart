import 'package:flutter/material.dart';
import 'package:firebase_database/Features/Widgets/round_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Services/auth_services.dart';
import '../Screens/Post_screen.dart';
import 'signup.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xffc398f9), Color(0xff7b6bef)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Container(
                    height: size.height * .68,
                    width: size.width * .80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffc398f9), Color(0xff7b6bef)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      boxShadow: [
                        new BoxShadow(
                          blurRadius: 1,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 165),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Text(
                            "Glad to have you again",
                            style: TextStyle(
                                color: Color(0xff54328f),
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        Form(
                            key: _formField,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Color(0xffceb9f9),
                                      filled: true,
                                      hintText: "Email",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .015,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter password';
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Color(0xffceb9f9),
                                      filled: true,
                                      suffixIcon: Icon(Icons.visibility),
                                      hintText: "Password",
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Roundbutton(
                              title: 'Log In',
                              onTap: () {
                                if (_formField.currentState!.validate()) {
                                  AuthService()
                                      .LogInwithEmail(emailController.text,
                                          passwordController.text)
                                      .then((value) {
                                    if (value == 'Login Done') {
                                      Get.snackbar('', 'LogIn Done');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostScreen()));
                                    } else {
                                      Get.snackbar("Error", value);
                                    }
                                  });
                                }
                              },
                            )),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 103),
                          child: Text("Forgot Password ?",
                              style: TextStyle(color: Color(0xff422f91))),
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Don't have an account ?"),
                              InkWell(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: Color(0xff422f91)),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                },
                              )
                            ]),
                        SizedBox(height: size.height * .03),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child:
                                    Divider(thickness: 2, color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: Text(
                                  "Or Sign up with",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Expanded(
                                child:
                                    Divider(thickness: 2, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .03,
                        ),
                        ElevatedButton(
                            onPressed: () async{
                              AuthService().signUpwithGoogle().then((user) {
                                if (user != null) {
                                  Get.snackbar(
                                      "", 'Signed in as ${user.displayName}');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PostScreen()));
                                } else {
                                  Get.snackbar('Error', 'Sign In failed');
                                }
                              });
                            },
                            child: Text("Sign Up with Gmail"))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
