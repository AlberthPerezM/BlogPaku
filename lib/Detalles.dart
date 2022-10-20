import 'package:blog/Editar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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
    final doc = db.doc("/blog/$args");
    final docDetail = db.collection("/blog/$args/body").orderBy("position");

    return Scaffold(
      appBar: AppBar(
        /*Logo */
        title: const Text(
          "Volver",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Editar(),
                  ));
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          /*Nuestro blog */
          const SizedBox(
            width: 500,
            height: 50,
            child: Text(
              "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //titulo
                      Text(
                        docsnap['title'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      Text(
                        (getTime(docsnap['date'])),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    docsnap["summary"],
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 25,
                    endIndent: 25,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /*Texto */
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: docDetail.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasError) {
                        return const Text("error en obtener info detail");
                      } else if (snapshot.hasData || snapshot.data != null) {
                        return getDetailWidgetByData(snapshot.data.docs);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      )),
    );
  }

  String getTime(var time) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = time.toDate();
    return formatter.format(date);
  }
  
  getDetailWidgetByData(List<dynamic> docsForFlutter) {
      return ListView.builder(
        itemCount: docsForFlutter.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Text(docsForFlutter[index]["data"]);
        },
      );
  }
}
