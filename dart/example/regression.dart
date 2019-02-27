import 'dart:io';
import 'package:ml/ml.dart';

void main() {
  // y = 3x + 2
  var xs = NDArray.range(0, 100);
  var ys = (xs * 3) + 2;

  var network = Network(layers: [Dense(1, activation: linear, useBias: false)]);

  while (true) {
    stdout.write('Enter a number: ');
    var x = double.parse(stdin.readLineSync().trim());
    var actual = x * 3 + 2;
    var inputs = NDArray([x]);
    var computed = network.predict(inputs)[0];
    print('Actual: $actual');
    print('Computed: $computed');
  }
}
