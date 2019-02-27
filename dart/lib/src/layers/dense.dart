import 'package:ml/ml.dart';

class Dense extends Layer {
  final int units;
  final Activation activation;
  final bool useBias;

  Dense(this.units,
      {this.activation,
      this.useBias = true,
      int inputDimensions,
      Iterable<int> inputShape})
      : super(inputShape: inputShape) {
    if (inputShape == null && inputDimensions != null) {
      this.inputShape = [-1, inputDimensions];
    }
  }
}
