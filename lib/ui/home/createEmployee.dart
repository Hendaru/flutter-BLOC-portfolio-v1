import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transisi/bloc/createEmployee/createemployee_cubit.dart';
import 'package:transisi/common/widget/customBottom.dart';

class CreateEmployee extends StatefulWidget {
  CreateEmployee({Key? key}) : super(key: key);

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
          "Create Employee",
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
      body: BlocConsumer<CreateEmployeeCubit, CreateEmployeeState>(
        listener: (context, state) {
          if (state is CreateEmployeeErrorState) {
          } else if (state is CreateEmployeeSuccessState) {
            Fluttertoast.showToast(
                msg: "employee ${state.responseBody.name!} was created");
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _form(context, state),
          );
        },
      ),
    );
  }

  Widget _form(
    context,
    state,
  ) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
            textAlign: TextAlign.center,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Form name can not empty';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _jobController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Job',
            ),
            textAlign: TextAlign.center,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Form job can not empty';
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          CustomBottom(
            isActive: true,
            title: "Add",
            onTap: () async {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<CreateEmployeeCubit>(context).createEmployee(
                  _nameController.text,
                  _jobController.text,
                );
                _jobController.clear();
                _nameController.clear();
              } else {}
            },
          ),
        ],
      ),
    );
  }
}
