import 'package:flutter/material.dart';

class CardDestino extends StatelessWidget {
  final String nomeDestino;
  final double distanciaDestino;
  final Function() onRemove;

  const CardDestino(
      {required this.nomeDestino,
      required this.distanciaDestino,
      required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    nomeDestino,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("$distanciaDestino",
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {
                  onRemove();
                },
                icon: const Icon(Icons.delete)),
          ],
        ));
  }
}
