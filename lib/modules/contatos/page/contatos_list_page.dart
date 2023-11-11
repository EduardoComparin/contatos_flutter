import 'dart:io';

import 'package:contatos_flutter/modules/contatos/page/contatos_edit_page.dart';
import 'package:contatos_flutter/modules/contatos/model/contatos_model.dart';
import 'package:contatos_flutter/modules/contatos/service/contatos_sevice.dart';
import 'package:flutter/material.dart';

class ContatosListPage extends StatefulWidget {
  const ContatosListPage({super.key});

  @override
  State createState() => _ContatosListPageState();
}

class _ContatosListPageState extends State<ContatosListPage> {
  late ContatosService _contatoService;
  late List<ContatosModel> listaContatos;
  late bool carregando;

  @override
  void initState() {
    super.initState();
    _contatoService = ContatosService();
    listaContatos = [];
    carregando = false;
    obterContatos();
  }

  void obterContatos() async {
    setState(() {
      carregando = true;
    });

    listaContatos = await _contatoService.obterTodosContatos();

    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Contatos'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContatosEditPage(
                  contatoModel: novoContato(),
                  titulo: "Novo Contato",
                  novo: true,
                ),
              ),
            );

            setState(() {
              obterContatos();
            });
          },
          tooltip: 'Create',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Container(height: 45),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: carregando
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator())],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: listaContatos.length,
                          itemBuilder: (BuildContext bc, int index) {
                            
                            var dados = listaContatos[index];
                            var telefone = dados.telefone.toString();
                            var nome = dados.nome.toString();
                            var letra = dados.nome.toString().substring(0, 1);
                            var imagem = dados.imagem.toString();
                            
                            return Column(
                              children: [
                                Dismissible(
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (DismissDirection dismissDirection) async {
                                    await _contatoService.remover(dados.id.toString());
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.end,
                                        children: const [
                                          Icon(Icons.delete_forever,color: Colors.white),
                                          SizedBox(width: 8.0),
                                          Text('Remover',style: TextStyle(color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                  key: Key(nome),
                                  child: ListTile(
                                    leading: imagem != "" ? CircleAvatar(
                                            backgroundImage:FileImage(File(imagem)),
                                          )
                                        : CircleAvatar(
                                            child: Text(letra),
                                          ),
                                    title: Text(nome),
                                    subtitle: Text(telefone),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ContatosEditPage(contatoModel: dados,titulo: "Editando Contato",novo: false,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Divider(height: 0),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
        ));
  }

  ContatosModel novoContato() {
    return ContatosModel(
        aniversario: "",
        cidade: "",
        endereco: "",
        imagem: "",
        nome: "",
        telefone: "");
  }
}
