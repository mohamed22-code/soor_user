import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soor_user_app/features/home/tabs/service/services_tab.dart';
import 'booking_tab.dart';
import 'service/add_details/add_details_screen.dart';
import '../../../features/notifications/notification_screen.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/styles/app_style.dart';
import '../../../core/widgets/custom_container_booking.dart';
import '../../../core/widgets/custom_container_opinions.dart';
import '../../../core/widgets/custom_container_services.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../data/models/service_model.dart';
import '../data/models/slider_model.dart';
import '../presentation/cubit/home_cubit.dart';
import '../presentation/cubit/home_state.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      HomeCubit()
        ..fetchHome(perPage: 5),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  int _currentSlider = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(AppAssets.soorLogo),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => NotificationScreen()));
              },
              child: const Icon(Icons.notifications_none, color: Colors.white),
            )
          ],
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryText));
          }
          if (state is HomeError) {
            return RefreshIndicator(
              color: AppColors.primaryText,
              onRefresh: () => context.read<HomeCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: height * 0.8,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message, style: AppStyle.medium16white,
                              textAlign: TextAlign.center),
                          SizedBox(height: height * 0.02),
                          CustomElevatedButton(
                            onPressed: () =>
                                context.read<HomeCubit>().refresh(),
                            text: 'إعادة المحاولة',
                            backgroundColor: AppColors.primary600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          final sliders = state is HomeLoaded ? state.sliders : <SliderModel>[];
          final services = state is HomeLoaded ? state.services : <
              ServiceModel>[];
          if (sliders.isNotEmpty && _currentSlider >= sliders.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _currentSlider = 0);
            });
          } else if (sliders.isEmpty && _currentSlider != 0) {
            _currentSlider = 0;
          }

          return RefreshIndicator(
            color: AppColors.primaryText,
            onRefresh: () => context.read<HomeCubit>().refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    _buildSliderSection(sliders, height, width),
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        const Text('الخدمات', style: AppStyle.bold16white),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ServicesTab(),));
                          },
                          child: const Text('المزيد >',
                              style: AppStyle.medium16secondaryGrey),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    _buildServicesRow(services, width, height),
                    SizedBox(height: height * 0.02),
                    const Text('الحجز الحالي', style: AppStyle.bold24white),
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                const Scaffold(
                                  backgroundColor: Colors.black,
                                  body: SafeArea(
                                      child:
                                      BookingTab()),
                                )));
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: const CustomContainerBooking(
                        bookingNumber: '#12336455',
                        price: '1600 ريال',
                        status: 'منتهي',
                        date: 'اليوم 8:00 م الى 11:00 م',
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    const Text('اراء عملائنا', style: AppStyle.bold24white),
                    SizedBox(height: height * 0.01),
                    const CustomContainerOpinions(name: 'عبدالله القحطاني',
                        comment: 'حارس محترف وملتزم بالوقت، أنصح به بشدة',
                        rating: 5),
                    SizedBox(height: height * 0.02),
                    const CustomContainerOpinions(name: 'سارة العتيبي',
                        comment: 'خدمة راقية وتعامل ممتاز، شكراً سور',
                        rating: 5),
                    SizedBox(height: height * 0.02),
                    const CustomContainerOpinions(name: 'فيصل الحربي',
                        comment: 'الالتزام بالمواعيد ممتاز لكن السعر مرتفع قليلاً',
                        rating: 4),
                    SizedBox(height: height * 0.02),
                    const CustomContainerOpinions(name: 'نورة الدوسري',
                        comment: 'تجربة رائعة، الحارس كان مهذب ومتعاون جداً',
                        rating: 5),
                    SizedBox(height: height * 0.02),
                    const CustomContainerOpinions(name: 'خالد المطيري',
                        comment: 'خدمة جيدة واحترافية عالية',
                        rating: 4),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliderSection(List<SliderModel> sliders, double height,
      double width) {
    if (sliders.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('خصم 50% علي اول حجز', style: AppStyle.bold24white,
              textAlign: TextAlign.right),
          SizedBox(height: height * 0.01),
          CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ServicesTab()));
              },
              text: 'احجز الان',
              backgroundColor: AppColors.primary600),
          const Center(
              child: Icon(Icons.more_horiz, size: 30, color: Colors.white)),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          height: height * 0.15,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentSlider = i),
            itemCount: sliders.length,
            itemBuilder: (context, index) {
              final s = sliders[index];
              final hasImage = s.image != null && s.image!.isNotEmpty;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: EdgeInsets.only(right: index == 0 ? 0 : 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.appBarColor,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (hasImage)
                        Image.network(
                          s.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: AppColors.appBarColor),
                        ),
                      if (hasImage)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7)
                              ],
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: hasImage
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.center,
                          children: [
                            Text(hasImage ? (s.title ?? '') : (s.title ??
                                'خصم 50% علي اول حجز'), style: hasImage
                                ? AppStyle.bold16white
                                : AppStyle.bold24white),
                            if (s.description != null) ...[
                              const SizedBox(height: 8),
                              Text(s.description!,
                                  style: AppStyle.medium14darkGrey,
                                  maxLines: 2),
                            ],
                            if (!hasImage) ...[
                              const SizedBox(height: 12),
                              CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                            const ServicesTab()));
                                  },
                                  text: 'احجز الان',
                                  backgroundColor: AppColors.primary600),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            sliders.length,
                (i) =>
                Container(
                  width: _currentSlider == i ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _currentSlider == i ? AppColors.primaryText : Colors
                        .white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesRow(List<ServiceModel> services, double width,
      double height) {
    if (services.isEmpty) {
      return Row(
        children: [
          CustomContainerServices(
              color: Colors.orange,
              icon: const Icon(Icons.person, size: 35, color: Colors.white),
              text: 'طلب فرد',
              onTap: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                          const AddDetailsScreen(
                            serviceId: '1',
                            serviceName: 'طلب فرد',
                          )))),
          SizedBox(width: width * 0.04),
          CustomContainerServices(
              color: AppColors.primary600,
              icon: const Icon(Icons.person, size: 35, color: Colors.white),
              text: 'مناسبات',
              onTap: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                          const AddDetailsScreen(
                            serviceId: '2',
                            serviceName: 'مناسبات',
                          )))),
        ],
      );
    }

    return SizedBox(
      height: height * 0.14,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (_, __) => SizedBox(width: width * 0.03),
        itemBuilder: (context, index) {
          final s = services[index];
          final colors = [
            Colors.orange,
            AppColors.primary600,
            const Color(0xff007AA2),
            const Color(0xff9E6A00)
          ];
          final color = colors[index % colors.length];
          return CustomContainerServices(
            color: color,
            icon: s.image != null && s.image!.isNotEmpty
                ? Image.network(s.image!, width: 35,
                height: 35,
                errorBuilder: (_, __, ___) =>
                const Icon(
                    Icons.person, size: 35, color: Colors.white))
                : const Icon(Icons.person, size: 35, color: Colors.white),
            text: s.name ?? 'خدمة ${index + 1}',
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AddDetailsScreen(
                          serviceId: s.id?.toString() ?? '${index + 1}',
                          serviceName: s.name,
                          hourPrice: s.hourPrice ?? s.price,
                        ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
