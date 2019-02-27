import 'package:ml/ml.dart';

class Dense extends Layer {
  final int units;
  final Activation activation;
  final bool useBias;
  NDArray _weights, _bias;

  Dense(this.units,
      {this.activation = linear,
      this.useBias = true,
      int inputDimensions,
      Iterable<int> inputShape})
      : super(inputShape: inputShape) {
    if (inputShape == null && inputDimensions != null) {
      this.inputShape = [-1, inputDimensions];
    }
  }

  @override
  NDArray apply(NDArray inputs) {
    inputShape ??= inputs.shape;

    if (_bias == null) {
      // TODO: Bias
      _bias = NDArray(List<double>.filled(inputs.length, 0), shape: inputShape);
    }

    if (_weights == null) {
      // TODO: Actual weight distribution...
      _weights = NDArray(
          List<double>.generate(
              inputs.length, (_) => Layer.random.nextDouble()),
          shape: inputShape);
    }

    return activation.compute(inputs.dot(_weights)) + _bias;
  }
}
