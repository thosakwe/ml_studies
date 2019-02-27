import 'ndarray.dart';

abstract class Loss {
  NDArray compute(NDArray computed, NDArray expected);
}
