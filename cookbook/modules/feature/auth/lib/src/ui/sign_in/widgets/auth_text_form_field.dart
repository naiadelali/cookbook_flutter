import 'package:auth/src/theme/strings.dart';
import 'package:core_common/helpers/email_helper.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    this.isPassword = false,
    this.onSaved,
  });

  AuthTextFormField.password({this.onSaved})
      : isPassword = true,
        super();

  final bool isPassword;
  final Function(String?)? onSaved;
  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool isObscure = true;

  Widget getIconByVisibility() {
    if (isObscure) {
      return Icon(Icons.visibility);
    }

    return Icon(Icons.visibility_off);
  }

  void updateVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onSaved: widget.onSaved,
        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: widget.isPassword && isObscure,
        validator: (value) {
          if (widget.isPassword) {
            if (value!.isEmpty) {
              return ModuleStrings.reportPassword;
            }
          } else if (!EmailHelper.validate(value!)) {
            return ModuleStrings.reportYourEmail;
          }

          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: getIconByVisibility(),
                  onPressed: updateVisibility,
                )
              : null,
          hintText: widget.isPassword ? ModuleStrings.insertPassword : ModuleStrings.insertUser,
        ),
      ),
    );
  }
}
