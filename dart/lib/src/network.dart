import 'package:ml/ml.dart';

class Network {
  final List<Layer> layers = [];

  Network({Iterable<Layer> layers = const []}) {
    this.layers.addAll(layers ?? []);
  }

  void add(Layer layer) => layers.add(layer);

  void train(NDArray inputs, NDArray expected,
      {int epochs = 10, Loss loss = mse}) {
    for (int epoch = 1; epoch <= epochs; epoch++) {
      var computed = predict(inputs);

      for (int i = layers.length - 1; i >= 0; i--) {
        var error = loss.compute(computed, expected);
      }
    }
  }

  NDArray predict(NDArray inputs) {
    for (var layer in layers) {
      inputs = layer.apply(inputs);
    }

    return inputs;
  }
}
