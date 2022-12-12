import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/payment_mode_view_model.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_utils/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static const String routeName = "/otpScreen";

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    getViewModel<PaymentModeViewModel>(context, (viewModel) {
      viewModel.pinMatchedSuccess = (userId) {
        Navigator.pop(context, userId);
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = ModalRoute.of(context)?.settings.arguments as String;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: commonAppBar(
              title: Text(
                "otp".tr(),
                style: const TextStyle(
                    fontFamily: "Josefin_Sans",
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              isCenter: true),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/pincode.png',
                        height: 200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 100.0,
                  margin: const EdgeInsets.all(20.0),
                  child: PinCodeTextField(
                    onChanged: (value) {
                      if (value.length >= 4 &&
                          !context.read<PaymentModeViewModel>().isLoading) {
                        context
                            .read<PaymentModeViewModel>()
                            .pinMatch(userId: userId, pin: value);
                      }
                    },
                    appContext: context,
                    autoDismissKeyboard: true,
                    pastedTextStyle: const TextStyle(
                      color: Color(0xffC4C4C4),
                    ),
                    validator: (v) {
                      if (v!.length < 3) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      activeFillColor: AppColors.appColor,
                      activeColor: AppColors.appColor,
                      disabledColor: AppColors.appColor,
                      selectedFillColor: AppColors.appColor,
                      selectedColor: AppColors.appColor,
                      inactiveColor: AppColors.appColor,
                      inactiveFillColor: AppColors.appColor,
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    length: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.send,
                    enableActiveFill: true,
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
                const SizedBox(height: 60.0),
                KeyboardAware(
                  builder: (context, keyboardConfig) {
                    return SizedBox(
                      height: keyboardConfig.keyboardHeight,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const LoadingIndicatorConsumer<PaymentModeViewModel>()
      ],
    );
  }
}
