import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/section_container.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/section_title.dart';
import 'package:soor_user_app/features/home/tabs/service/check_out_details/checkout_screen.dart';

import 'choice_button.dart';
import 'counter.dart';
import 'date_field.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  int guardsCount = 3;
  int serviceHours = 3;

  String selectedUniform = 'رسمي';
  String selectedLanguage = 'عربي';
  String selectedCoordinated = 'نعم';

  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('التفاصيل', style: AppStyle.medium16white),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionTitle(title: 'تفاصيل الحجز'),
                    SizedBox(height: height * 0.01),
                    Text(
                      'وقت و تاريخ بدء الحجز',
                      style: AppStyle.medium16white,
                    ),
                    SizedBox(height: height * 0.01),
                    DateField(
                      controller: dateController,
                      hintText: 'ادخل تاريخ الحجز',
                    ),
                    SizedBox(height: height * 0.01),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              SectionContainer(
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    const SectionTitle(title: 'العدد و المدة'),
                    SizedBox(height: height * 0.01),
                    const Text(
                      'عدد الحراس المطلوبين',
                      textAlign: TextAlign.right,
                      style: AppStyle.bold12white,
                    ),
                    SizedBox(height: height * 0.01),

                    Counter(
                      value: guardsCount,
                      onMinus: () {
                        if (guardsCount > 1) {
                          setState(() => guardsCount--);
                        }
                      },
                      onPlus: () {
                        setState(() => guardsCount++);
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    const Text(
                      'مدة الخدمة بالساعة (3 ساعات كحد أدنى)',
                      textAlign: TextAlign.right,
                      style: AppStyle.medium16white,
                    ),
                    SizedBox(height: height * 0.01),
                    Counter(
                      value: serviceHours,
                      onMinus: () {
                        if (serviceHours > 3) {
                          setState(() => serviceHours--);
                        }
                      },
                      onPlus: () {
                        setState(() => serviceHours++);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),
              SectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionTitle(title: 'تفاصيل إضافية'),
                    SizedBox(height: height * 0.01),
                    Text(
                      'نوع اللبس',
                      textAlign: TextAlign.right,
                      style: AppStyle.medium16white,
                    ),

                    SizedBox(height: height * 0.01),

                    Row(
                      children: [
                        Expanded(
                          child: ChoiceButton(
                            title: 'كاجوال',
                            selected: selectedUniform == 'كاجوال',
                            onTap: () {
                              setState(() {
                                selectedUniform = 'كاجوال';
                              });
                            },
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: ChoiceButton(
                            title: 'فول سوت',
                            selected: selectedUniform == 'فول سوت',
                            onTap: () {
                              setState(() {
                                selectedUniform = 'فول سوت';
                              });
                            },
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: ChoiceButton(
                            title: 'رسمي',
                            selected: selectedUniform == 'رسمي',
                            onTap: () {
                              setState(() {
                                selectedUniform = 'رسمي';
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.01),

                    const Text(
                      'اللغة المطلوبة',
                      textAlign: TextAlign.right,
                      style: AppStyle.medium16white,
                    ),

                    SizedBox(height: height * 0.01),

                    Row(
                      children: [
                        Expanded(
                          child: ChoiceButton(
                            title: 'english',
                            selected: selectedLanguage == 'english',
                            onTap: () {
                              setState(() {
                                selectedLanguage = 'english';
                              });
                            },
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: ChoiceButton(
                            title: 'عربي',
                            selected: selectedLanguage == 'عربي',
                            onTap: () {
                              setState(() {
                                selectedLanguage = 'عربي';
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.01),

                    const Text(
                      'هل يوجد منسق من طرفك',
                      textAlign: TextAlign.right,
                      style: AppStyle.medium16white,
                    ),

                    SizedBox(width: width * 0.01),

                    Row(
                      children: [
                        Expanded(
                          child: ChoiceButton(
                            title: 'لا',
                            selected: selectedCoordinated == 'لا',
                            onTap: () {
                              setState(() {
                                selectedCoordinated = 'لا';
                              });
                            },
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Expanded(
                          child: ChoiceButton(
                            title: 'نعم',
                            selected: selectedCoordinated == 'نعم',
                            onTap: () {
                              setState(() {
                                selectedCoordinated = 'نعم';
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.01),

                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                      decoration: InputDecoration(
                        hintText: 'ملاحظات إضافية هنا...',
                        hintStyle: const TextStyle(
                          color: Color(0xff666666),
                          fontSize: 11,
                        ),
                        filled: true,
                        fillColor: const Color(0xff222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC58A00),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text('طلب (1500 ريال)', style: AppStyle.medium16white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
