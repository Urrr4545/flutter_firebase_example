import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTodoItemUseCase implements UseCase<void, String> {
  final DataRepository _dataRepository;

  const DeleteTodoItemUseCase(this._dataRepository);

  @override
  Future<void> call(String params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.deleteTodoItem(params);
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
