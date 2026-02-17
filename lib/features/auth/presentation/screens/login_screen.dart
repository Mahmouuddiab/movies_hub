import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/layout/screen/layout_screen.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/vaildators/app_validators.dart';
import 'package:movies/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies/features/auth/presentation/cubit/auth_states.dart';
import 'package:movies/shared/custom_button.dart';
import 'package:movies/shared/custom_field.dart';
import 'package:movies/shared/custom_text.dart';
import 'package:movies/shared/snack.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> images = [
    "assets/facebook.jpg",
    "assets/google.png"
  ];

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  AuthCubit authCubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      bloc: authCubit,
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CustomSnackBar.success(context, "Success Login");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LayoutScreen(),));
        }
        if (state is LoginErrorState) {
          CustomSnackBar.error(context, state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.black,
          body: Form(
            key: formKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Gap(150),
                    Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.italianno(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            letterSpacing: 5
                        ),
                      ),
                    ),
                    Gap(40),
                    CustomField(
                      hintTxt: "Email",
                      prefixIcon: Icon(Icons.email,color: AppColors.grey,),
                      obscureText: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (_) => AppValidators.emailValidator(emailController.text),
                    ),
                    Gap(20),
                    CustomField(
                      hintTxt: "Password",
                      prefixIcon: Icon(Icons.lock,color: AppColors.grey,),
                      obscureText: obscurePassword,
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      validator: (_) => AppValidators.passwordValidator(passwordController.text),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(obscurePassword? Icons.visibility_off:Icons.visibility)
                      ),
                    ),
                    Gap(15),
                    CustomText(
                      text: "Forgot Password?",
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(30),
                    CustomButton(
                        onPressed: (){
                          authCubit.login(emailController.text, passwordController.text);
                        },
                        child: state is LoginLoadingState? CircularProgressIndicator(color: AppColors.black,)
                          :CustomText(
                           text: "Login",
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )
                    ),
                    Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        CustomText(
                          text: "Don't have an account?",
                          color: AppColors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "Register",
                          color: AppColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Gap(30),
                    CustomText(
                      text: "or",
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(70),
                    Icon(Icons.facebook,color: AppColors.white,size: 70,)
                  ],
                ),
              ),
            ),
          ),
        )  ;
      },
    );
  }
}
