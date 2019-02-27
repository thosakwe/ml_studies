import 'dart:math';
import 'package:collection/collection.dart';
import 'ndarray.dart';

abstract class Layer {
  static Random _rnd;

  static Random get random => _rnd ??= Random();

  static void seedRandom(int seed) {
    if (_rnd != null) {
      throw StateError(
          'The static Random has already been set. Do this *before* creating any layers.');
    } else {
      _rnd = Random(seed);
    }
  }

  final double learningRate;

  List<int> _inputShape;

  List<int> get inputShape => _inputShape;

  set inputShape(List<int> value) {
    if (_inputShape != null) {
      throw StateError('Input shape has already been set.');
    } else {
      _inputShape = value;
    }
  }

  Layer({Iterable<int> inputShape, this.learningRate}) {
    if (inputShape != null) {
      this.inputShape = inputShape.toList();
    }
  }

  void verify(NDArray array) {
    // TODO: Shape validation
  }

  NDArray apply(NDArray inputs);
}
