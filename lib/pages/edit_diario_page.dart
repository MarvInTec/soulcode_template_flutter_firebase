import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/diario_model.dart';

class EditDiarioPage extends StatefulWidget {
  final DiarioModel diario;

  EditDiarioPage({required this.diario});

  @override
  _EditDiarioPageState createState() => _EditDiarioPageState();
}

class _EditDiarioPageState extends State<EditDiarioPage> {
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
    );
  }
}
