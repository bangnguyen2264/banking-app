import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/pages/card_screen.dart';
import 'package:bankingapp/services/user_service.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/utils/mock_data.dart';
import 'package:bankingapp/components/appbar_custom.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/components/cofirm_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  final User user;
  const AccountScreen({
    super.key,
    required this.user,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isHide = true;
  bool editMode = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? errorText;
  @override
  void initState() {
    fullNameController.text = widget.user.fullName;
    phoneNumberController.text = widget.user.phoneNumber;
    emailController.text = widget.user.email;
    addressController.text = widget.user.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.1 * Constants.deviceWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppbar(title: 'Account'),
              // Container(
              //   padding: EdgeInsets.only(right: 0.5 * Constants.deviceWidth),
              //   child: CustomButton(
              //     title: 'Card',
              //     onPressed: () {
              //       Get.to(() => CardScreen(user: widget.user),
              //           transition: Transition.rightToLeftWithFade);
              //     },
              //   ),
              // ),
              _buildAccountCard(),
              _buildTitleInfor(),
              !editMode ? _buildDetailInfor() : _buildUpdateInfor(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard() {
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
                isHide
                    ? hideNumberAccount(
                        widget.user.accountNumber[0].accountNumber)
                    : widget.user.accountNumber[0].accountNumber,
                style: AppStyles.heading1.copyWith(color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isHide = !isHide;
                  });
                },
                icon: Icon(
                  isHide ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInforCardItem('Card Holder Name', widget.user.fullName),
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

  Widget _buildTitleInfor() {
    return Container(
      margin: EdgeInsets.only(top: 0.03 * Constants.deviceHeight),
      child: Row(
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
          if (!editMode)
            IconButton(
              onPressed: () {
                setState(() {
                  editMode = !editMode;
                });
              },
              icon: Icon(
                Icons.edit,
                size: 15,
                color: AppColor.neutral_3,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailInfor() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02 * Constants.deviceHeight),
          _buildFieldInfor('Name', widget.user.fullName),
          _buildFieldInfor(
            'Phone Number',
            widget.user.phoneNumber,
          ),
          _buildFieldInfor(
            'Email',
            widget.user.email,
          ),
          _buildFieldInfor(
            'Address',
            widget.user.address,
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateInfor() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02 * Constants.deviceHeight),
          _buildFieldUpdateInfor('Full Name', fullNameController),
          _buildFieldUpdateInfor('Phone Number', phoneNumberController),
          _buildFieldUpdateInfor('Email', emailController),
          _buildFieldUpdateInfor('Address', addressController),
          CustomButton(
              title: 'Update',
              onPressed: () async {
                bool check = checkValidate();
                if (!check) {
                  showErrorDialog(
                    context,
                    errorText!,
                  );
                  return;
                }
                showConfirmDialog(
                  context,
                  'Do you want to change your information? ',
                  'Changes',
                  handleUpdateInfor,
                  false,
                );
              }),
        ],
      ),
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

  Future<void> handleUpdateInfor() async {
    final response = await UserService().update(widget.user.id, {
      'fullName': fullNameController.text.trim(),
      'phoneNumber': phoneNumberController.text.trim(),
      'email': emailController.text.trim(),
      'address': addressController.text.trim(),
    });
    if (response) {
      setState(() {
        widget.user.fullName = fullNameController.text.trim();
        widget.user.phoneNumber = phoneNumberController.text.trim();
        widget.user.email = emailController.text.trim();
        widget.user.address = addressController.text.trim();
      });
      Get.snackbar('Success', 'Update information successfully');
    } else {
      Get.snackbar('Error', 'Update information failed');
    }
    Navigator.pop(context);
    setState(() {
      editMode = false;
    });
  }

  bool checkValidate() {
    if (fullNameController.text.trim().isEmpty ||
        phoneNumberController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty) {
      setState(() {
        errorText = 'Please fill all fields';
      });
      return false;
    }
    if (!emailController.text.trim().isEmail) {
      setState(() {
        errorText = 'Email is invalid';
      });
      return false;
    }
    if (phoneNumberController.text.trim().length != 10) {
      setState(() {
        errorText = 'Phone number requires 10 digits';
      });
      return false;
    }

    return true;
  }
}
