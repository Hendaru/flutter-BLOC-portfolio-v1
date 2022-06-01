import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/model/detailEmployeeModel.dart';
import 'package:transisi/services/apiService.dart';

part 'detailemployee_state.dart';

class DetailEmployeeCubit extends Cubit<DetailEmployeeState> {
  DetailEmployeeCubit() : super(DetailEmployeeInitial());

  Future getDetailEmployee(String detail) async {
    try {
      emit(DetailEmployeeLoadingState());
      ApiService apiServices = ApiService();
      Response? response = await apiServices.getDetailEmployeeApi(detail);
      if (response?.statusCode != 200) {
        emit(DetailEmployeeErrorState());
      } else {
        var res = DetailEmployeeModel.fromJson(response?.data);
        emit(DetailEmployeeLoadedState(responBodyDetail: res));
      }
    } catch (e) {
      emit(DetailEmployeeErrorState());
    }
  }
}
