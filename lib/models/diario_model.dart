import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class DiarioModel {
  final String? key;
  final String ownerKey;
  final String titulo;
  final String autor;
  final String local;
  final String diario;
  final Uint8List? imagem;

  DiarioModel({
    this.key,
    required this.ownerKey,
    required this.titulo,
    required this.autor,
    required this.local,
    required this.diario,
    this.imagem,
  });

  static DiarioModel fromMap(Map<String, dynamic> map, [String? key]) =>
      DiarioModel(
        key: key,
        ownerKey: map['ownerKey'],
        titulo: map['titulo'],
        autor: map['autor'],
        local: map['local'],
        diario: map['diario'],
        imagem: map['imagem']?.bytes,
      );

  Map<String, dynamic> toMap() => {
        'ownerKey': ownerKey,
        'titulo': titulo,
        'autor': autor,
        'local': local,
        'diario': diario,
        'imagem': imagem != null ? Blob(imagem!) : null,
      };
}
