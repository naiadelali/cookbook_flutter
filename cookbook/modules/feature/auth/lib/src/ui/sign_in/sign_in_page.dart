import 'package:auth/src/theme/assets.dart';
import 'package:auth/src/theme/strings.dart';
import 'package:auth/src/ui/sign_in/widgets/auth_text_form_field.dart';
import 'package:auth/src/ui/state/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          final _cubit = context.read<SignInCubit>();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 70),
                SvgPicture.asset(ModuleAssets.appLogo),
                Text(
                  ModuleStrings.flutterLoginTemplate,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthTextFormField(
                        onSaved: (value) => _email = value,
                      ),
                      AuthTextFormField.password(
                        onSaved: (value) => _password = value,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.sizeOf(context).width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30),
                            ),
                          ),
                          onPressed: () {
                            var validate = _formKey.currentState!.validate();
                            if (validate) {
                              _formKey.currentState!.save();
                              _cubit.login(_email!, _password!);
                            }
                          },
                          child: Text(ModuleStrings.login),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.sizeOf(context).width / 2, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(8),
                      ),
                    ),
                    onPressed: () => _cubit.goToExamples(),
                    child: Text(ModuleStrings.examplesButton),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
