import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInputWidget extends StatefulWidget {
  //const ImageInputWidget({super.key});

  final Function onSelectImage;

  ImageInputWidget(this.onSelectImage);

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {

  File? _storedImage; 
  _takePicure() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;
 
    setState(() {
      _storedImage = File(imageFile.path);
    });

    //if (imageFile != null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/${fileName}');
    widget.onSelectImage(savedImage);

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 280,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null ? Image.file(
            _storedImage!,
            width: double.infinity,
            fit: BoxFit.cover,
          ) : Text('Sem imagens em uso!'),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Tirar Foto'),
            onPressed: _takePicure,
          ),
        ),
      ],
    );
  }
}