import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Uint8List _pickedImage = Uint8List(8);

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
            child: _pickedImage == null ? Image.memory(_pickedImage, fit: BoxFit.fill,) : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton(
                  child: const Icon(Icons.input),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        var selected = await image.readAsBytes();
                        setState(() {
                          _pickedImage = selected;
                        });
                      } else {
                        print('No image has been picked');
                      }
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
                    onPressed: () {},
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}