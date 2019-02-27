import 'ndarray.dart';

abstract class Activation {
  NDArray compute(NDArray input);
}
