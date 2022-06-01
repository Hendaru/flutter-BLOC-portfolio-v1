import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/database/tokenDb.dart';
import 'package:transisi/model/loginModel.dart';
import 'package:transisi/model/registerModel.dart';
import 'package:transisi/model/tokenModel.dart';
import 'package:transisi/services/apiService.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future chackToken() async {
    emit(LoginLoadingState());
    TokenDb _db = TokenDb();
    await _db.getDataLogin().then((value) {
      if (value.isNotEmpty) {
        emit(TokenExistState());
      } else {
        emit(LoginInitialState());
      }
    });
  }

  Future logout() async {
    TokenDb _db = TokenDb();
    await _db.deleteLoginDb();
  }

  Future login(String email, String password) async {
    try {
      emit(LoginLoadingState());
      ApiService apiServices = ApiService();
      LoginModel request = LoginModel(email: email, password: password);
      Response? response = await apiServices.loginApi(request);
      TokenDb _db = TokenDb();

      if (response?.statusCode != 200) {
        emit(LoginErrorState(errorMessage: response?.statusMessage));
      } else {
        var res = TokenModel.fromJson(response?.data);
        await _db.saveTokenDb(TokenModel(token: res.token));
        emit(LoginSuccessState(response: "Login success"));
      }
    } catch (e) {
      // print(e);
      emit(LoginErrorState(errorMessage: "User not found"));
    }
  }

  Future register(String email, String password) async {
    try {
      emit(LoginLoadingState());
      ApiService apiServices = ApiService();
      LoginModel request = LoginModel(email: email, password: password);
      Response? response = await apiServices.registerApi(request);
      if (response?.statusCode != 200) {
        emit(LoginErrorState(errorMessage: response?.statusMessage));
      } else {
        emit(RegisterSuccessState(responseMessage: "Register Success"));
      }
    } catch (e) {
      emit(LoginErrorState(
          errorMessage: "Note: Only defined users succeed registration"));
    }
  }
}
