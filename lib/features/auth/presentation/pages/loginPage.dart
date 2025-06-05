import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incident_tracker/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:incident_tracker/features/auth/presentation/widgets/myInput.dart';
import 'package:incident_tracker/features/auth/presentation/widgets/mySnackBar.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          setState(() {
            isLoading = false;
          });
          MySnackBar.show(context, state.error);
        }
        if (state is AuthLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('././lib/images/logo.png', height: 70),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Center(
                child: Text(
                  'Hello Again !',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Center(
                child: Text(
                  'log into your account',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 35),
              MyInput(
                hintText: 'Email',
                suffixIcon: Icon(Icons.email),
                isPassword: false,
                textEditingController: emailController,
              ),
              MyInput(
                hintText: 'Password',
                suffixIcon: Icon(Icons.lock),
                isPassword: true,
                textEditingController: passwordController,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (isLoading) {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      MySnackBar.show(
                        context,
                        'email or password can\'t be empty',
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } else if (passwordController.text.length < 7) {
                      MySnackBar.show(
                        context,
                        'Email must be more than 6 characters',
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } else if (!EmailValidator.validate(
                      emailController.text.trim(),
                    )) {
                      MySnackBar.show(context, 'enter correct email');
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      BlocProvider.of<AuthCubit>(
                        context,
                      ).login(emailController.text, passwordController.text);
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:
                        (isLoading)
                            ? CircularProgressIndicator.adaptive()
                            : Text(
                              'Log in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
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
