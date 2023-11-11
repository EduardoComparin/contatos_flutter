import 'package:contatos_flutter/modules/contatos/model/contatos_model.dart';
import 'package:contatos_flutter/service/http_service.dart';


class ContatosRepositoy {
 static final _dio = httpService().getDio();

  static Future<Map<String, dynamic>> get(String url) async {

    var result = await _dio.get(url);

    Map<String, dynamic> retorno = result.data;

    return retorno;
  }

  static Future<void> create(ContatosModel contatoModel) async {
    try {
      await _dio.post("contato", data: contatoModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  static Future<void> update(ContatosModel contatoModel) async {
    try {
      await _dio.put(
          "contato/${contatoModel.id}",
          data: contatoModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  static Future<void> remove(String id) async {
    try {
       await _dio.delete(
        "contato/$id",
      );
    } catch (e) {
      throw e;
    }
  }
}
