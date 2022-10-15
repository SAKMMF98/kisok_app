import 'package:ecitykiosk/screens/login/login_viewmodel.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/validations.dart';
import '../home/home_screen.dart';
import 'widgets/commonButton.dart';
import 'widgets/textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CommonValidations {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final provider = Provider.of<LoginViewModel>(context, listen: false);
    provider.onError = () {
      errorToast(msg: provider.snackBarText!);
    };
    provider.onSuccess = () {
      showToast(msg: "Logged In Success!!");
      Navigator.restorablePushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/loginImage.png",
                    ),
                    Image.asset(
                      "assets/images/brand.png",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextCommonField(
                                onChanged: (val) {
                                  context.read<LoginViewModel>().kioskId = val;
                                },
                                textInputAction: TextInputAction.next,
                                hintText: "Enter Kiosk Id",
                                validator: (val) =>
                                    isNotEmpty(val!, "Kiosk Id"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCommonField(
                                onChanged: (val) {
                                  context.read<LoginViewModel>().password = val;
                                },
                                hintText: "Password",
                                validator: (val) =>
                                    isNotEmpty(val!, "Password"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CommonButton(
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                              fontFamily: "Josefin Sans Regular",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<LoginViewModel>()
                                .performLogin(context);
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        const LoadingIndicatorConsumer<LoginViewModel>()
      ],
    );
  }
}
