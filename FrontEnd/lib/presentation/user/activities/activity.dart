// ignore_for_file: prefer_const_constructors
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/task_card/waiting_activity_widget.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Card Demo',
      theme: ThemeData(
        primaryColor: AppColors.xanh_main, // Màu chính
        tabBarTheme: TabBarTheme(
          splashFactory: NoSplash.splashFactory,
          // Màu nền của tab
          labelColor: AppColors.xanh_main, // Màu chữ của tab được chọn
          unselectedLabelColor:
              const Color.fromARGB(179, 0, 0, 0), // Màu chữ tab không được chọn
          indicator: BoxDecoration(
            // Tạo hình chữ nhật xanh bên dưới tab được chọn
            border: Border(
              bottom: BorderSide(
                color:
                    AppColors.xanh_main, // Màu xanh cho dấu hiệu tab khi click
                width: 3.0, // Độ dày của đường gạch dưới tab
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:
              Color.fromARGB(255, 255, 255, 255), // Màu FloatingActionButton
        ),
      ),
      home: DefaultTabController(
        length: 4, // Number of tabs
        child: JobCardScreen(),
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class JobCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Hoạt động',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Đang tìm'),
            Tab(text: 'Đã nhận'),
            Tab(text: 'Đã hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          JobCardList1(), // Content for 'Đang tìm'
          JobCardList2(), // Content for 'Lặp lại'
          JobCardList3(), // Content for 'Lịch sử'
          JobCardList4(), // Content for 'Đã hủy'
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.xanh_main, // Màu nền xanh
        foregroundColor: Colors.white, // Màu icon trắng
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
    );
  }
}

class JobCardList1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return WatingActivityWidget();
      },
    );
  }
}

class JobCardList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return WatingActivityWidget();
      },
    );
  }
}

class JobCardList3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return WatingActivityWidget();
      },
    );
  }
}

class JobCardList4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return WatingActivityWidget();
      },
    );
  }
}
