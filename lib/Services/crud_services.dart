import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  final user = FirebaseAuth.instance.currentUser;


  Future addNewContacts(
      // String image,
      String name,
      String phone_number)
  async {
    Map<String, dynamic> data = {
      // "image": image,
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

  // Stream<QuerySnapshot> getContacts()async* {
  //   var contacts = FirebaseFirestore.instance.collection('users')
  //     ..doc(user!.uid).collection("contacts").snapshots();
  //   yield* contacts;
  // }
 Stream<QuerySnapshot> getContacts() async* {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .snapshots();
    } catch (e) {
      print("Error fetching contacts: $e");
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
