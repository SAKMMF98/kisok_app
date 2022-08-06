import 'package:ecitykiosk/screens/login/widgets/textformfield.dart';
import 'package:ecitykiosk/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../payment_mode_view_model.dart';

class CustomExpansion extends ExpansionPanel with CommonValidations {
  final String image, text;
  final int index;
  final bool isExpand;
  final BuildContext context;

  CustomExpansion(
      {required this.text,
      required this.image,
      required this.isExpand,
      required this.index,
      required this.context})
      : super(
            isExpanded: isExpand,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return GestureDetector(
                onTap: () => context
                    .read<PaymentModeViewModel>()
                    .updateExpansionClick = index,
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 20),
                        child: Image.asset(image)),
                    Text(
                      text,
                      style: const TextStyle(
                          fontFamily: "Josefin_Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 30, top: 10),
                  child: Column(
                    children: [
                      TextCommonField(
                        hintText: "Email Id",
                        readOnly:
                            context.read<PaymentModeViewModel>().isLoading,
                        controller: context
                            .read<PaymentModeViewModel>()
                            .emailController,
                        inlineBorderColor: const Color(0xFF717171),
                        validator: (val) {},
                      ),
                      if (image != "assets/images/coin.png")
                        Selector<PaymentModeViewModel, bool>(
                            selector: (select, provider) => provider.visible,
                            builder: (context, visible, child) {
                              return TextCommonField(
                                hintText: "Password",
                                controller: context
                                    .read<PaymentModeViewModel>()
                                    .passwordController,
                                validator: (val) {},
                                obscureText: visible,
                                readOnly: context
                                    .read<PaymentModeViewModel>()
                                    .isLoading,
                                suffix: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PaymentModeViewModel>()
                                        .visibleSet = !visible;
                                  },
                                  child: Icon(
                                    visible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFF717171),
                                  ),
                                ),
                                inlineBorderColor: const Color(0xFF717171),
                              );
                            }),
                      if (image == "assets/images/coin.png") ...[
                        TextCommonField(
                          inlineBorderColor: const Color(0xFF717171),
                          hintText: "Name",
                          readOnly:
                              context.read<PaymentModeViewModel>().isLoading,
                          controller: context
                              .read<PaymentModeViewModel>()
                              .nameController,
                          validator: (val) {},
                        ),
                        TextCommonField(
                          hintText: "Address",
                          inlineBorderColor: const Color(0xFF717171),
                          validator: (val) {},
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ));
}
