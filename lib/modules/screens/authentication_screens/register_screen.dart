import 'package:ecommerce_app/modules/screens/authentication_screens/aut_cubit/auth_cubit.dart';
import 'package:ecommerce_app/modules/screens/authentication_screens/aut_cubit/auth_states.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacementNamed(context, 'layout');
        } else if (state is FailedToRegisterState) {
         showSnackBarItem(context, state.message , false);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: formkey,
                child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: _TextFormFieldItem(
                            controller: nameController, hinttext: "User Name"),
                      ),
                      _TextFormFieldItem(
                          controller: emailController, hinttext: "Email"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: _TextFormFieldItem(
                            controller: phoneController, hinttext: "Phone"),
                      ),
                      _TextFormFieldItem(
                          controller: passwordController,
                          hinttext: "Password",
                          isSecure: true),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).register(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: mainColor,
                          textColor: Colors.white,
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            state is RegisterLoadingState
                                ? "Loading..."
                                : "Register",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 80),
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "have an account?  ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17)),
                            TextSpan(
                              text: "login",
                              style: const TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, 'login');
                                },
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: non_constant_identifier_names
Widget _TextFormFieldItem(
    {bool? isSecure,
    required TextEditingController controller,
    required String hinttext}) {
  return TextFormField(
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return "$hinttext Must Not Be Empty";
      } else {
        return null;
      }
    },
    obscureText: isSecure ?? false,
    decoration:
        InputDecoration(hintText: hinttext, border: const OutlineInputBorder()),
  );
}
