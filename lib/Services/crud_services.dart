import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  final user = FirebaseAuth.instance.currentUser;

  Future addNewContacts(String image, String name, String phone_number) async {
    Map<String, dynamic> data = {
      "image": image,
      "name": name,
      "phone_number": phone_number
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("Details Added");
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateContacts(
      String image, String name, String phone_number, String docID) async {
    Map<String, dynamic> data = {
      "image": image,
      "name": name,
      "phone_number": phone_number
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docID)
          .update(data);
      print("Details Updated");
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteContacts(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts").doc(docID)
          .delete();
      print("Details Deleted");
    } catch (e) {
      print(e.toString());
    }
  }
}
