import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class WeeklyRecapPage extends StatelessWidget {
  WeeklyRecapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildWeeklyRecapContent(context),
            Expanded(child: _buildScrollableTaskList(context)),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildWeeklyRecapContent(BuildContext context) {
    final profileImagePath =
        Provider.of<ProfileProvider>(context).profileImagePath;

    return Column(
      children: [
        AppBar(
          toolbarHeight: 62,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Weekly Recap",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.h),
              child: CustomIconButton(
                height: 45.h,
                width: 45.h,
                padding: EdgeInsets.all(5.h),
                decoration: IconButtonStyleHelper.none,
                child: CircleAvatar(
                  radius: 20.h,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileImagePath != null
                      ? FileImage(File(profileImagePath))
                      : null,
                  child: profileImagePath == null
                      ? Icon(Icons.person, size: 20.h, color: Colors.black)
                      : null,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profile);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 50.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.h),
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.h),
          ),
          height: 300.h,
          child: Center(
            child: Text(
              "No data available",
              style: TextStyle(color: Colors.white, fontSize: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableTaskList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.h),
      itemCount: 7, // Replace with the actual number of tasks
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "Task Title (${index + 1})",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.NavBar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.h),
          topRight: Radius.circular(25.h),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: appTheme.black900.withOpacity(0.2),
            blurRadius: 2.h,
            spreadRadius: 2.h,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgHome,
              height: 24.h,
              width: 24.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgSearch,
              height: 37.h,
              width: 37.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          AddTaskButton.showAddTaskModal(context, userId: currentUser?.id),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgRecapPressed,
              height: 35.h,
              width: 35.h,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgCalendar,
              height: 35.h,
              width: 35.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ],
      ),
      height: 70.h,
    );
  }
}
