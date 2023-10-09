import 'dart:io';

import 'package:chat/components/user_image_picker_component.dart';
import 'package:chat/core/models/auth_form_data_model.dart';
import 'package:flutter/material.dart';

class AuthFormComponent extends StatefulWidget {
  final void Function(AuthFormDataModel) onSubimit;

  const AuthFormComponent({super.key, required this.onSubimit});

  @override
  State<AuthFormComponent> createState() => _AuthFormComponentState();
}

class _AuthFormComponentState extends State<AuthFormComponent> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormDataModel();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não foi selecionada!');
    }

    widget.onSubimit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePickerComponent(
                  onImagePick: _handleImagePick,
                ),
              if (_formData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter ao menos 5 caracteres!';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.trim().contains('@')) {
                    return 'E-mail sem @ identificado!';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'Senha deve ter ao menos 6 caracteres!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin
                    ? 'Criar uma nova conta?'
                    : 'Já possui conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
