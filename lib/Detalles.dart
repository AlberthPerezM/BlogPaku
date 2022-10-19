import 'package:blog/Editar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:intl/intl.dart';

class Detalles extends StatefulWidget {
  const Detalles({super.key});

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    /*final blog = db.collection("blog");*/
    final args = ModalRoute.of(context)!.settings.arguments as String;
    final doc = db.doc("/blog/" + args);
    final doc2 = db.collection("/blog/" + args + "/body/");
    final doc3 = FirebaseFirestore.instance
        .collection("/blog/" + args + "/body")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        /*Logo */
        title: Text(
          "Volver",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Editar(),
                  ));
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          /*Nuestro blog */
          Container(
            child: Text(
              "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            width: 500,
            height: 50,
          ),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: doc.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final docsnap = snapshot.data!;
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      docsnap['image'],
                      width: 500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //titulo
                      Text(
                        docsnap['title'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      Text(
                        (getTime(docsnap['date'])),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    docsnap["summary"],
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 25,
                    endIndent: 25,
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*Texto */

                  Text(
                    ' El desarrollo de las apps viene a ser con el tiempo el mayor aliado tecnolñogico, donde el usuario puede generar o ahorras recursos en sus procesos principales. ',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*Imagen */
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://storage.googleapis.com/gweb-uniblog-publish-prod/original_images/HeroHomepage_2880x1200.jpg",
                      width: 500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' El desarrollo de las apps viene a ser con el tiempo el mayor aliado tecnolñogico, donde el usuario puede generar o ahorras recursos en sus procesos principales. ',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ],
      )),
    );
  }

  /*String getFormatfromDate(Timestamp time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(time.microsecondsSinceEpoch);
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }*/

  String getTime(var time) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = time.toDate();
    return formatter.format(date);
  }
}
