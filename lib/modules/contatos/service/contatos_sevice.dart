import 'package:contatos_flutter/modules/contatos/model/contatos_model.dart';
import 'package:contatos_flutter/modules/contatos/repository/contatos_repository.dart';

class ContatosService {
  Future<List<ContatosModel>> obterTodosContatos() async {
    var url = "/contato";
    try {
      Map<String, dynamic> retorno = await ContatosRepositoy.get(url);

      return ContatosModel().mapFromJson(retorno);
    } catch (e) {
      throw e;
    }
  }

  Future<ContatosModel> obterContato(String id) async {
    var url = "/contato?where={\"objectId\":\"$id\"}";

    try {
      Map<String, dynamic> retorno = await ContatosRepositoy.get(url);

      List<ContatosModel> conversao = ContatosModel().mapFromJson(retorno);

      if (conversao.length > 0) {
        return conversao[0];
      }

      return ContatosModel();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> criar(ContatosModel contatoModel) async {
    try {
      await ContatosRepositoy.create(contatoModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> atualizar(ContatosModel contatoModel) async {
    try {
      await ContatosRepositoy.update(contatoModel);
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String id) async {
    try {
      await ContatosRepositoy.remove(id);
    } catch (e) {
      throw e;
    }
  }
}
