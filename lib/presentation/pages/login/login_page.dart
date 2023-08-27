import 'package:demo_getx_flutter/presentation/components/components.dart';
import 'package:demo_getx_flutter/presentation/controllers/login/login_controller.dart';
import 'package:demo_getx_flutter/presentation/theme/colors.dart';
import 'package:demo_getx_flutter/presentation/theme/font_alias.dart';
import 'package:demo_getx_flutter/presentation/theme/spacing_alias.dart';
import 'package:demo_getx_flutter/utils/constants/app_strings.dart';
import 'package:demo_getx_flutter/utils/validation/validate_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
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
                  label: AppStrings.login_label,
                  fontSize: FontAlias.fontAlias28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SpacingAlias.SizeHeight32,
              LabelCustom(
                padding: EdgeInsets.zero,
                label: AppStrings.login_title_label,
                fontSize: FontAlias.fontAlias12,
                fontWeight: FontWeight.w400,
              ),
              SpacingAlias.SizeHeight8,
              Obx(
                () => TextFormFieldCustom(
                  controller: emailController,
                  onChanged: controller.onEmailChange,
                  suffixIcon:
                      !ValidateUtil.isNullOrEmpty(controller.emailObs.value)
                          ? CircleIconButton(
                              onPressed: () {
                                emailController.clear();
                                controller.onEmailChange("");
                              },
                              icon: Icons.clear,
                            )
                          : null,
                ),
              ),
              SpacingAlias.SizeHeight32,
              LabelCustom(
                padding: EdgeInsets.zero,
                label: AppStrings.password_label,
                fontSize: FontAlias.fontAlias12,
                fontWeight: FontWeight.w400,
              ),
              SpacingAlias.SizeHeight8,
              Obx(
                () => TextFormFieldCustom(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: controller.onPasswordChange,
                  suffixIcon:
                      !ValidateUtil.isNullOrEmpty(controller.passwordObs.value)
                          ? CircleIconButton(
                              onPressed: () {
                                passwordController.clear();
                                controller.onPasswordChange("");
                              },
                              icon: Icons.clear,
                            )
                          : null,
                ),
              ),
              SpacingAlias.SizeHeight16,
              Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                child: Obx(
                  () => LabelCustom(
                    padding: EdgeInsets.zero,
                    textAlign: TextAlign.center,
                    label: controller.errorMessage.value,
                    fontSize: FontAlias.fontAlias12,
                    color: AppColors.redError,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SpacingAlias.SizeHeight20,
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: controller.forgotPasswordAction,
                  child: LabelCustom(
                    padding: EdgeInsets.zero,
                    textAlign: TextAlign.center,
                    label: AppStrings.forgot_password_label,
                    fontSize: FontAlias.fontAlias12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SpacingAlias.SizeHeight20,
              Obx(
                () => FlatButtonComponent(
                  enabled: controller.enableButton.value,
                  title: AppStrings.login_label,
                  fontWeight: FontWeight.bold,
                  fontSize: FontAlias.fontAlias18,
                  onPressed: controller.loginAction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
