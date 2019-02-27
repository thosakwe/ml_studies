import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:quiver_hashcode/hashcode.dart';

/// A multi-dimensional view of a numeric array.
class NDArray extends IterableBase<double> {
  /// The underlying list of values.
  final List<double> value;

  /// The dimensions of the array.
  final List<int> shape;

  NDArray(Iterable<double> value, {Iterable<int> shape = const [1]})
      : this.shape = shape.toList(),
        this.value = value.toList() {
    var size = shape.reduce((a, b) => a * b);

    if (size != value.length) {
      throw ArgumentError.value(value, 'value', 'must have length $size');
    }
  }

  @override
  Iterator<double> get iterator => value.iterator;

  /// Returns a new [NDArray], with an identical [value], but a different [shape].
  NDArray reshape(Iterable<int> newShape) {
    var newLength = newShape.reduce((a, b) => a * b);
    if (newLength != value.length) {
      throw ArgumentError.value(
          value, 'newShape', 'is incompatible with shape $shape');
    }

    return NDArray(value, shape: newShape);
  }

  @override
  int get hashCode => hash2(value, shape);

  @override
  bool operator ==(other) {
    return other is NDArray &&
        ListEquality().equals(value, other.value) &&
        ListEquality().equals(shape, other.shape);
  }
}
