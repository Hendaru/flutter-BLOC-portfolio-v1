import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/bloc/detailEmployee/detailemployee_cubit.dart';

class DetailEmployee extends StatefulWidget {
  DetailEmployee({Key? key}) : super(key: key);

  @override
  State<DetailEmployee> createState() => _DetailEmployeeState();
}

class _DetailEmployeeState extends State<DetailEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Icons.add_box_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  // BlocProvider.of<LoginCubit>(context).logout();
                  // Navigator.of(context).pushReplacementNamed(
                  //   RouteName.login,
                  // );
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
        body: BlocBuilder<DetailEmployeeCubit, DetailEmployeeState>(
          builder: (context, state) {
            //  var mainData = state.responBody ;
            if (state is DetailEmployeeLoadingState) {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              );
            } else if (state is DetailEmployeeLoadedState) {
              return Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://reqres.in/img/faces/2-image.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    Text("Detail"),
                  ],
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
        ));
  }
}
