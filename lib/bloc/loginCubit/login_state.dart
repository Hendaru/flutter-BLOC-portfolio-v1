part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class TokenExistState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String? response;
  const LoginSuccessState({this.response});
  // late final TokenModel response;
  // LoginSuccessState({required this.response});
}

class RegisterSuccessState extends LoginState {
  final String? responseMessage;
  RegisterSuccessState({this.responseMessage});
}

class LoginErrorState extends LoginState {
  final String? errorMessage;
  LoginErrorState({this.errorMessage});
}
