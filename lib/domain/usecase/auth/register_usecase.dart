import 'package:flutter_firebase_architecture/domain/data_repository.dart';
import 'package:flutter_firebase_architecture/domain/entity/user_profile.dart';
import 'package:flutter_firebase_architecture/domain/usecase/auth/dto/register_dto.dart';
import 'package:flutter_firebase_architecture/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../result.dart';

@injectable
class RegisterUseCase implements UseCase<UserProfile, RegisterDto> {
  final DataRepository _dataRepository;

  const RegisterUseCase(this._dataRepository);

  @override
  Future<UserProfile> call(RegisterDto params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.register(
        params.email, params.password, params.name);
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
