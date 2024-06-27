import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/network/local_network.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        if (cubit.userModel == null) cubit.getUserData();
        return Scaffold(
          body: cubit.userModel == null
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(cubit.userModel!.image!),
                        radius: 45,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(cubit.userModel!.name!),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(cubit.userModel!.email!),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "changepassword");
                        },
                        color: mainColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text("Change Password"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "updatedata");
                        },
                        color: mainColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text("Update User Data"),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Dialogs.materialDialog(
                  msg: "Are you sure you want to Sign Out?",
                  title: "warning",
                  color: Colors.white,
                  context: context,
                  actions: [
                    MaterialButton(
                      onPressed: () async {
                        await CacheNetwork.deleteCacheData(key: "token");
                        token = await CacheNetwork.getCacheData(key: "token");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, "splash");
                      },
                      color: secondColor,
                      child: const Text(
                        "yes",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: secondColor,
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ]);
            },
            tooltip: 'Log Out',
            backgroundColor: secondColor,
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
