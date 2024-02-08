import 'package:catering_service_app/src/features/order/data/order_provider.dart';
import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:catering_service_app/src/features/order/screens/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders'),
      ),
      body: orderData.when(
        data: (data) {
          final orderList = data.where((element) {
            return element.orderStatus != OrderStatus.rejected && element.orderStatus != OrderStatus.cancelled;
          }).toList();
          return orderList.isEmpty ? Text(
            'No orders yet',
            style: Theme.of(context).textTheme.bodyMedium
          ) : Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ListView.separated(
              padding: EdgeInsets.only(top: 14.h),
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                return OrderCard(order: orderList[index],);
              },
              separatorBuilder: (context, index) => SizedBox(height: 14.h,),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('$error'),),
        loading: () => const Center(child: CircularProgressIndicator(),),
      )
    );
  }
}
