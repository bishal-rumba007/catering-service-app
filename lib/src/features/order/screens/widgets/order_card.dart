import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:catering_service_app/src/features/order/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({
    super.key, required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailScreen(order: order),
            ),
        );
      },
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(10.h),
          height: 150.h,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 114.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(order.categoryImage)
                  )
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.menuName} Party',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      height: 26.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Rs. 1100/person',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.people),
                          SizedBox(width: 6.w,),
                          Text(
                            order.orderDetail.totalGuests,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Lorem Ipsum dolor sit amet. asd as ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      height: 30.h,
                      width: 132.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'Total 44k Rs.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}