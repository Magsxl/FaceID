import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context){
    
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buttonColumn(color, Icons.input, 'Wczytaj'),
        //_buttonColumn(color, Icons.send, 'Prześlij'),
      ],
    );
    return MaterialApp(
      title: 'Welcome',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
        ),
        body: Center(
          child: buttonSection,
        ),
      ),
    );
  }

  Column _buttonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextButton(
            child: Text(label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:color,
              )
            ),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(allowedExtensions: ['jpg','png','bmp','jpeg']);
              if (result == null) return;

              final file = result.files.first;              
            },
          )
        )
      ],
    );
  }
}