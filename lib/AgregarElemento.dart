import 'package:flutter/material.dart';

class AgregarElementoPage extends StatefulWidget {
  const AgregarElementoPage({super.key});
  @override
  State<AgregarElementoPage> createState() => _AgregarElementoPageState();
}

var white = Colors.white;
var blue = const Color.fromARGB(255, 4, 13, 174);
double size = 100;
double fontsize = 30;

class _AgregarElementoPageState extends State<AgregarElementoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agregar elemento"),
        ),
        body: ListView(
                  padding: const EdgeInsets.all(8),

          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                width: 400,
                child: const Text('Elige el emento que se va a agregar',
                    style: TextStyle(fontSize: 16))),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 9),
              padding: const EdgeInsets.all(10.0),
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.topic,
                          size: size,
                          color: white,
                        ),
                        Text("Parrafo",
                            style: TextStyle(color: white, fontSize: fontsize))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: size,
                          color: white,
                        ),
                        Text(
                          "Imagen",
                          style: TextStyle(color: white, fontSize: fontsize),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: size, color: white),
                        Text(
                          "Tópico",
                          style: TextStyle(color: white, fontSize: fontsize),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10.0),
                children: [
                  Container(
                      width: 10,
                      height: 200,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.grey,
                      child: const TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Ingrese el texto del parrafo'),
                      ))
                ])
          ],
        ));
  }
}
