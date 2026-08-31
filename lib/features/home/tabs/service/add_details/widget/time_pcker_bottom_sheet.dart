import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/widget/day_name.dart';

class DateTimePickerBottomSheet extends StatefulWidget {
  const DateTimePickerBottomSheet({super.key});

  @override
  State<DateTimePickerBottomSheet> createState() =>
      _DateTimePickerBottomSheetState();
}

class _DateTimePickerBottomSheetState extends State<DateTimePickerBottomSheet> {
  DateTime selectedDate = DateTime.now();

  String selectedTime = '11:00م';

  bool isSelectingTime = false;

  final List<String> times = [
    '9:100ص',
    '10:00ص',
    '11:00ص',
    '12:00م',
    '1:00م',
    '2:00م',
    '3:00م',
    '4:00م',
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: isSelectingTime ? height * 0.25 : height * 0.65,
      decoration: const BoxDecoration(
        color: Color(0xff090909),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: isSelectingTime ? _buildTimePicker() : _buildDatePicker(),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      children: [
        _buildHandle(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Text('اختر التاريخ', style: AppStyle.medium20white),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),

        const Divider(color: Color(0xff222222), height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _monthButton(
                icon: Icons.chevron_left,
                onTap: () => _changeMonth(-1),
              ),
              const Spacer(),
              Text(
                '${_monthName(selectedDate.month)} ${selectedDate.year}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _monthButton(
                icon: Icons.chevron_right,
                onTap: () => _changeMonth(1),
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DayName('السبت'),
              DayName('الأحد'),
              DayName('الاثنين'),
              DayName('الثلاثاء'),
              DayName('الأربعاء'),
              DayName('الخميس'),
              DayName('الجمعة'),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Expanded(child: _buildCalendar()),
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isSelectingTime = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffC58A00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'التالي',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Column(
      children: [
        _buildHandle(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectingTime = false;
                  });
                },
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),

              const Spacer(),

              const Text(
                'اختر الوقت',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),

        const SizedBox(height: 5),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 5,
              runSpacing: 8,
              children: times.map((time) {
                final selected = selectedTime == time;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? const Color(0xffC58A00)
                            : const Color(0xff444444),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected)
                          const Icon(
                            Icons.check,
                            color: Color(0xffC58A00),
                            size: 13,
                          ),

                        const SizedBox(width: 3),

                        Text(
                          time,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isSelectingTime = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xffC58A00)),
                  ),
                  child: const Text(
                    'السابق',
                    style: TextStyle(color: Color(0xffC58A00), fontSize: 11),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final date =
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';

                    final result = '$date - $selectedTime';

                    Navigator.pop(context, result);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC58A00),
                  ),
                  child: const Text(
                    'حفظ',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);

    final daysInMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    ).day;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final firstWeekDay = firstDay.weekday % 7;

        final day = index - firstWeekDay + 1;

        if (day < 1 || day > daysInMonth) {
          return const SizedBox();
        }

        final isSelected = day == selectedDate.day;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                day,
              );
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xffC58A00) : Colors.transparent,
            ),
            child: Text(
              '$day',
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xffDDDDDD),
                fontSize: 10,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      width: 28,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _monthButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Color(0xffC58A00),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  void _changeMonth(int delta) {
    final newDate = DateTime(selectedDate.year, selectedDate.month + delta, 1);
    final now = DateTime.now();
    final firstAllowed = DateTime(now.year, now.month, 1);
    if (newDate.isBefore(firstAllowed)) return;
    setState(() {
      selectedDate = newDate;
    });
  }

  String _monthName(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return months[month - 1];
  }
}
