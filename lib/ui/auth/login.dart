import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transisi/bloc/homeCubit/home_cubit.dart';
import 'package:transisi/bloc/loginCubit/login_cubit.dart';
import 'package:transisi/common/widget/customBottom.dart';
import 'package:transisi/router/routeName.dart';
import 'package:transisi/ui/home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController =
      TextEditingController(text: "eve.holt@reqres.in");
  TextEditingController _passwordController =
      TextEditingController(text: "cityslicka");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _registerLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) async {
        print(state);
        if (state is LoginErrorState) {
          Fluttertoast.showToast(msg: state.errorMessage!);
        } else if (state is LoginSuccessState) {
          await BlocProvider.of<HomeCubit>(context).getListEmployee();

          Fluttertoast.showToast(msg: state.response!);
          Navigator.of(context).pushReplacementNamed(
            RouteName.home,
          );
        } else if (state is RegisterSuccessState) {
          Fluttertoast.showToast(msg: state.responseMessage!);
        }
        //  else if (state is TokenExistState) {
        //   Navigator.of(context).pushReplacementNamed(
        //     RouteName.home,
        //   );
        // }
      }, builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: colorBlue,
                ),
              ),
              SizedBox(height: 20),
              _form(state, context),
              SizedBox(height: 20),
              _register(context)
            ],
          ),
        );
        // if (state is TokenExistState) {
        //   return Home();
        // } else if (state is LoginInitialState) {

        // } else if (state is LoginLoadingState) {
        //   return Center(
        //     child: SizedBox(
        //       child: CircularProgressIndicator(),
        //       height: 50.0,
        //       width: 50.0,
        //     ),
        //   );
        // }
        // return Center(
        //   child: SizedBox(
        //     child: CircularProgressIndicator(),
        //     height: 50.0,
        //     width: 50.0,
        //   ),
        // );
      }),
    );
  }

  Widget _form(state, context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
            textAlign: TextAlign.center,
            validator: (text) {
              final pattern = RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (text == null || text.isEmpty) {
                return 'Form tidak boleh kosong,';
              } else {
                if (!pattern.hasMatch(text)) {
                  return 'Masukkan e-mail yang valid.';
                }
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
            textAlign: TextAlign.center,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Form tidak boleh kosong,';
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          _registerLoad
              ? CustomBottom(
                  isActive: true,
                  title: "Register",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).register(
                        _emailController.text,
                        _passwordController.text,
                      );
                    } else {}
                  },
                )
              : CustomBottom(
                  isActive: true,
                  title: "Login",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).login(
                        _emailController.text,
                        _passwordController.text,
                      );
                    } else {}
                  },
                ),
        ],
      ),
    );
  }

  Widget _register(state) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          // BlocProvider.of<LoginCubit>(context).chackToken();
          setState(() {
            // _passwordController.clear();
            // _emailController.clear();
            _registerLoad = !_registerLoad;
          });
        },
        child: RichText(
          text: TextSpan(
              text: _registerLoad ? 'Sudah punya akun? ' : 'Belum punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: _registerLoad ? 'Login' : 'Register',
                ),
              ]),
        ),
      ),
    );
  }
}
