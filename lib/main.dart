import 'package:blog/Detalles.dart';
import 'package:blog/Editar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "detalle": (context) => const Detalles(),
        "editar": (context) => const Editar(),
      },
      title: "Blog App",
      /*Color al tema del header */
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 3, 10, 43),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*Logo */
        title: Image.asset(
          'assets/paku.png',
          fit: BoxFit.cover,
          height: 50,
        ),
      ),
      body: ListView(
      padding: const EdgeInsets.all(8),
          children: [
          const SizedBox(
            height: 9,
          ),
          /*Nuestro blog */
          const SizedBox(
            width: 500,
            height: 50,
            child: Text(
              "Nuestro blog",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("blog").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?>? documentSnapshot =
                        snapshot.data?.docs[index];

                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            (documentSnapshot != null)
                                ? (documentSnapshot["image"])
                                : "",
                            width: 400,
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
                              (documentSnapshot != null)
                                  ? (documentSnapshot["title"])
                                  : "",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (documentSnapshot != null)
                                  ? (getTime(
                                      documentSnapshot["date"] as Timestamp))
                                  : "",
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          (documentSnapshot != null)
                              ? (documentSnapshot["summary"])
                              : "",
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        /* */
                           SizedBox(
                          width: 500,
                          height: 20,
                          child: GestureDetector(
                            child: const Text(
                              "Ver mas",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "detalle",
                                arguments: documentSnapshot?.id,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 3, 10, 43),
        onPressed: () {
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  String getTime(var time) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = time.toDate();
    return formatter.format(date);
  }
}
