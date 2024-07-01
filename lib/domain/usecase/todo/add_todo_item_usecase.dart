import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddTodoItemUseCase implements UseCase<void, String> {
  final DataRepository _dataRepository;

  const AddTodoItemUseCase(this._dataRepository);

  @override
  Future<void> call(String params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.addTodoItem(params);
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
