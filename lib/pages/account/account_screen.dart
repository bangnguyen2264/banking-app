import 'package:bankingapp/components/appbar_custom.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/pages/account/account_viewmodel.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountViewModel(),
      child: Consumer<AccountViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.user == null) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.1 * Constants.deviceWidth,
                ),
                child: Column(
                  children: [
                    CustomAppbar(title: 'Account'),
                    _buildAccountCard(viewModel),
                    _buildTitleInfor(viewModel),
                    !viewModel.editMode
                        ? _buildDetailInfor(viewModel)
                        : _buildUpdateInfor(viewModel),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccountCard(AccountViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 0.01 * Constants.deviceHeight),
      padding: EdgeInsets.only(
        left: 0.05 * Constants.deviceWidth,
        right: 0.05 * Constants.deviceWidth,
        top: 0.05 * Constants.deviceHeight,
        bottom: 0.01 * Constants.deviceHeight,
      ),
      width: 0.8 * Constants.deviceWidth,
      height: 0.23 * Constants.deviceHeight,
      decoration: BoxDecoration(
        gradient: AppColor.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                viewModel.isHide
                    ? hideNumberAccount(viewModel.user!.account.accountNumber)
                    : viewModel.user!.account.accountNumber,
                style: AppStyles.heading1.copyWith(color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  viewModel.toggleHide();
                },
                icon: Icon(
                  viewModel.isHide ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInforCardItem('Card Holder Name', viewModel.user!.fullName),
              SvgPicture.asset(
                'assets/components/mastercard.svg',
                width: 0.06 * Constants.deviceWidth,
                height: 0.03 * Constants.deviceWidth,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInforCardItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.paragraphSmall.copyWith(color: AppColor.neutral_3),
        ),
        Text(
          value,
          style: AppStyles.paragraphSmallBold.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTitleInfor(AccountViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'DETAIL INFORMATION',
          style: TextStyle(
            fontSize: 13,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w500,
            color: AppColor.neutral_3,
          ),
        ),
        if (!viewModel.editMode)
          IconButton(
            onPressed: viewModel.toggleEditMode,
            icon: Icon(Icons.edit, size: 15, color: AppColor.neutral_3),
          ),
      ],
    );
  }

  Widget _buildDetailInfor(AccountViewModel viewModel) {
    return Column(
      children: [
        _buildFieldInfor('Name', viewModel.user!.fullName),
        _buildFieldInfor(
          'Phone Number',
          viewModel.user!.phone ?? 'Please update your phone number',
        ),
        _buildFieldInfor('Email', viewModel.user!.email),
      ],
    );
  }

  Widget _buildUpdateInfor(AccountViewModel viewModel) {
    return Column(
      children: [
        _buildFieldUpdateInfor('Full Name', viewModel.fullNameController),
        _buildFieldUpdateInfor('Phone Number', viewModel.phoneNumberController),
        _buildFieldUpdateInfor('Email', viewModel.emailController),
        CustomButton(
          title: 'Update',
          onPressed: () {
            if (!viewModel.checkValidate()) {
              Get.snackbar('Error', viewModel.errorText!);
              return;
            }
            viewModel.handleUpdateInfo();
          },
        ),
      ],
    );
  }

  Widget _buildFieldInfor(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01 * Constants.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.paragraphSmall.copyWith(color: AppColor.neutral_3),
          ),
          Container(
            padding: EdgeInsets.only(left: 0.02 * Constants.deviceWidth),
            width: 0.8 * Constants.deviceWidth,
            height: 0.037 * Constants.deviceHeight,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColor.neutral_5,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              value != '' ? value : 'Please update your ${title.toLowerCase()}',
              style: AppStyles.paragraphSmall
                  .copyWith(color: value != '' ? Colors.black : Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldUpdateInfor(
      String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01 * Constants.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.paragraphSmall.copyWith(color: AppColor.neutral_3),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 0.02 * Constants.deviceWidth,
              bottom: 0.01 * Constants.deviceHeight,
            ),
            width: 0.8 * Constants.deviceWidth,
            height: 0.037 * Constants.deviceHeight,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColor.neutral_5,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(border: InputBorder.none),
              style: AppStyles.paragraphSmall.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
