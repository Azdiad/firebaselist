import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final Map argument;

  UpdatePage({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdateState();
}

class _UpdateState extends State<UpdatePage> {
  TextEditingController listname = TextEditingController();
  TextEditingController listage = TextEditingController();
  TextEditingController listqual = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Populate the TextEditingController fields with data from the provided map
    listname.text = widget.argument['name'];
    listage.text = widget.argument['age'].toString();
    listqual.text = widget.argument['Qualification'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: listname,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    hintText: AutofillHints.name,
                    hintStyle: TextStyle(letterSpacing: 3, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: listage,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'Age',
                    hintStyle: TextStyle(letterSpacing: 3, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: listqual,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: 'Qualification',
                    hintStyle: TextStyle(letterSpacing: 3, fontSize: 20),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  updateFirestoreDocument(widget.argument['id']);
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateFirestoreDocument(String docId) {
    FirebaseFirestore.instance.collection('firelist').doc(docId).update({
      'Name': listname.text,
      'Age': int.parse(listage.text),
      'Qualification': listqual.text,
    });
    // .then((_) {
    //   print('Document updated successfully.');
    // }).catchError((error) {
    //   print('Error updating document: $error');
    // });
  }
}
