import 'package:ml/ml.dart';

void main() {
  // y = 3x + 2
  var xs = NDArray.range(0, 100);
  var ys = (xs * 3) + 3;
  print(xs);
  print(ys);

  var network = Network(layers: [
    Dense(1),
  ]);
}
