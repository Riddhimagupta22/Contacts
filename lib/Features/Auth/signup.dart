import 'package:firebase_database/Features/Auth/loginpage.dart';
import 'package:firebase_database/Services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/Features/Widgets/round_button.dart';
import '../Screens/Post_screen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xffc398f9), Color(0xff7b6bef)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * .7,
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
                      child: Column(children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Create Your Account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .03,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: SizedBox(
                                  width: size.height * .5,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Name';
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Color(0xffceb9f9),
                                      filled: true,
                                      suffixIcon: Icon(Icons.person),
                                      hintText: "Name",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .015,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: SizedBox(
                                  // height: size.height * .055,
                                  width: size.height * .5,
                                  child: TextFormField(
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
                                      suffixIcon: Icon(Icons.email),
                                      hintText: "Email",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .015,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: SizedBox(
                                  width: size.height * .5,
                                  child: TextFormField(
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
                                      suffixIcon:
                                          Icon(Icons.visibility_off_sharp),
                                      hintText: "Password",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .015,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: SizedBox(
                                  width: size.height * .5,
                                  child: TextFormField(
                                    controller: confirmpasswordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Color(0xffceb9f9),
                                      filled: true,
                                      hintText: "Confirm Password",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .015,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0),
                                  child: Roundbutton(
                                    title: 'Sign Up',
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        AuthService()
                                            .AccountwithEmail(
                                                emailController.text,
                                                passwordController.text)
                                            .then((value) {
                                          if (value == 'Account Created') {
                                            Get.snackbar('', 'Account Created');
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
                              SizedBox(height: size.height * .02),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Don't have an account ?"),
                                    InkWell(
                                      child: Text(
                                        "Log In",
                                        style:
                                            TextStyle(color: Color(0xff422f91)),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Loginpage()));
                                      },
                                    )
                                  ]),
                              SizedBox(height: size.height * .03),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Divider(
                                          thickness: 2, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: Text(
                                        "Or Sign up with",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                          thickness: 2, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * .008,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    AuthService()
                                        .signUpwithGoogle()
                                        .then((user) {
                                      if (user != null) {
                                        Get.snackbar("",
                                            'Signed in as ${user.displayName}');
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
                                  child: Text("Sign Up with Gmail")),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ]),
            )));
  }
}
