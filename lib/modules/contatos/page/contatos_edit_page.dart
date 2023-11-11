import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:contatos_flutter/modules/contatos/model/contatos_model.dart';
import 'package:contatos_flutter/modules/contatos/service/contatos_sevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContatosEditPage extends StatefulWidget {
  final ContatosModel contatoModel;
  final String titulo;
  final bool novo;

  const ContatosEditPage(
      {Key? key,
      required this.contatoModel,
      required this.titulo,
      required this.novo})
      : super(key: key);

  @override
  State<ContatosEditPage> createState() => _ContatosEditPageState();
}

class _ContatosEditPageState extends State<ContatosEditPage> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _ctrlNome;
  late TextEditingController _ctrlTelefone;
  late TextEditingController _ctrlEndereco;
  late TextEditingController _ctrlCidade;
  late TextEditingController _ctrlAniversario;
  late ContatosService _contatoService;
  late String _imagemPath;
  late XFile? _pickedImage;

  @override
  void initState() {
    _contatoService = ContatosService();

    super.initState();

    _ctrlNome =
        TextEditingController(text: widget.contatoModel.nome.toString());
    _ctrlTelefone =
        TextEditingController(text: widget.contatoModel.telefone.toString());
    _ctrlEndereco =
        TextEditingController(text: widget.contatoModel.endereco.toString());
    _ctrlCidade =
        TextEditingController(text: widget.contatoModel.cidade.toString());
    _ctrlAniversario =
        TextEditingController(text: widget.contatoModel.aniversario.toString());
    _imagemPath = widget.contatoModel.imagem.toString();
  }

  @override
  void dispose() {
    _ctrlNome.dispose();
    _ctrlTelefone.dispose();
    _ctrlEndereco.dispose();
    _ctrlCidade.dispose();
    _ctrlAniversario.dispose();
    super.dispose();
  }

  var formater = [
    [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()],
    [FilteringTextInputFormatter.digitsOnly, DataInputFormatter()]
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.contatoModel.nome.toString()),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  imagenContato(),
                  AddFoto(context),
                ],
              ),
            ),
            inputText("Nome", _ctrlNome, false, [], TextInputType.name),
            inputText("Telefone", _ctrlTelefone, false, formater[0],TextInputType.phone),
            inputText("Cidade", _ctrlCidade, false, [], TextInputType.text),
            inputText("Endereco", _ctrlEndereco, false, [], TextInputType.text),
            inputText("Aniversário", _ctrlAniversario, false, formater[1],TextInputType.number),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Padding(
                padding: EdgeInsets.only(right: 50, left: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    await saveOrEdit();
                    Navigator.pop(context);
                  },
                  child: widget.novo ? Text('Salvar') : Text('Atualizar'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  CircleAvatar imagenContato() {
    return _imagemPath == ''
        ? CircleAvatar(
            key: const ValueKey<int>(1),
            maxRadius: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.asset('assets/images/userNullImage.png'),
            ),
          )
        : CircleAvatar(
            key: const ValueKey<int>(2),
            maxRadius: 60,
            backgroundImage: FileImage(File(_imagemPath)),
          );
  }

  Positioned AddFoto(BuildContext context) {
    return Positioned(
      child: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Wrap(
                children: [
                  novaFoto(context),
                  galeria(context),
                ],
              );
            },
          );
        },
        child: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: FaIcon(FontAwesomeIcons.camera, color: Colors.white),
        ),
      ),
    );
  }

  ListTile novaFoto(BuildContext context) {
    return ListTile(
      leading: const FaIcon(FontAwesomeIcons.camera),
      title: const Text('Câmera'),
      onTap: () async {
        Navigator.pop(context);

        _pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
        );

        if (_pickedImage != null) {
          String path =
              (await path_provider.getApplicationDocumentsDirectory()).path;
          String name = basename(_pickedImage!.path);

          await _pickedImage!.saveTo("$path/$name");

          // Se quiser salvar na galeria so desabilitar essa linha
          //await GallerySaver.saveImage(_pickedImage!.path);

          setState(() {
            _imagemPath = _pickedImage!.path;
          });
        }
      },
    );
  }

  ListTile galeria(BuildContext context) {
    return ListTile(
      leading: const FaIcon(FontAwesomeIcons.photoFilm),
      title: const Text('Galeria'),
      onTap: () async {
        Navigator.pop(context);

        _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

        setState(() {
          _imagemPath = _pickedImage!.path;
        });
      },
    );
  }

  Future<void> saveOrEdit() async {
    widget.contatoModel.nome = _ctrlNome.text.trim();
    widget.contatoModel.telefone = _ctrlTelefone.text.trim();
    widget.contatoModel.endereco = _ctrlEndereco.text.trim();
    widget.contatoModel.cidade = _ctrlCidade.text.trim();
    widget.contatoModel.aniversario = _ctrlAniversario.text.trim();
    widget.contatoModel.imagem = _imagemPath;

    if (widget.novo) {
      await _contatoService.criar(widget.contatoModel);
    } else {
      await _contatoService.atualizar(widget.contatoModel);
    }
  }

  Padding inputText(String label, TextEditingController controller,
      bool leitura, List<TextInputFormatter> formater, TextInputType tipo) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          keyboardType: tipo,
          readOnly: leitura,
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
          inputFormatters: formater,
        ),
      ),
    );
  }
}
