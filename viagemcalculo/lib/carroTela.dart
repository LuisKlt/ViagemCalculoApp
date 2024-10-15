import 'package:viagemcalculo/cardCarro.dart';
import 'package:viagemcalculo/model/carros.dart';
import 'package:flutter/material.dart';

class CarroTela extends StatefulWidget {
  final List<Carros> listaCarros;
  final Function(int) onRemove;
  final Function(Carros) onInsert;
  const CarroTela(
      {super.key,
      required this.onInsert,
      required this.onRemove,
      required this.listaCarros});

  @override
  State<CarroTela> createState() => _CarroTelaState();
}

class _CarroTelaState extends State<CarroTela> {
  final TextEditingController nomeCarroController = TextEditingController();
  final TextEditingController autonomiaController = TextEditingController();
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
                    "Cadastro de Carros",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: nomeCarroController,
                    decoration:
                        const InputDecoration(label: Text("Nome do Carro")),
                  ),
                  TextField(
                    controller: autonomiaController,
                    decoration: const InputDecoration(
                      label: Text("Consumo"),
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
                        widget.onInsert(Carros(
                            nomeCarro: nomeCarroController.text,
                            autonomia: double.parse(autonomiaController.text)));
                        Navigator.pop(context);
                        nomeCarroController.clear();
                        autonomiaController.clear();
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
        itemCount: widget.listaCarros.length,
        itemBuilder: (context, index) {
          return CardCarro(
            nomeCarro: widget.listaCarros[index].nomeCarro,
            autonomia: widget.listaCarros[index].autonomia,
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
