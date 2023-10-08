import 'package:flutter/material.dart';
import 'package:myapp/views/home/coin_screen.dart';

import '../../utils/utils.dart';

class CriptoCard extends StatelessWidget {
  const CriptoCard({
    required this.titulo,
    required this.cotacao,
    required this.simbolo,
    required this.valor,
    required this.onTap,
    super.key,
  });

  final String titulo;
  final double valor;
  final double cotacao;
  final String simbolo;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                _imagem(),
                Column(
                  children: [_titulo(), _cotacao()],
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _imagem() {
    return const CircleAvatar(
      radius: 20,
    );
  }

  Widget _titulo() {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: textStyle(18, Colors.black, FontWeight.w500),
          ),
          Text(
            '\$$valor',
            style: textStyle(18, Colors.black, FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _cotacao() {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$cotacao',
            style: textStyle(
              18,
              cotacao < 0 ? Colors.red : Colors.green,
              FontWeight.w300,
            ),
          ),
          Text(
            simbolo,
            style: textStyle(18, Colors.grey, FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
