import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Login/LoginCubit/loginCubit.dart';
import 'package:shop_app/Modules/Login/LoginCubit/loginStates.dart';
import 'package:shop_app/Modules/Register/registerScreen.dart';
import 'package:shop_app/Shared/Compenents/compenents.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var formkey = GlobalKey<FormState>();
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFromFiled(
                          type: TextInputType.emailAddress,
                          prefix: const Icon(Icons.mail_outlined),
                          control: emailController,
                          lable: 'Email adrress',
                          valid: (value) {
                            if (value?.isEmpty == true) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFromFiled(
                          type: TextInputType.visiblePassword,
                          prefix: const Icon(Icons.key_outlined),
                          suffix: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility)),
                          control: passwordController,
                          lable: 'Password',
                          valid: (value) {
                            if (value!.length < 8) {
                              return 'The password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formkey.currentState?.validate() == true) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'LOGIN'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('If you dont have account?, '),
                            defaultTextButton(
                                function: () {
                                  navigateTo(
                                      context: context,
                                      widget: RegisterScreen());
                                },
                                text: 'Register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
