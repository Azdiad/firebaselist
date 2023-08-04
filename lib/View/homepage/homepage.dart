import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselist/Helper/textstyle.dart';
import 'package:firebaselist/View/homepage/widgets/add.dart';
import 'package:flutter/material.dart';
import 'package:firebaselist/View/homepage/widgets/update.dart';

class homepage extends StatefulWidget {
  homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final CollectionReference firelist =
      FirebaseFirestore.instance.collection('firelist');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addpage(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.red,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: firelist.orderBy('Name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot snaplist = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 117, 215, 230),
                          Color.fromARGB(255, 87, 153, 233),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: Offset(-8, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Name: ${snaplist['Name']}',
                              style: textbalck,
                            ),
                            Text(
                              'Age: ${snaplist['Age']}',
                              style: textbalck,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Education: ${snaplist['Qualification']}',
                              style: textbalck,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdatePage(
                                          argument: {
                                            'name': snaplist['Name'],
                                            'age': snaplist['Age'].toString(),
                                            'Qualification':
                                                snaplist['Qualification'],
                                            'id': snaplist.id,
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
