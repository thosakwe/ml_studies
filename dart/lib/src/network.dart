import 'layer.dart';
import 'ndarray.dart';

class Network {
  final List<Layer> layers = [];

  Network({Iterable<Layer> layers = const []}) {
    this.layers.addAll(layers ?? []);
  }
}
