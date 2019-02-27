import 'package:ml/ml.dart';

const LinearActivation linear = const LinearActivation();

class LinearActivation implements Activation {
  const LinearActivation();

  @override
  NDArray compute(NDArray input) => input;
}
