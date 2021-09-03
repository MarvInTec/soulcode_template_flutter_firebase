import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soulcode_template_flutter_firebase/controllers/user_controller.dart';
import 'package:soulcode_template_flutter_firebase/models/user_model.dart';

/// Exercício - Crie uma tela separada para listar os usuários.
/// -----> USANDO FUTURE BUILDER <-----
/// Destacar o usuário que está logado.

class ListUsuariosPage extends StatefulWidget {
  @override
  _ListUsuariosPageState createState() => _ListUsuariosPageState();
}

class _ListUsuariosPageState extends State<ListUsuariosPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuários"),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('usuarios').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final usuarios = snapshot.data!.docs.map(
            (documento) {
              final dados = documento.data();
              return UserModel.fromMap(dados);
            },
          ).toList();

          return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];

                var cor = usuario.key == userController.model.key
                    ? Colors.red
                    : Colors.white;

                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(usuario.nome),
                  tileColor: cor,
                );
              });
        },
      ),
    );
  }
}



/**
 * // Aponta para coleção
 * FirebaseFirestore.instance
 * .collection('usuarios')
 * 
 * /// ----> LER DADOS <----
 * 
 * // Puxar todos os documentos(Future<QuerySnapshot>):
 *  await FirebaseFirestore.instance
 * .collection('usuarios')
 * .get()
 * 
 * // Puxar todos os documentos(Stream<QuerySnapshot>):
 * FirebaseFirestore.instance
 * .collection('usuarios')
 * .snapshots()
 * 
 * // Puxar um documento específico(Future<DocumentSnapshot>)
 * FirebaseFirestore.instance
 * .collection('usuarios')
 * .doc(codigo_documento)
 * .get()
 * 
 * // Puxar um documento específico(Stream<DocumentSnapshot>)
 * FirebaseFirestore.instance
 * .collection('usuarios')
 * .doc(codigo_documento)
 * .snapshots()
 * 
 * // Filtrar documentos
 * FirebaseFirestore.instance
 * .collection('diarios')
 * .where('local', isEqualTo: 'Tóquio')
 * .get() ou .snapshots()
 * 
 * // ADICIONAR DADOS (ID ALEATÓRIO)
 * FirebaseFirestore.instance
 * .collection('diarios')
 * .add(mapa_diario) // {"titulo": "Foi bom", "local": "Tóquio", ...}
 * 
 * // ADICIONAR DADOS PELO DOCUMENTO(QUANDO QUERO DEFINIR ID DO DOC...)
 * FirebaseFirestore.instance
 * .collection('diarios')
 * .doc(codigo_diario)
 * .set(mapa_diario) // {"autor": "José Almir"}
 * 
 * // DELETAR UM DOCUMENTO
 * FirebaseFirestore.instance
 * .collection('usuarioss')
 * .doc(uid)
 * .delete()
 * 
 * // ATUALIZAR DOCUMENTO
 * FirebaseFirestore.instance
 * .collection('diarios')
 * .doc(codigo_diario)
 * .update(mapa_diario) // {"autor": "José Almir"}
 * 
 * // OBS: set() limpa o que já tem update() mescla.
 */