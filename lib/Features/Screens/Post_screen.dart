import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/Features/Screens/update_contacts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/Features/Screens/add_contacts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final Stream<QuerySnapshot> contactsdata =
      FirebaseFirestore.instance.collection("contacts").snapshots();
  void deleteData(String id)async{
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .collection("contacts").doc(id)
          .delete();
      print("Details Deleted");
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContacts()),
          );
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: contactsdata,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                "No contacts found.",
              ));
            }else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  final User = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                  final UserId = snapshot.data!.docs[index].id;
                  final String name = User['name'];
                  final phonenumber = User['phonenumber'];
                  return ListTile(
                    title: Text(name),
                    subtitle: Text(phonenumber),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
                      onPressed: () => deleteData,
                    ),
                  );
            });
          }
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong. Please try again."),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
