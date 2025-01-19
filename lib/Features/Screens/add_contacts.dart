import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addNewContacts(String name, String phoneno) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .add({"name": name, "phoneno": phoneno});
        Get.snackbar('Success', 'Contact added successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to add contact: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Contacts'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      hintText: "Name",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: phonenoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      hintText: "Phone Number",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      addNewContacts(
                        nameController.text.trim(),
                        phonenoController.text.trim(),
                      );
                    },
                    child: const Text('Add to Contacts'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
