import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../models/diario_model.dart';

class EditDiarioPage extends StatefulWidget {
  final DiarioModel diario;

  EditDiarioPage({required this.diario});

  @override
  _EditDiarioPageState createState() => _EditDiarioPageState();
}

class _EditDiarioPageState extends State<EditDiarioPage> {
  late final tituloCont = TextEditingController()..text = widget.diario.titulo;
  late final localCont = TextEditingController()..text = widget.diario.local;
  late final diarioCont = TextEditingController()..text = widget.diario.diario;
  late Uint8List? file = widget.diario.imagem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar diário"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('diarios')
                  .doc(widget.diario.key)
                  .delete();
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                controller: tituloCont,
                decoration: InputDecoration(
                  labelText: "Título",
                ),
              ),
              TextField(
                controller: localCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Local",
                ),
              ),
              TextField(
                controller: diarioCont,
                decoration: InputDecoration(
                  labelText: "Diário",
                ),
                maxLines: 20,
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
                  final atualizado = DiarioModel(
                    ownerKey: widget.diario.ownerKey,
                    titulo: tituloCont.text,
                    autor: widget.diario.autor,
                    local: localCont.text,
                    diario: diarioCont.text,
                    imagem: file,
                  ).toMap();

                  await FirebaseFirestore.instance
                      .collection('diarios')
                      .doc(widget.diario.key)
                      .update(atualizado);
                  
                  Navigator.pop(context);
                },
                child: Text("Atualizar diário"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
