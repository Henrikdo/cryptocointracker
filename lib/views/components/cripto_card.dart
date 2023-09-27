import 'package:flutter/material.dart';
import 'package:myapp/views/components/circular_progression.dart';


import '../../utils/utils.dart';

class CriptoCard extends StatelessWidget {
  const CriptoCard({
    required this.titulo,
    required this.cotacao,
    required this.simbolo,
    required this.valor,
    required this.onTap,
    required this.image,
    required this.context,
    super.key,
  });

  final String titulo;
  final double valor;
  final double cotacao;
  final String simbolo;
  final String image;
  final BuildContext context;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                _imagem(),
                _infoWrapper()
              ],
            ),
          ),
          const Divider(
              height: 25,
              thickness: 1,
              indent: 8,
              endIndent: 10,
              color: Colors.grey),
        ],
      ),
    );
  }

  Widget _infoWrapper() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(children: [
        _titulo(),
        _valor()
      ]),
    );
  }

  Widget _imageBox() {
    return Image.network(image, loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return ObxCircularProgression();
    });
  }

  Widget _imagem() {
    return Container(
      width: 60,
      height: 60,
      decoration: _imageBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: _imageBox(),
        ),
      ),
    );
  }

  Widget _titulo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: textStyle(18, Colors.black, FontWeight.w500),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
          Text(
            cotacao > 0 ? '+$cotacao %' : '$cotacao %',
            style: textStyle(
                18, cotacao > 0 ? Colors.green : Colors.red, FontWeight.w300),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget _valor() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$$valor',
            style: textStyle(18, Colors.black, FontWeight.w200),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
          Text(
            simbolo.toUpperCase(),
            style: textStyle(18, Colors.grey, FontWeight.w600),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          )
        ],
      ),
    );
  }

  BoxDecoration _imageBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [lightBlue, mainBlue]),
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: lightBlue, offset: Offset(2, 2), blurRadius: 5)
        ]);
  }
}
