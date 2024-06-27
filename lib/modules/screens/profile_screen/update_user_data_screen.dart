import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateData extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  UpdateData({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    nameController.text = cubit.userModel!.name!;
    phoneController.text = cubit.userModel!.phone!;
    emailController.text = cubit.userModel!.email!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        centerTitle: true,
        title: const Text(
          "Update User Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  label: Text("user name"), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  label: Text("email"), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                label: Text("phone"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<LayoutCubit, LayoutStates>(
              listener: (context, state) {
                if (state is UpdateDataSuccessState) {
                  showSnackBarItem(context, "Data Updated Successfully", true);
                  Navigator.pop(context);
                }
                if (state is FailedToUpdateDataWithFailureState) {
                  showSnackBarItem(context, state.error, false);
                }
              },
              builder: (context, state) {
                return MaterialButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      cubit.updateData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text);
                    } else {
                      showSnackBarItem(context, 'Please, Enter all Data !!', false);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: mainColor,
                  textColor: Colors.white,
                  minWidth: double.infinity,
                  child: Text(state is UpdateDataLoadingState
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
