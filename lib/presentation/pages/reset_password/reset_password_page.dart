import 'package:demo_getx_flutter/presentation/components/components.dart';
import 'package:demo_getx_flutter/presentation/controllers/reset_password/reset_password_controller.dart';
import 'package:demo_getx_flutter/presentation/theme/colors.dart';
import 'package:demo_getx_flutter/presentation/theme/font_alias.dart';
import 'package:demo_getx_flutter/presentation/theme/spacing_alias.dart';
import 'package:demo_getx_flutter/utils/constants/app_strings.dart';
import 'package:demo_getx_flutter/utils/validation/validate_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return KeyboardDismiss(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingAlias.Spacing15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: LabelCustom(
                    padding: EdgeInsets.zero,
                    label: AppStrings.reset_password_label,
                    fontSize: FontAlias.fontAlias28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SpacingAlias.SizeHeight80,
                LabelCustom(
                  padding: EdgeInsets.zero,
                  label: AppStrings.phone_number_label,
                  fontSize: FontAlias.fontAlias12,
                  fontWeight: FontWeight.w400,
                ),
                SpacingAlias.SizeHeight8,
                Obx(
                  () => TextFormFieldCustom(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    maxLength: 18,
                    onChanged: controller.onPhoneNumberChange,
                    suffixIcon: !ValidateUtil.isNullOrEmpty(
                      controller.phoneObs.value,
                    )
                        ? CircleIconButton(
                            onPressed: () {
                              phoneNumberController.clear();
                              controller
                                ..onPhoneNumberChange(AppStrings.empty)
                                ..resetErrorMessage();
                            },
                            icon: Icons.clear,
                          )
                        : null,
                  ),
                ),
                SpacingAlias.SizeHeight100,
                Container(
                  width: double.infinity,
                  height: 60,
                  alignment: Alignment.center,
                  child: Obx(
                    () => LabelCustom(
                      padding: EdgeInsets.zero,
                      textAlign: TextAlign.center,
                      label: controller.errorMessageObs.value,
                      fontSize: FontAlias.fontAlias12,
                      color: AppColors.redError,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SpacingAlias.SizeHeight100,
                Obx(
                  () => FlatButtonComponent(
                    enabled: controller.phoneValid.value,
                    title: AppStrings.send_url_password_reset_label,
                    fontWeight: FontWeight.bold,
                    fontSize: FontAlias.fontAlias16,
                    isTextFlexible: true,
                    onPressed: controller.navigateToConfirmSMSPage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
