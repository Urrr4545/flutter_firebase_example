import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/todo/dto/update_todo_dto.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTodoItemUseCase implements UseCase<void, UpdateTodoDto> {
  final DataRepository _dataRepository;

  const UpdateTodoItemUseCase(this._dataRepository);

  @override
  Future<void> call(UpdateTodoDto params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.updateTodoItem(params);
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
