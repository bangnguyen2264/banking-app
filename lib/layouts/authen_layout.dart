import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthenLayout extends StatefulWidget {
  final String title;
  final Widget mainContent;
  const AuthenLayout({
    super.key,
    required this.title,
    required this.mainContent,
  });

  @override
  State<AuthenLayout> createState() => _AuthenLayoutState();
}

class _AuthenLayoutState extends State<AuthenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Constants.deviceHeight,
          decoration: BoxDecoration(
            gradient: AppColor.bgColor,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: widget.mainContent,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(
        top: 0.08 * Constants.deviceHeight,
        left: 0.12 * Constants.deviceWidth,
        bottom: 0.013 * Constants.deviceWidth,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            widget.title,
            style: AppStyles.heading2.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return SvgPicture.asset(
      'assets/components/footer.svg',
      height: 0.12 * Constants.deviceHeight,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
