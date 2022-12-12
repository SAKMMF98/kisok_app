import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/screens/login/login_viewmodel.dart';
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
      showToast(msg: "logged_in_success".tr());
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
                                hintText: "enter_kiosk_id".tr(),
                                validator: (val) =>
                                    isNotEmpty(val!, "kiosk_id".tr()),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCommonField(
                                onChanged: (val) {
                                  context.read<LoginViewModel>().password = val;
                                },
                                hintText: "password".tr(),
                                validator: (val) =>
                                    isNotEmpty(val!, "password".tr()),
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
                      child: Text(
                        'login'.tr(),
                        style: const TextStyle(
                            fontFamily: "Josefin Sans Regular",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginViewModel>().performLogin(context);
                        }
                      },
                    )
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
