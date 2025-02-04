// box_styles.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';
import 'package:flutter_application_1/shared/widgets/list_item.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/quote_provider.dart';

// Task or Challenge Block
Widget Task_or_Challenge_Block(
  BuildContext context, {
  required GlobalKey<ListItemStateNew> listkey,
  required String title,
  required List<List<dynamic>> listname,
  required bool circle,
  required bool border,
  required Function onCheckboxChanged,
}) {
  final dbHelper = DatabaseHelper();
  void updateTaskInDatabase(int index, bool isCompleted) {
    final taskId = listname[index][3];
    dbHelper.updateTaskCompletion(taskId, isCompleted ? 1 : 0);
    onCheckboxChanged(); // Trigger the callback to update dataMap
  }

  return Container(
    height: 179.h,
    width: 320.h,
    decoration: BoxDecoration(
      border: border
          ? Border.all(
              width: 2.h,
              color: Colors.transparent,
            ) //white border
          : Border.all(
              width: 2.h,
              color: Color.fromARGB(0, 0, 0, 0),
            ), //translucent border
      color: appTheme.dailyBlocks,
      borderRadius: BorderRadius.circular(25.h),
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
    padding: EdgeInsets.all(16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 18.h,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 28, 62, 80),
          ),
        ),
        SizedBox(height: 5.h),
        // Scrollable List
        Expanded(
            child: ListItemNew(
          key: listkey,
          listname: listname,
          circle: circle,
          onCheckboxChanged: updateTaskInDatabase, // Pass the callback
        ) //Give list name and checkbox shape
            ),
      ],
    ),
  );
}

//Activity Block
Widget Activity_Block(BuildContext context,
    {double? height,
    double? width,
    required List<List<dynamic>> listname,
    required bool circle,
    required bool border,
    required VoidCallback onTaskUpdate}) {
  //print("Activity_Block listname: $listname");
  final dbHelper = DatabaseHelper();
  void updateTaskInDatabase(int index, bool isCompleted) {
    final taskId = listname[index][3];
    dbHelper.updateTaskCompletion(taskId, isCompleted ? 1 : 0);
    onTaskUpdate(); // Notify parent to refresh tasks
  }

  return Container(
    height: height ?? 175.h,
    width: width ?? 260.h,
    decoration: BoxDecoration(
      border: border
          ? Border.all(
              width: 2.h,
              color: Color.fromARGB(255, 255, 255, 255),
            ) //white border
          : Border.all(
              width: 2.h,
              color: Color.fromARGB(0, 0, 0, 0),
            ), //translucent border
      color: appTheme.dailyBlocks,
      borderRadius: BorderRadius.circular(25.h),
    ),
    padding: EdgeInsets.all(16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        // Scrollable List
        Expanded(
            child: ListItemNew(
          listname: listname,
          circle: circle,
          onCheckboxChanged: updateTaskInDatabase,
        ) //Give list name and checkbox shape
            ),
      ],
    ),
  );
}

//Quote Block
Widget Quote_Block(BuildContext context, Map<String, double> dataMap) {
  return FutureBuilder<String>(
    future: QuoteProvider.fetchDailyQuote(),
    builder: (context, snapshot) {
      String quoteText;

      if (snapshot.connectionState == ConnectionState.waiting) {
        quoteText = "Fetching quote...";
      } else if (snapshot.hasError) {
        quoteText = "Failed to load quote.";
      } else {
        quoteText = snapshot.data ?? "No quote available.";
      }

      return Center(
        child: Container(
          width: 300.h,
          decoration: BoxDecoration(
            color: appTheme.profileAvatar,
            borderRadius: BorderRadius.circular(60.h),
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
          padding: EdgeInsets.all(16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pie Chart with explicit constraints
              Container(
                height: 70.h,
                width: 100.h,
                child: PieChart(
                  dataMap:
                      dataMap, // Ensure dataMap contains 'Completed' and 'Incomplete' keys
                  colorList: [
                    appTheme.homeBGcolor2, // Color for completed tasks
                    const Color.fromARGB(
                        255, 241, 238, 248), // Color for incomplete tasks
                  ],
                  legendOptions: LegendOptions(
                    showLegends: false, // Didn't like how it looked
                    legendTextStyle: TextStyle(
                      fontSize: 4.h, // Match app scaling
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    legendPosition: LegendPosition.left,
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    chartValueBackgroundColor: Colors.transparent,
                    showChartValuesInPercentage: true, // Show percentage values
                    chartValueStyle: TextStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.w600,
                      color: appTheme.black900,
                    ),
                    decimalPlaces: 1,
                  ),
                  chartRadius:
                      120.h, // Adjust radius based on your app's scaling
                  ringStrokeWidth:
                      30, // Customize ring width for a sleek appearance
                  animationDuration:
                      const Duration(milliseconds: 800), // Smooth animation
                ),
              ),
              SizedBox(width: 6.h),
              // Daily Quote
              Expanded(
                child: Text(
                  quoteText,
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Section Widget
Widget SearchInput(BuildContext context, {required Function(String) onSearch}) {
  return Center(
    child: CustomTextFormField(
      width: 250.h,
      fillColor: appTheme.profileAvatar,
      borderDecoration: OutlineInputBorder(
        borderSide: BorderSide(width: 2.h, color: Colors.lightBlue.shade50),
        borderRadius: BorderRadius.circular(30.h),
      ),
      hintText: "Search",
      textInputAction: TextInputAction.done,
      onChanged: onSearch, // trigger onSearch callback
      prefix: Container(
        margin: EdgeInsets.fromLTRB(10.h, 6.h, 26.h, 6.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSearch,
          height: 26.h,
          width: 26.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 48.h,
      ),
      obscureText: false,
      contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
    ),
  );
}

//Recap Block
Widget Recap_Block(BuildContext context) {
  return Container(
    //ENTER RECAP WIDGET AS CHILD
    height: 175.h,
    width: 140.h,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1.0,
        color: Color.fromARGB(255, 255, 255, 255),
      ), //white border
      color: appTheme.dailyBlocks,
      borderRadius: BorderRadius.circular(25.h),
    ),
    padding: EdgeInsets.all(16.h),
  );
}

Widget Task_Block(BuildContext context) {
  return Container(
    //ENTER RECAP WIDGET AS CHILD
    height: 450.h,
    width: 300.h,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1.0,
        color: Color.fromARGB(255, 255, 255, 255),
      ), //white border
      color: appTheme.dailyBlocks,
      borderRadius: BorderRadius.circular(25.h),
    ),
    padding: EdgeInsets.all(16.h),
  );
}
