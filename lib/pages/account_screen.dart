import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/pages/card_screen.dart';
import 'package:bankingapp/utils/mock_data.dart';
import 'package:bankingapp/widgets/appbar_custom.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User user = mockUser;
  bool isHide = true;
  bool editMode = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    fullNameController.text = user.fullName;
    phoneNumberController.text = user.phoneNumber;
    emailController.text = user.email;
    addressController.text = user.address;
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
              Container(
                padding: EdgeInsets.only(right: 0.5 * Constants.deviceWidth),
                child: CustomButton(
                  title: 'Card',
                  onPressed: () {
                    Get.to(() => CardScreen(
                          user: user,
                        ));
                  },
                ),
              ),
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
                isHide ? '****************' : '12345678912356',
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
              _buildInforCardItem('Card Holder Name', 'George Floyd'),
              _buildInforCardItem('Expiry date', '02/30'),
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
          _buildFieldInfor('Name', user.fullName),
          _buildFieldInfor(
            'Phone Number',
            user.phoneNumber,
          ),
          _buildFieldInfor(
            'Email',
            user.email,
          ),
          _buildFieldInfor(
            'Address',
            user.address,
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
          CustomButton(title: 'Update', onPressed: () {}),
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
              bottom: 0.005 * Constants.deviceHeight,
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
