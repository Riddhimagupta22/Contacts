import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/Features/Screens/add_contacts.dart';

import 'update_contacts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future<void> deleteContact(String userId) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(userId).delete();
     print('Contact deleted successfully');
    } catch (e) {
      print('Failed to delete contact: ${e.toString()}');
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
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong. Please try again."),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No contacts found."),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return ListTile(
                onTap: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateContacts()),
                );}
                ,
                title: Text(userMap["name"] ),
                subtitle: Text(userMap["phoneno"] ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () => deleteContact(snapshot.data!.docs[index].id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
