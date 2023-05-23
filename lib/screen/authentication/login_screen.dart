import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zul_story_app/constant/app_constant.dart';
import 'package:zul_story_app/data/model/user_model.dart';
import 'package:zul_story_app/provider/auth_provider.dart';
import 'package:zul_story_app/routes/page_manager.dart';
import 'package:zul_story_app/widget/input_widget.dart';

class LoginScreen extends StatelessWidget {
  final Function() onLogin;
  final Function() onRegister;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key, required this.onLogin, required this.onRegister})
      : super(key: key);

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
                        var user = User(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        if (emailController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Your email or password is invalid"),
                            ),
                          );
                          return;
                        }

                        if (emailController.text.isEmpty) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text("Your email is invalid"),
                            ),
                          );
                          return;
                        }

                        if (passwordController.text.isEmpty) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text("Your password is invalid"),
                            ),
                          );
                          return;
                        }
                        provider.login(user, (err) {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text("Login failed: $err"),
                            ),
                          );
                          return;
                        }, (response) {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text("Logged In"),
                            ),
                          );
                          context
                              .read<PageManager>()
                              .setUserName(response.loginResult.name);

                          onLogin();
                          return;
                        });
                        // onLogin();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (provider.isLoadingLogin) ...[
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
                          const Text('Sign in')
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
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
                        onRegister();
                      },
                      child: const Text(
                        'Register',
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
