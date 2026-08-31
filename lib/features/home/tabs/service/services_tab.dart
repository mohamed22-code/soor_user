import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';
import '../../../../features/services/presentation/cubit/services_cubit.dart';
import '../../../../features/services/presentation/cubit/services_state.dart';
import 'add_details/add_details_screen.dart';
import 'custom_contianer_service.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServicesCubit()..fetchAll(perPage: 1000),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('الخدمات', style: AppStyle.bold24white),
        ),
        body: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is ServicesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryText),
              );
            }
            if (state is ServicesError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: AppStyle.medium16white,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ServicesCubit>().fetchAll(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryText,
                        ),
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is ServicesLoaded) {
              final services = state.services;
              if (services.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'لا توجد خدمات حالياً',
                        style: AppStyle.medium16white,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ServicesCubit>().fetchAll(),
                        child: const Text('تحديث'),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                color: AppColors.primaryText,
                onRefresh: () => context.read<ServicesCubit>().fetchAll(),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  itemCount: services.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final s = services[index];
                    final colors = [
                      Colors.orange,
                      const Color(0xff007AA2),
                      AppColors.primaryText,
                      const Color(0xff00394C),
                    ];
                    final color = colors[index % colors.length];
                    return CustomContianerService(
                      text: s.name ?? 'خدمة ${index + 1}',
                      color: color,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddDetailsScreen(
                            serviceId: s.id?.toString(),
                            serviceName: s.name,
                            hourPrice:
                                s.hourPrice ?? state.hourPrice?.hourPrice,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            // fallback static
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                children: [
                  CustomContianerService(
                    text: 'طلب فرد',
                    color: Colors.orange,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddDetailsScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomContianerService(
                    text: 'مناسبات',
                    color: const Color(0xff007AA2),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddDetailsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
