import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasssword extends StatelessWidget {
  final currentPassswordController = TextEditingController();
  final newPassswordController = TextEditingController();
  ChangePasssword({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        centerTitle: true,
        title: const Text(
          "Change Passsword",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: currentPassswordController,
              decoration: const InputDecoration(
                  hintText: "Current Passsword", border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: newPassswordController,
              decoration: const InputDecoration(
                hintText: "New Passsword",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<LayoutCubit, LayoutStates>(
              listener: (context, state) {
                if (state is ChangePasswordSuccessState) {
                  showSnackBarItem(
                      context, "Password Updated Successfully", true);
                  Navigator.pop(context);
                }
                if (state is FailedToChangePasswordWithFailureState) {
                  showSnackBarItem(context, state.error, false);
                }
              },
              builder: (context, state) {
                return MaterialButton(
                  onPressed: () {
                    if (currentPassswordController.text.trim() ==
                        currentPassword) {
                      if (newPassswordController.text.length >= 6) {
                        cubit.changePassword(
                            userCurrentPassword: currentPassword!,
                            newPassword: newPassswordController.text.trim());
                      } else {
                        showSnackBarItem(context,
                            "Password Must Be At Least 6 Characters", false);
                      }
                    } else {
                      showSnackBarItem(
                          context,
                          "Please, Verfiy Your Current Password, And Try Again",
                          false);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: mainColor,
                  textColor: Colors.white,
                  minWidth: double.infinity,
                  child: Text(state is ChangePasswordLoadingState
                      ? "loading..."
                      : "update"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
