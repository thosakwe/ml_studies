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
  factory NDArray.range(double lower, double upper, {Iterable<int> shape}) {
    var value =
        List<double>.generate((upper - lower).toInt(), (i) => lower + i);
    return NDArray(value, shape: shape);
  }

  NDArray(Iterable<double> value, {Iterable<int> shape})
      : this.shape = (shape ?? [value.length]).toList(),
        this.value = value.toList() {
    var size = this.shape.reduce((a, b) => a * b);

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
    } else if (obj is NDArray) {
      // TODO: Validate shape is compatible
      var newValue = <double>[];

      for (int i = 0; i < value.length; i++) {
        newValue.add(f(value[i], obj.value[i]));
      }

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
        ShapeEquality().equals(shape, other.shape);
  }

  NDArray operator *(other) => binary(other, (a, b) => a * b);
  NDArray operator /(other) => binary(other, (a, b) => a / b);
  NDArray operator %(other) => binary(other, (a, b) => a % b);
  NDArray operator +(other) => binary(other, (a, b) => a + b);
  NDArray operator -(other) => binary(other, (a, b) => a - b);

  NDArray matmul(NDArray other) {
    throw UnimplementedError();
  }

  NDArray dot(NDArray other) {
    if (shape.length == 1 && other.shape.length == 1) {
      return this * other;
    } else if (shape.length == 2 && other.shape.length == 2) {
      return matmul(other);
    } else {
      throw UnimplementedError('more dot products to come...');
    }
  }

  @override
  int get length => value.length;

  double operator [](int index) => value[index];
}

/// Compares [NDArray] shapes.
class ShapeEquality implements Equality<List<int>> {
  const ShapeEquality();

  @override
  bool equals(List<int> e1, List<int> e2) {
    if (e1.length != e2.length) return false;

    for (int i = 0; i < e1.length; i++) {
      var a = e1[i], b = e2[i];
      if (a != -1 && b != -1 && a != b) return false;
    }

    return true;
  }

  @override
  int hash(List<int> e) => ListEquality<int>().hash(e);

  @override
  bool isValidKey(Object o) => o is List<int>;
}
