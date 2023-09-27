import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utils/utils.dart' as utils;

class ObxCircularProgression extends StatelessWidget {
  const ObxCircularProgression({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
                      child: SpinKitSpinningLines(
                      size: 40,
                      color: utils.lightBlue,
                    ));
  }

}

