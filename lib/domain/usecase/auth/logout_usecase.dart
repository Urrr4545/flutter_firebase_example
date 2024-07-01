import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase implements UseCase<void, void> {
  final DataRepository _dataRepository;

  const LogoutUseCase(this._dataRepository);

  @override
  Future<void> call(void params, {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.logout();
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
