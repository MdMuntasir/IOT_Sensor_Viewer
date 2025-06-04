import 'package:iot/core/network/data_state.dart';

abstract class UseCase<Type, Params> {
  Future<DataState<Type>> call({Params para});
}