import 'package:flutter/material.dart';

class CoinInfoColumn extends StatelessWidget {
  const CoinInfoColumn({
    required this.label,
    required this.info,

    super.key,
  });

  final Text label;
  final Text info;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          child: label,
        ),
        const SizedBox(height: 8,),
        SizedBox(
          width: 100,
          child: FittedBox(
            fit: BoxFit.contain,
            child: info,
          ),
        ),
      ],
    );
  }
}
