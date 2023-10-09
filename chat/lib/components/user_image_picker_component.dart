import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerComponent extends StatefulWidget {
  final void Function(File image) onImagePick;

  const UserImagePickerComponent({super.key, required this.onImagePick});

  @override
  State<UserImagePickerComponent> createState() =>
      _UserImagePickerComponentState();
}

class _UserImagePickerComponentState extends State<UserImagePickerComponent> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );

    if(pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 30),
              Text('Adicionar Imagem')
            ],
          ),
        ),
      ],
    );
  }
}