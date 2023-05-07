import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goforcate_app/pages/login/login_quick_page.dart';
import 'package:goforcate_app/pages/login/register_page.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'login_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List pages = [
    LoginPasswordPage(),
    RegisterPage(),
    LoginQuickPage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: Dimension.screenWidth,
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  LoginPasswordPage(),
                  RegisterPage(),
                  LoginQuickPage(),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: Dimension.screenWidth,
              height: Dimension.screenHeight * 0.05,
              margin: EdgeInsets.only(
                  left: Dimension.gap20,
                  right: Dimension.gap20,
                  top: Dimension.gap20),
              child: TabBar(
                labelStyle: TextStyle(fontWeight: FontWeight.w800),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimension.gap15 * 0.8),
                indicatorColor: AppColors.fontColor6,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "Login",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.fontColor6,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Register",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.fontColor6,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Quick Login",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: AppColors.fontColor6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
