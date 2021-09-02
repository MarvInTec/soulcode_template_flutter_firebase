import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../models/diario_model.dart';

class AddDiario extends StatefulWidget {
  @override
  _AddDiarioState createState() => _AddDiarioState();
}

class _AddDiarioState extends State<AddDiario> {
  String titulo = "", local = "", diario = "";
  Uint8List? file;

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar diário"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Título",
                ),
                onChanged: (texto) => titulo = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Local",
                ),
                onChanged: (texto) => local = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Diário",
                ),
                maxLines: 20,
                onChanged: (texto) => diario = texto,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.image);

                  if (result != null) {
                    setState(() {
                      final bytes = result.files.first.bytes;
                      file = bytes;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(file != null ? Icons.check : Icons.upload),
                    Text("Adicionar imagem"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  final user = await FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(userController.user!.uid)
                      .get();

                  final data = user.data()!;

                  final novoDiario = DiarioModel(
                    ownerKey: userController.user!.uid,
                    titulo: titulo,
                    autor: data['nome'],
                    local: local,
                    diario: diario,
                    imagem: file,
                  ).toMap();

                  await FirebaseFirestore.instance
                      .collection('diarios')
                      .add(novoDiario);
                  
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Adicionar diário"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
