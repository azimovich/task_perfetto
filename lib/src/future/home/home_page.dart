import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_perfetto/src/core/style/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Toshkent sh, Mirabad tumeni, Shaxrisabz birni kocha",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.c151515,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              2.verticalSpace,
              TextField(
                enabled: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.cE7ECF2,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.cF6F6F6,
      body: Center(
        child: Text('Welcome To Home'),
      ),
    );
  }
}
