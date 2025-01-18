import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {

  final nameController = TextEditingController();
  final PhonenoController = TextEditingController();
  final formfield = GlobalKey<FormState>();

  Future addNewContacts()
  async {
    if(formfield.currentState!.validate()){
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc('userID')
            .collection("contacts")
            .add({"name": nameController.text,"phoneno": PhonenoController.text});
        print("Details Added");
        Navigator.pop(context);
      } catch (e) {
        print(e.toString());
      }
    }else{
      Get.snackbar('Error', 'Kindly fill the required details');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Add to Contacts'),),
          body: SingleChildScrollView(
            child: Form(
              key: formfield,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 50),
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
                              borderRadius: BorderRadius.circular(15)),
                          // fillColor: Color(0xffceb9f9),
                          filled: true,
                          hintText: "Name",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 50),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a vaild phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: PhonenoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          // fillColor: Color(0xffceb9f9),
                          filled: true,
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                      child: ElevatedButton(onPressed: (){
                        addNewContacts();
                      },
                          style: ElevatedButton.styleFrom(
                          ),child: Text('Add to Contacts')),
                    )
                  ],
                ),
              ),
            ),
          ) ,
    );
  }
}
