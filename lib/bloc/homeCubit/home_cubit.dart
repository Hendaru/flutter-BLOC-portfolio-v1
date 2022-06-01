import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/model/listDataEmployeeModel.dart';
import 'package:transisi/services/apiService.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeInitial());

  Future getListEmployee() async {
    try {
      emit(HomeLoadingState());
      ApiService apiServices = ApiService();
      Response? response = await apiServices.getListEmployeeApi();
      if (response?.statusCode != 200) {
        emit(HomeErrorState(errorMessage: "Error occurred"));
      } else {
        var res = ListDataEmployeeModel.fromJson(response?.data);
        emit(HomeLoadedState(responseBody: res));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: "Error occurred"));
    }
  }
}
