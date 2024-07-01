import 'package:flutter_firebase_architecture/domain/entity/user_profile.dart';
import 'package:flutter_firebase_architecture/domain/usecase/auth/dto/register_dto.dart';
import 'package:flutter_firebase_architecture/domain/usecase/auth/register_usecase.dart';
import 'package:flutter_firebase_architecture/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState.initial());

  Future<void> register(RegisterDto dto) async {
    state = RegisterState.loading();
    final registerUseCase = locator<RegisterUseCase>();
    await registerUseCase(dto, onError: (error) {
      state = RegisterState.error(error.toString());
    });
    state = RegisterState.success();
  }
}

final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>(
        (ref) => RegisterNotifier());

class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory RegisterState.initial() => RegisterState();
  factory RegisterState.loading() => RegisterState(isLoading: true);
  factory RegisterState.success() => RegisterState(isSuccess: true);
  factory RegisterState.error(String errorMessage) =>
      RegisterState(errorMessage: errorMessage);
}
