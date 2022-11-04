import 'package:blog/bloc/editar_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Editar extends StatefulWidget {
  const Editar({super.key});    
  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  bool isVisible = false;
  var espaciado=40.0;
  @override
  Widget build(BuildContext context) { 
    final db = FirebaseFirestore.instance;
    /*final blog = db.collection("blog");*/
    final args = ModalRoute.of(context)!.settings.arguments as String;
    final doc = db.doc("/blog/$args");
    final docDetail = db.collection("/blog/$args/body").orderBy("position");
    final varible =EditarBloc();


    return Scaffold(
      appBar: AppBar(
        /*Logo */
        title: const Text(
          "Volver",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const Text('Demo'),
          BlocBuilder<EditarBloc, EditarState>(
            bloc:EditarBloc(),
            builder: (context, state) {
              return Container();
            },
          ),
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
                   children: [
                   BlocBuilder<EditarBloc, EditarState>(
                   bloc:varible,
                   builder: (context, state) {
              

                    if ( state is Initial || state is Running){
                    return Visibility(
                    visible:false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                    color:const Color.fromARGB(255, 0, 0, 0),
                    icon: const Icon(
                       Icons.delete,
                       size: 20.0,
                      ),
                       onPressed: () {},
                      ),
                     );

                    /*}else if(state is Running){
                    return Visibility(
                    visible:state.visi,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                    color:const Color.fromARGB(255, 0, 0, 0),
                    icon: const Icon(
                       Icons.delete,
                       size: 20.0,
                      ),
                       onPressed: () {},
                      ),
                     );*/
                   
                       }
                       else{
                        return Container(color:Colors.red);
                       }
                      },
                    ), SizedBox(
                        width: 330,
                        child: 
                        InkWell(                        
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),           
                          child: Image.network(
                          docsnap['image'],
                          ),
                        ),
                           onTap: () {
                             varible.add(const EditarEvent.mostrar()
                            );
                          },                 
                      ),
                    ),
                   ]
                 ),  
                  const SizedBox(
                    height: 10,
                  ),
                  Row( 
                    children: [
                      //titulo
                      Expanded(child:     
                      Container(
                      margin: EdgeInsets.only(left: espaciado),
                      child: 
                      Text(
                        docsnap['title'],
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),
                        ),
                       ),
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
                  margin: EdgeInsets.fromLTRB(espaciado, 8, 8, 8),
                  child:
                   Text(
                    docsnap["summary"],
                    textAlign: TextAlign.justify,
                   ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                  margin: EdgeInsets.fromLTRB(espaciado, 0, 0, 0),
                  child:
                  const Divider(
                    color: Colors.black,
                    indent: 25,
                    endIndent: 25,
                    thickness: 3,
                  ),
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
       var widthq = MediaQuery.of(context).size.width;
 
        if (docsForFlutter[index]["type"] == "imagen") {
          return 
          Expanded(
          child:
          Container(
          margin: EdgeInsets.fromLTRB(espaciado, 8, 8, 8),
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              docsForFlutter[index]["data"],
            ),  
          ), 
          ),
         );
        } else if (docsForFlutter[index]["type"] == "parrafo") {
          return 
             Row(
              children: [
                Visibility(
                  visible:false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: IconButton(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    icon: const Icon(
                      Icons.delete_rounded,
                      size:30.0,
                    ),
                    onPressed: () {},
                  ),
                ),
                InkWell(
                child:
                SizedBox( 
                    width:widthq-espaciado-8,
                   child:Text(docsForFlutter[index]["data"],textAlign: TextAlign.justify,),
                    ),
                  onTap: ( ) {
                    setState(() {
                    }
                   ); 
                  }),                 
                ]
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