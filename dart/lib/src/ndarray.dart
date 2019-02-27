import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:quiver_hashcode/hashcode.dart';

/// A multi-dimensional view of a numeric array.
class NDArray extends IterableBase<double> {
  /// The underlying list of values.
  final List<double> value;

  /// The dimensions of the array.
  final List<int> shape;

  /// Generates an NDArray from a range of values.
  factory NDArray.range(double lower, double upper,
      {Iterable<int> shape = const [1]}) {
    var value =
        List<double>.generate((upper - lower).toInt(), (i) => lower + i);
    return NDArray(value, shape: shape);
  }

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

  /// Computes a new NDArray after performing an operation [f] on this and another value.
  NDArray binary(obj, double Function(double, double) f) {
    if (obj is num) {
      var dObj = obj.toDouble();
      var newValue = value.map((x) => f(x, dObj));
      return NDArray(newValue, shape: shape);
    }

    throw ArgumentError(obj);
  }

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

  NDArray operator *(other) => binary(other, (a, b) => a * b);
  NDArray operator /(other) => binary(other, (a, b) => a / b);
  NDArray operator %(other) => binary(other, (a, b) => a % b);
  NDArray operator +(other) => binary(other, (a, b) => a + b);
  NDArray operator -(other) => binary(other, (a, b) => a - b);
}
