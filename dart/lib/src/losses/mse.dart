import 'package:ml/ml.dart';

const MeanSquaredErrorLoss meanSquaredError = const MeanSquaredErrorLoss();

const MeanSquaredErrorLoss mse = meanSquaredError;

class MeanSquaredErrorLoss implements Loss {
  const MeanSquaredErrorLoss();

  @override
  NDArray compute(NDArray computed, NDArray expected) {
    return (expected - computed).pow(2);
  }
}
