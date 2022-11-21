import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 
  const MyApp({super.key});
  
  get child => null;
  @override
  Widget build(BuildContext context){
    String fileName;

    Widget buttonSection = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: FloatingActionButton(
              child: const Icon(Icons.input),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'bmp', 'jpeg', 'jpg']);
                  if (result == null) return;
                  //PlatformFile file = result.files.first;
                }
            )
          ),
          Container(
            padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                child: const Icon(Icons.delete),
                onPressed: () async{}
              )
          ),
          Container(
            padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                child: const Icon(Icons.person),
                onPressed: () {},
              )
          )
      ],
    );
    return MaterialApp(
      title: 'FaceID',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FaceID'),
        ),
        body: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 200, left: 20),
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),              
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 100),
                  child: buttonSection
                )
              ), 
            ] 
        ),  
      ),
    );
  }
}