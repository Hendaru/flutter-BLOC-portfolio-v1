import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/model/listDataEmployeeModel.dart';
import 'package:transisi/services/apiService.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeInitial());

  List<Data> dataEmployee = [];
  int page = 1;
  Future getListEmployee(String pageData) async {
    try {
      emit(HomeLoadingState());
      dataEmployee = [];
      ApiService apiServices = ApiService();
      Response? response = await apiServices.getListEmployeeApi(pageData);

      if (response?.statusCode != 200) {
        emit(HomeErrorState(errorMessage: "Error occurred"));
      } else {
        var res = ListDataEmployeeModel.fromJson(response?.data);
        page = res.page!;
        res.data?.forEach((e) => dataEmployee.add(e));
        emit(HomeLoadedState(lisDataEmployee: dataEmployee));
      }
    } catch (e) {
      print(e);
      emit(HomeErrorState(errorMessage: "Error occurred"));
    }
  }

  Future loadMoreData() async {
    try {
      var pageNext = page + 1;
      emit(HomeLoadMoreState());
      ApiService apiServices = ApiService();
      Response? response =
          await apiServices.getListEmployeeApi(pageNext.toString());
      if (response?.statusCode != 200) {
        emit(HomeErrorState(errorMessage: "Error occurred"));
      } else {
        if (response?.data.isNotEmpty) {
          var res = ListDataEmployeeModel.fromJson(response?.data);
          res.data?.forEach((e) => dataEmployee.add(e));
          emit(HomeLoadedState(lisDataEmployee: dataEmployee));
        } else {}
      }
    } catch (e) {
      print(e);
      emit(HomeErrorState(errorMessage: "Error occurred"));
    }
  }
}
