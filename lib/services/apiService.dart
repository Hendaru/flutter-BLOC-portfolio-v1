import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transisi/model/createEmployeeModel.dart';
import 'package:transisi/model/loginModel.dart';
import 'package:transisi/model/tokenModel.dart';
import 'package:transisi/services/dioConfigService.dart' as dioConfig;
import 'package:transisi/utils/constant.dart';

class ApiService {
  Future<Response?> loginApi(LoginModel data) async {
    final dio = await dioConfig.dio();
    final response = await dio.post(Api.BASE_URL + Api.POST_LOGIN, data: data);
    return response;
  }

  Future<Response?> registerApi(LoginModel data) async {
    final dio = await dioConfig.dio();
    final response =
        await dio.post(Api.BASE_URL + Api.POST_REGISTER, data: data);
    return response;
  }

  Future<Response?> getListEmployeeApi() async {
    final dio = await dioConfig.dio();
    final response = await dio.get(Api.BASE_URL + Api.GET_LIST_EMPLOYEE);
    return response;
  }

  Future<Response?> getDetailEmployeeApi(String detail) async {
    final dio = await dioConfig.dio();
    final response =
        await dio.get(Api.BASE_URL + Api.GET_DETAIL_EMPLOYEE + detail);
    return response;
  }

  Future<Response?> createEmployeeApi(CreateEmployeeModel data) async {
    final dio = await dioConfig.dio();
    final response =
        await dio.post(Api.BASE_URL + Api.POST_CREATE_EMPLOYEE, data: data);
    return response;
  }
}
