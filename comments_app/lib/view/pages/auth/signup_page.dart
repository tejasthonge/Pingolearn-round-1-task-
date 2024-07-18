import 'package:comments_app/controller/auth_controller.dart';
import 'package:comments_app/core/theme/app_color.dart';
import 'package:comments_app/model/user_model.dart';
import 'package:comments_app/view/pages/auth/login_page.dart';
import 'package:comments_app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ligthWhite,
      appBar: const CustumAppBar(
        havBackground: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            _formTildWidget(),
            const Spacer(),
            _signUpButtonWidget(context: context),
            _haveAccountWidget(context: context),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _formTildWidget() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: _nameTEC,
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: GoogleFonts.poppins(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: _emailTEC,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: GoogleFonts.poppins(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: _passwordTEC,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: GoogleFonts.poppins(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: InputBorder.none),
                maxLength: 6,
                validator: (value) {
                  if (value!.isEmpty && value.length < 6) {
                    return 'Passwod is required and must be at least 6 characters';
                  }
                  return null;
                },
              ),
            )
          ],
        ));
  }

  Widget _signUpButtonWidget({required BuildContext context}) {
    return Consumer<AuthController>(
      builder: (context,userController,child) {
        return InkWell(
          
          onTap: ()async {
            if(_formKey.currentState!.validate()){
              String message = await userController.createUser(context: context,  user: UserModel(name: _nameTEC.text.trim(), email: _emailTEC.text.trim(), password: _passwordTEC.text.trim()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            ); 
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 6),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 180,
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Signup",
              style: GoogleFonts.poppins(
                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    );
  }

  Widget _haveAccountWidget({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Allerdy have an account?",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Text("Login",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700)))
      ],
    );
  }
}
