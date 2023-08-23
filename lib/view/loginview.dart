import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minigojec/common/route.dart';
import 'package:minigojec/reslayout/pallete.dart';
import 'package:minigojec/utils/bloc/login/login_bloc.dart';
import 'package:minigojec/view/customeAlertDialogView.dart';
import 'package:minigojec/view/loadinView.dart';

import 'beranda.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => LoginBloc()..add(LoginSubmit(_usernameController.text, _passController.text)),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                LoadingDialog.show(context);
              }

              if (state is LoginFailed) {
                LoadingDialog.hide(context);
                _usernameController.text.isNotEmpty && _passController.text.isNotEmpty ?  CustomeAlertDialog.show(context, "Login Gagal", state.error) : null;
              }

              if (state is LoginSuccess) {
                LoadingDialog.hide(context);
                Navigator.pushNamedAndRemoveUntil(context, BerandaPage.routeName, (route) => false);
              }

            },
            builder: (context, state) {
              return Scaffold(
                body: Stack(
                  children: [
                    Container(
                      height: 470,
                      decoration: const BoxDecoration(gradient: primaryGradient),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("LOGIN", 
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20,),
                                    TextFormField(
                                      controller: _usernameController,
                                      keyboardType: TextInputType.text,
                                      maxLength: 100,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                            return "Username Tidak Boleh Kosong";
                                        } 
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.verified_user),
                                        counterText: "",
                                        hintText: "UserName",
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    TextFormField(
                                      controller: _passController,
                                      obscureText: !_passwordVisible,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Password Tidak Boleh Kosong";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: const Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            splashRadius: 1.0,
                                            icon: Icon(!_passwordVisible ? Icons.visibility : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible = !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                    ),
                                    SizedBox(height: 30,),
                                    TextButton(
                                      onPressed: () async {
                                          if (state is! LoginLoading && _formKey.currentState!.validate()) {
                                            BlocProvider.of<LoginBloc>(context).add(LoginSubmit(_usernameController.text, _passController.text));
                                          }
                                      },
                                      child: Text("Login", style: TextStyle(color: Colors.white),),
                                      style: TextButton.styleFrom(
                                        minimumSize: Size(double.infinity, 45.0),
                                        elevation: 0,
                                        backgroundColor: primaryColor
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    );
  }

}