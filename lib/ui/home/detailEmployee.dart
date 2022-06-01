import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/bloc/detailEmployee/detailemployee_cubit.dart';
import 'package:transisi/model/detailEmployeeModel.dart';

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
          // automaticallyImplyLeading: false,
          elevation: 0,

          title: Text(
            "Detail Employee",
            style: TextStyle(fontSize: 20),
          ),

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
            if (state is DetailEmployeeLoadingState) {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              );
            } else if (state is DetailEmployeeLoadedState) {
              Data mainData = state.responBodyDetail.data!;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(mainData.avatar!),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                            color: Colors.black87,
                            size: 30,
                          ),
                          title: Text(mainData.email!),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.black87,
                            size: 30,
                          ),
                          title: Text(
                              mainData.firstName! + " " + mainData.lastName!),
                        ),
                      ),
                    ],
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
        ));
  }
}
