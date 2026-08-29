import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';
import '../../../more/presentation/cubit/more_cubit.dart';
import '../../../more/presentation/cubit/more_state.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  static const String _fallbackTerms = '''مرحبًا بك في تطبيق "سور Soor". باستخدامك للتطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام. يُرجى قراءة هذه الشروط بعناية قبل استخدام خدماتنا.  يُعتبر استخدامك للتطبيق أو تسجيلك فيه قبولًا تامًا لجميع بنود هذه الشروط.
2. تعريفات
التطبيق: تطبيق "سور Soor" المخصص لتقديم خدمات حجز البودي جارد والحراسة الشخصية.
المستخدم: أي شخص يقوم بتحميل التطبيق أو التسجيل فيه أو استخدام خدماته.
مقدم الخدمة: أي فرد أو شركة مسجلة داخل التطبيق لتقديم خدمات الحراسة الشخصية.
الإدارة: فريق تطبيق "سور Soor" المسؤول عن تشغيل التطبيق وإدارته.
3. استخدام التطبيق
يجب أن يكون عمر المستخدم 18 سنة على الأقل لاستخدام خدمات "سور Soor".
يلتزم المستخدم بتقديم بيانات صحيحة ودقيقة عند التسجيل.
يُمنع استخدام التطبيق لأي غرض غير قانوني أو مخالف للآداب العامة.
يحتفظ التطبيق بالحق في إيقاف أو حذف الحساب في حال مخالفة أي من هذه الشروط.
4. الخدمات
يقوم التطبيق بربط العملاء بمقدمي خدمة البودي جارد حسب التوفر والموقع.
التطبيق وسيط فقط ولا يتحمل مسؤولية مباشرة عن تصرفات مقدمي الخدمة أثناء العمل.
يتحمل مقدم الخدمة المسؤولية الكاملة عن أدائه، مظهره، وسلامة السلوك المهني أثناء فترة التعاقد.
5. الدفع والاسترجاع
يتم الدفع مقابل الخدمات من خلال الوسائل المعتمدة داخل التطبيق.
قد يتم خصم رسوم الخدمة أو رسوم الإلغاء وفقًا لسياسة التطبيق.
لا يتم استرجاع المبالغ إلا في الحالات التي تقررها الإدارة بعد مراجعة الطلب.
6. المسؤولية القانونية
تطبيق "سور Soor" غير مسؤول عن أي أضرار أو خسائر تنتج عن سوء استخدام الخدمة من قبل المستخدم أو مقدم الخدمة.
المستخدم مسؤول مسؤولية كاملة عن أي تعامل أو اتفاق يتم خارج إطار التطبيق.
7. الخصوصية
يحترم تطبيق "سور Soor" خصوصية المستخدمين ويحافظ على سرية البيانات.
8. التعديلات على الشروط
يحتفظ تطبيق "سور Soor" بالحق في تعديل هذه الشروط في أي وقت.''';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      MoreCubit()
        ..fetchTerms(),
      child: Scaffold(
        appBar: AppBar(
            title: const Text('الشروط والاحكام', style: AppStyle.medium16white),
            centerTitle: true),
        body: BlocBuilder<MoreCubit, MoreState>(
          builder: (context, state) {
            if (state is MoreLoading) {
              return const Center(child: CircularProgressIndicator(
                  color: AppColors.primaryText));
            }
            if (state is MoreError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message, style: AppStyle.medium16white,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.read<MoreCubit>().fetchTerms(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryText),
                        child: const Text('إعادة المحاولة'),
                      ),
                      const SizedBox(height: 24),
                      const Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                              _fallbackTerms, style: AppStyle.medium16white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is TermsLoaded) {
              final text = state.terms.displayText.isNotEmpty ? state.terms
                  .displayText : _fallbackTerms;
              final display = _stripHtml(text);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(display, style: AppStyle.medium16white),
                ),
              );
            }
            return const SingleChildScrollView(
              child: Padding(padding: EdgeInsets.all(16),
                  child: Text(_fallbackTerms, style: AppStyle.medium16white)),
            );
          },
        ),
      ),
    );
  }

  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }
}
