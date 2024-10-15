import 'package:viagemcalculo/cardDestino.dart';
import 'package:viagemcalculo/model/destinos.dart';
import 'package:flutter/material.dart';

class DestinoTela extends StatefulWidget {
  final List<Destinos> listaDestinos;
  final Function(int) onRemove;
  final Function(Destinos) onInsert;
  const DestinoTela(
      {super.key,
      required this.onInsert,
      required this.onRemove,
      required this.listaDestinos});

  @override
  State<DestinoTela> createState() => _DestinoTelaState();
}

class _DestinoTelaState extends State<DestinoTela> {
  final TextEditingController nomeDestinoController = TextEditingController();
  final TextEditingController distanciaDestinoController =
      TextEditingController();
  void openModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: [
                  const Text(
                    "Cadastro de Destinos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: nomeDestinoController,
                    decoration:
                        const InputDecoration(label: Text("Nome do Destino")),
                  ),
                  TextField(
                    controller: distanciaDestinoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Distância do Destino"),
                    ),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 0, 91, 136)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          minimumSize: WidgetStatePropertyAll(Size(500, 50))),
                      onPressed: () {
                        widget.onInsert(Destinos(
                            nomeDestino: nomeDestinoController.text,
                            distanciaDestino:
                                double.parse(distanciaDestinoController.text)));
                        Navigator.pop(context);
                        nomeDestinoController.clear();
                        distanciaDestinoController.clear();
                      },
                      child: const Text("Cadastrar")),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.listaDestinos.length,
        itemBuilder: (context, index) {
          return CardDestino(
            nomeDestino: widget.listaDestinos[index].nomeDestino,
            distanciaDestino: widget.listaDestinos[index].distanciaDestino,
            onRemove: () => widget.onRemove(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal();
        },
        backgroundColor: const Color.fromARGB(255, 0, 91, 136),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
