import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/websites/screens/websites_screen.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/custom_button.dart';
import 'package:pulse/widgets/custom_text_field.dart';
import 'package:pulse/widgets/mordern_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/endpoints.dart';
import '../../../utils/navigation.dart';
import '../../../utils/utils.dart';
import '../cubit/auth_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();
  bool isAutoValidate = false;
  bool isHidden = true;

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            Toast.showToast(message: state.message, context: context);
          }
          if (state is AuthLoaded) {
            Navigation.go(
                screen: WebsitesScreen(), context: context, replace: true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: isAutoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                    ),
                    Text('Sign In',
                        style: kTitleTextStyle.copyWith(fontSize: 30)),
                    Text('Please sign in to continue',
                        style: kBodyTitleTextStyle),
                    CustomTextField(
                      preIcon: Icons.link_rounded,
                      hint: Endpoints.baseUrl,
                      title: 'Host URL',
                      type: TextInputType.emailAddress,
                      disabled: true,
                      // validator: (val) {
                      //   if (val!.isEmpty) {
                      //     return 'This field is required';
                      //   } else if (!isValidEmail(val)) {
                      //     return 'Enter a valid email address';
                      //   }
                      //   return null;
                      // },
                    ),
                    CustomTextField(
                      data: email,
                      preIcon: Icons.email_rounded,
                      hint: 'Email',
                      title: 'Email Address',
                      type: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'This field is required';
                        } else if (!isValidEmail(val)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      data: pwd,
                      preIcon: Icons.lock_rounded,
                      hint: 'Password',
                      title: 'Password',
                      type: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      obs: isHidden,
                      suffIcon: IconButton(
                        onPressed: () {
                          setState(() => isHidden = !isHidden);
                        },
                        icon: Icon(
                          isHidden ? Iconsax.eye_slash_bold : Iconsax.eye_bold,
                          color: kGreyColor,
                        ),
                      ),
                    ),
                    MordernBtn(
                      icon: Icons.lock_outline_rounded,
                      title: 'Forgot Password?',
                      textColor: kPrimaryColor,
                      click: () => Links.goToLink(
                          'https://cloud.umami.is/forgot-password'),
                    ),
                    SizedBox(height: 0),
                    CustomButton(
                      btnText: 'SIGN IN',
                      click: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        bool isValid = formKey.currentState!.validate();
                        if (isValid) {
                          context.read<AuthCubit>().signIn(
                              email: email.text.trim(), pwd: pwd.text.trim());
                        } else {
                          setState(() => isAutoValidate = true);
                        }
                      },
                      isLoading: state is AuthLoading,
                    ),
                    TextButton(
                      onPressed: () =>
                          Links.goToLink('https://cloud.umami.is/signup'),
                      child: Text('Don\'t have an account? Sign Up',
                          style: kBodyTitleTextStyle.copyWith(
                              color: kPrimaryColor.withOpacity(.6))),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
