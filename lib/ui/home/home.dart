import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/bloc/detailEmployee/detailemployee_cubit.dart';
import 'package:transisi/bloc/homeCubit/home_cubit.dart';
import 'package:transisi/bloc/loginCubit/login_cubit.dart';
import 'package:transisi/model/listDataEmployeeModel.dart';
import 'package:transisi/router/routeName.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            RouteName.createEmployee,
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "List Employees",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                BlocProvider.of<LoginCubit>(context).logout();
                Navigator.of(context).pushReplacementNamed(
                  RouteName.login,
                );
              })
        ],
        leading: null,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF01AEA7), Color(0xFF2B6080)])),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeCubitState>(
        builder: (context, state) {
          if (state is HomeLoadingState || state is HomeErrorState) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            );
          } else if (state is HomeLoadedState) {
            List<Data> mainData = state.responseBody.data!;
            return ListView.builder(
              padding: EdgeInsets.only(top: 0),
              itemCount: mainData.length,
              itemBuilder: (BuildContext context, int index) => Card(
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<DetailEmployeeCubit>(context)
                        .getDetailEmployee(mainData[index].id.toString());
                    Navigator.of(context).pushNamed(
                      RouteName.detailEmployee,
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(mainData[index].avatar!),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(mainData[index].firstName!),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            );
          }
        },
      ),
    );
  }
}
