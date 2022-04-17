import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  String id;
  String nome;

  UsuarioModel({required this.id, required this.nome});

  factory UsuarioModel.fromDocument(DocumentSnapshot? document) {
    if (document == null) {
      return null as UsuarioModel;
    }
    return UsuarioModel(id: document.id, nome: document['nome']);
  }
}
