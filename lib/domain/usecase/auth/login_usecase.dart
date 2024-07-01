import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/entity/user_profile.dart';
import 'package:flutter_firebase_architecture/domain/result.dart';
import 'package:flutter_firebase_architecture/domain/usecase/auth/dto/login_dto.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase implements UseCase<UserProfile, LoginDto> {
  final DataRepository _dataRepository;

  const LoginUseCase(this._dataRepository);

  @override
  Future<UserProfile> call(LoginDto params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.login(params.email, params.password);
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
