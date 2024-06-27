import 'package:ecommerce_app/modules/screens/authentication_screens/aut_cubit/auth_cubit.dart';
import 'package:ecommerce_app/modules/screens/authentication_screens/aut_cubit/auth_states.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/auth_background.jpg"),
                fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 40),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Form(
                    key: formkey,
                    child: BlocConsumer<AuthCubit, AuthStates>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "layout", (route) => false);
                        }
                        if (state is FailedToLoginState) {
                          showSnackBarItem(context, state.message , false);
                        }
                      },
                      builder: (context, state) {
                        return ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, top: 50),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, bottom: 20),
                                  child: TextFormField(
                                    controller: emailcontroller,
                                    validator: (value) {
                                      if (emailcontroller.text.isNotEmpty) {
                                        return null;
                                      } else {
                                        return " Email must not be empty";
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 3),
                                      ),
                                      fillColor: Colors.grey[380],
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordcontroller,
                                  validator: (value) {
                                    if (emailcontroller.text.isNotEmpty) {
                                      return null;
                                    } else {
                                      return " Email must not be empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 3),
                                    ),
                                    fillColor: Colors.grey[380],
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(10),
                                  ),
                                  obscureText: true,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate() ==
                                          true) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .login(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text,
                                        );
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    minWidth: double.infinity,
                                    color: mainColor,
                                    child: Text(
                                      state is LoginLoadingState
                                          ? "Loading..."
                                          : "Login",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: "Don't have an account?  ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                        TextSpan(
                                          text: "create account",
                                          style: const TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                  context, 'register');
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
