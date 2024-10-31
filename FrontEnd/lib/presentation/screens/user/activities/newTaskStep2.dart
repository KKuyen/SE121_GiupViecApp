import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';

class Newtaskstep2 extends StatefulWidget {
  final int taskTypeId;

  final int? myvoucherId;
  final int? voucherId;
  final List<Map<String, dynamic>> addPriceDetail;

  const Newtaskstep2(
      {required this.taskTypeId,
      super.key,
      required this.addPriceDetail,
      this.myvoucherId,
      this.voucherId});

  @override
  State<Newtaskstep2> createState() => _Newtaskstep2State();
}

class _Newtaskstep2State extends State<Newtaskstep2> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String note = '';

  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = const TimeOfDay(hour: 8, minute: 0);
  }

  // Hàm định dạng ngày
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }

  // Hàm định dạng giờ
  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    return time.format(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Khởi tạo giá trị mặc định cho TextField trong hàm didChangeDependencies
    _dateController.text = _formatDate(_selectedDate);
    _timeController.text = _formatTime(_selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nen_the,
      appBar: BasicAppbar(
        title: const Text(
          'Điền thông tin chi tiết',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        isHideBackButton: false,
        isHavePadding: true,
        color: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thời gian làm việc', style: AppTextStyle.tieudebox),
              SizedBox(height: 20),

              // TextField chọn ngày
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Chọn ngày',
                  border: OutlineInputBorder(),
                  suffixIcon:
                      const Icon(Icons.calendar_today, color: Colors.black),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.xanh_main),
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      const TextStyle(color: AppColors.xanh_main),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: AppColors.xanh_main,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                      _dateController.text = _formatDate(_selectedDate);
                    });
                  }
                },
              ),
              SizedBox(height: 20),

              // TextField chọn giờ
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Chọn giờ',
                  border: OutlineInputBorder(),
                  suffixIcon:
                      const Icon(Icons.access_time, color: Colors.black),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.xanh_main),
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                  floatingLabelStyle:
                      const TextStyle(color: AppColors.xanh_main),
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime ?? TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: AppColors.xanh_main,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedTime = pickedTime;
                      _timeController.text = _formatTime(_selectedTime);
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              const Text('Địa điểm làm việc', style: AppTextStyle.tieudebox),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.xam72, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.xanh_main),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Địa chỉ mặc định',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.xanh_main),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Trịnh Trần Phương Tuấn',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Số 1, Đại Cồ Việt, Hai Bà Trưng, Hà Nội',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                '(+84) 123 456 789',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                        child: Row(
                          children: [
                            const Text('Chọn địa chỉ khác',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const Spacer(),
                            Sizedbutton(
                                onPressFun: () {},
                                text: 'Thay đổi',
                                width: 120,
                                height: 42),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Ghi chú', style: AppTextStyle.tieudebox),
              const SizedBox(height: 10),
              TextField(
                controller: _noteController,
                maxLength: 200,
                cursorColor: AppColors.xanh_main,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Nhập ghi chú',
                  hintStyle: TextStyle(
                      color: AppColors.xam72, fontWeight: FontWeight.normal),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.xanh_main),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelStyle: TextStyle(color: AppColors.xanh_main),
                ),
                onChanged: (value) {
                  setState(() {
                    note = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Sizedbutton(
                onPressFun: () {
                  int userId = 1;
                  int taskTypeId = widget.taskTypeId;
                  DateTime time = DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  );
                  int locationId = 4;
                  String note = this.note;
                  int myvoucherId = 4;
                  int voucherId = 5;
                  List<Map<String, dynamic>> addPriceDetail =
                      widget.addPriceDetail;
                  context.read<NewTask1Cubit>().createTask(
                        userId,
                        taskTypeId,
                        time,
                        locationId,
                        note,
                        myvoucherId,
                        voucherId,
                        addPriceDetail,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đăng việc thành công!'),
                      backgroundColor: AppColors.xanh_main,
                    ),
                  );

                  Navigator.pop(context, true);
                },
                text: 'Đăng việc',
                width: MediaQuery.of(context).size.width,
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
