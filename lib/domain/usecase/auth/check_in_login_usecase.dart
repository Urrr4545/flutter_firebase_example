import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckIsLoginUseCase implements UseCase<bool, void> {
  final DataRepository _dataRepository;

  const CheckIsLoginUseCase(this._dataRepository);

  @override
  Future<bool> call(void params, {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.isLogin();
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
