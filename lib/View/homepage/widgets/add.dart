import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addpage extends StatefulWidget {
  const addpage({super.key});

  @override
  State<addpage> createState() => _addpageState();
}

class _addpageState extends State<addpage> {
  final CollectionReference firelist =
      FirebaseFirestore.instance.collection('firelist');

  TextEditingController listname = TextEditingController();
  TextEditingController listage = TextEditingController();
  TextEditingController listqual = TextEditingController();

  void addfirelist() {
    final data = {
      'Name': listname.text,
      'Age': listage.text,
      'Qualification': listqual.text
    };
    firelist.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Page'),
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
                      hintStyle: TextStyle(letterSpacing: 3, fontSize: 20)),
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
                      label: Text('Age'),
                      hintStyle: TextStyle(letterSpacing: 3, fontSize: 20)),
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
                      label: Text('Qualification'),
                      hintStyle: TextStyle(letterSpacing: 3, fontSize: 20)),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    addfirelist();
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
