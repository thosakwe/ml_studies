abstract class Layer {
  List<int> _inputShape;

  List<int> get inputShape => _inputShape;

  set inputShape(List<int> value) {
    if (_inputShape != null) {
      throw StateError('Input shape has already been set.');
    } else {
      _inputShape = value;
    }
  }

  Layer({Iterable<int> inputShape}) {
    if (inputShape != null) {
      this.inputShape = inputShape.toList();
    }
  }
}
