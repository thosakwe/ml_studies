import 'package:ml/ml.dart';

void main() {
  // y = 3x + 2
  var xs = NDArray.range(0, 100);
  var ys = (xs * 3) + 2;

  var network = Network(layers: [Dense(1, activation: linear, useBias: false)]);
}
