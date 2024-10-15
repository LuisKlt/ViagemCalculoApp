import 'package:viagemcalculo/calculoTela.dart';
import 'package:viagemcalculo/carroTela.dart';
import 'package:viagemcalculo/destinoTela.dart';
import 'package:viagemcalculo/gasolinaTela.dart';
import 'package:viagemcalculo/model/carros.dart';
import 'package:viagemcalculo/model/combustivel.dart';
import 'package:viagemcalculo/model/destinos.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppCustoViagem());
}

class AppCustoViagem extends StatefulWidget {
  const AppCustoViagem({super.key});

  @override
  State<AppCustoViagem> createState() => _AppCustoViagemState();
}

class _AppCustoViagemState extends State<AppCustoViagem> {
  int telaSelecionada = 0;

  List<Carros> listaCarros = [
    Carros(nomeCarro: "Audi RS3", autonomia: 11.2),
    Carros(nomeCarro: "BMW M3", autonomia: 9.8),
  ];

  List<Destinos> listaDestinos = [
    Destinos(nomeDestino: "Santa Maria", distanciaDestino: 240),
    Destinos(nomeDestino: "Porto Alegre", distanciaDestino: 490),
  ];

  List<Combustivel> listaCombustivel = [
    Combustivel(
        precoCombustivel: 6.69,
        tipoCombustivel: "Gasolina",
        dataPreco: DateTime.now()),
    Combustivel(
        precoCombustivel: 4.49,
        tipoCombustivel: "Álcool",
        dataPreco: DateTime.now()),
  ];

  void _removerCarro(int index) {
    setState(() {
      listaCarros.removeAt(index);
    });
  }

  void _inserirCarro(Carros novoCarro) {
    setState(() {
      listaCarros.add(novoCarro);
    });
  }

  void _inserirDestino(Destinos novoDestino) {
    setState(() {
      listaDestinos.add(novoDestino);
    });
  }

  void _removerDestino(int index) {
    setState(() {
      listaDestinos.removeAt(index);
    });
  }

  void _inserirCombustivel(Combustivel novoCombustivel) {
    setState(() {
      listaCombustivel.add(novoCombustivel);
    });
  }

  void _removerCombustivel(int index) {
    setState(() {
      listaCombustivel.removeAt(index);
    });
  }

  void opcaoSelecionada(int opcao) {
    setState(() {
      telaSelecionada = opcao;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listaTelas = <Widget>[
      CalculoTela(
          carros: listaCarros,
          destinos: listaDestinos,
          combustivel: listaCombustivel),
      CarroTela(
          listaCarros: listaCarros,
          onInsert: _inserirCarro,
          onRemove: _removerCarro),
      DestinoTela(
          listaDestinos: listaDestinos,
          onInsert: _inserirDestino,
          onRemove: _removerDestino),
      GasolinaTela(
          listaCombustivel: listaCombustivel,
          onInsert: _inserirCombustivel,
          onRemove: _removerCombustivel),
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "App Custo Viagem",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("App Custo Viagem"),
            backgroundColor: const Color.fromARGB(255, 0, 91, 136),
            foregroundColor: Colors.white,
          ),
          body: Center(child: listaTelas[telaSelecionada]),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: const Color.fromARGB(255, 94, 94, 94),
            fixedColor: const Color.fromARGB(255, 0, 91, 136),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_rounded),
                label: 'Calculo',
                backgroundColor: Color.fromARGB(255, 196, 196, 196),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_rental_rounded),
                label: 'Carro',
                backgroundColor: Color.fromARGB(255, 196, 196, 196),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_rounded),
                label: 'Destinos',
                backgroundColor: Color.fromARGB(255, 196, 196, 196),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.gas_meter_rounded),
                label: 'Gasolina',
                backgroundColor: Color.fromARGB(255, 196, 196, 196),
              ),
            ],
            currentIndex: telaSelecionada,
            onTap: opcaoSelecionada,
          ),
        ));
  }
}
