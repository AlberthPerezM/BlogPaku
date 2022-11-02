import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Editar extends StatefulWidget {
  const Editar({super.key});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  bool isVisible = false;
  bool _offstage = true;
  var width=370.0;
   int numero=0;


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
      
      ),
      body: ListView(
            padding: const EdgeInsets.all(8),

        children: [
          /*Nuestro blog */
          const SizedBox(
            width: 10,
            height: 20,
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
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Offstage(
                offstage: _offstage,
                 child: IconButton(
                    color: const Color.fromARGB(255, 9, 5, 5),
                    icon: const Icon(
                      Icons.delete,
                      size: 30.0,
                    ),
                    onPressed: () {},
                  ),
              ),
               InkWell(
                  child: 
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      docsnap['image'],
                      width: width,
                      height: 200 ,
                    ),
                  ),
               
                  onTap: ( ) {
                    setState(() {
                      _offstage = !_offstage;
                      if(_offstage){
                        width=370;
                      }else{
                       width=320;
                    }
                    });
                  },
                ),
         
              ]
             ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      docsnap['image'],
                      width: 400,
                      height: 200 ,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //titulo
                      Text(
                        docsnap['title'],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),

                      Text(
                        (getTime(docsnap['date'])),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                  margin:const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child:
                   Text(
                    docsnap["summary"],
                    textAlign: TextAlign.justify,
                   ),
 
                  ),
                  const SizedBox(
                    height: 10,
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
                      if (snapshot.hasError) {
                        return const Text("error en obtener info detail");
                      } else if (snapshot.hasData || snapshot.data != null) {
                        /* */
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
      ),
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
        if (docsForFlutter[index]["type"] == "imagen") {
          return 
          Expanded(
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              docsForFlutter[index]["data"],
            ),
          ),
         );
        } else if (docsForFlutter[index]["type"] == "parrafo") {
          return 
          Container( 
            width: 10,
            margin:const EdgeInsets.fromLTRB(8, 8, 8, 8), 
            child:Text(docsForFlutter[index]["data"],textAlign: TextAlign.justify,),
          );
            
         
        } else {
          return const Text(
            "Tipo no reconocido",
            textAlign: TextAlign.center,
         );
        }
      },
    );
  }
}
