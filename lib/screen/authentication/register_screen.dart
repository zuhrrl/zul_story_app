import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zul_story_app/constant/app_constant.dart';
import 'package:zul_story_app/data/model/user_model.dart';
import 'package:zul_story_app/provider/auth_provider.dart';
import 'package:zul_story_app/widget/input_widget.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Function() toLoginPage;
  RegisterScreen({Key? key, required this.toLoginPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
              child: Container(
            margin: const EdgeInsetsDirectional.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Story App',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        'Share your best moment',
                        style: TextStyle(fontSize: 14, color: navyColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Nama Lengkap',
                  style: TextStyle(color: navyColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputWidget(
                  textEditingController: nameController,
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'ex: John Doe',
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Email or Username',
                  style: TextStyle(color: navyColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputWidget(
                  textEditingController: emailController,
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
                    color: Colors.grey,
                  ),
                  hintText: 'email@gmail.com',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Password', style: TextStyle(color: navyColor)),
                const SizedBox(
                  height: 5,
                ),
                InputWidget(
                  textEditingController: passwordController,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  hintText: 'Password',
                  obscureText: true,
                  enableSuggestion: false,
                  autoCorrect: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);

                        var user = User(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                        provider.register(user, (err) {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text("Register failed: $err"),
                            ),
                          );
                          return;
                        }, (response) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text("Register success"),
                            ),
                          );
                          toLoginPage();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (provider.isLoadingRegister) ...[
                            Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                          const Text('Register')
                        ],
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Don\'t have account?'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        toLoginPage();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
