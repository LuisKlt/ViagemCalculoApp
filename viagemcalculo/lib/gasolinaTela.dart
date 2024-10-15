import 'package:viagemcalculo/cardCombustivel.dart';
import 'package:viagemcalculo/model/combustivel.dart';
import 'package:flutter/material.dart';

class GasolinaTela extends StatefulWidget {
  final List<Combustivel> listaCombustivel;
  final Function(int) onRemove;
  final Function(Combustivel) onInsert;
  const GasolinaTela(
      {super.key,
      required this.onInsert,
      required this.onRemove,
      required this.listaCombustivel});

  @override
  State<GasolinaTela> createState() => _GasolinaTelaState();
}

class _GasolinaTelaState extends State<GasolinaTela> {
  final TextEditingController precoCombustivelController =
      TextEditingController();
  final TextEditingController tipoCombustivelController =
      TextEditingController();
  final TextEditingController dataprecoController = TextEditingController();
  DateTime? selectedDate;
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
                    "Cadastro de Combustíveis",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: precoCombustivelController,
                    decoration: const InputDecoration(
                        label: Text("Preço do Combustível")),
                  ),
                  TextField(
                    controller: tipoCombustivelController,
                    decoration: const InputDecoration(
                      label: Text("Tipo do Combustível"),
                    ),
                  ),
                  TextField(
                    controller: dataprecoController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text("Data do Preço"),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2064),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                          dataprecoController.text =
                              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"; // Formata a data
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 0, 91, 136)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          minimumSize: WidgetStatePropertyAll(Size(500, 50))),
                      onPressed: () {
                        widget.onInsert(Combustivel(
                            tipoCombustivel: tipoCombustivelController.text,
                            dataPreco: selectedDate!,
                            precoCombustivel:
                                double.parse(precoCombustivelController.text)));
                        Navigator.pop(context);
                        tipoCombustivelController.clear();
                        dataprecoController.clear();
                        precoCombustivelController.clear();
                        selectedDate = null;
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
        itemCount: widget.listaCombustivel.length,
        itemBuilder: (context, index) {
          return CardCombustivel(
            precoCombustivel: widget.listaCombustivel[index].precoCombustivel,
            tipoCombustivel: widget.listaCombustivel[index].tipoCombustivel,
            dataPreco: widget.listaCombustivel[index].dataPreco,
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
