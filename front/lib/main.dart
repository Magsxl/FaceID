import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
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
                  padding: const EdgeInsets.only(top: 100),
                  child: const ImageForm(),
                )
              ), 
            ] 
        ),  
      ),
    );
  }
}

class ImageForm extends StatefulWidget {
  const ImageForm ({super.key});

  @override
  ImageFormState createState() {
    return ImageFormState();
  }
}

class ImageFormState extends State<ImageForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 200, left: 20),
            child: Image.network('https://picsum.photos/250?image=9'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  child: const Icon(Icons.input),
                    onPressed: () async {
                      final imageFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'bmp', 'jpeg', 'jpg']);
                      if (imageFile == null) return;
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
                    child: const Icon(Icons.check),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data has been sent...')),
                        );
                      }
                    },
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}