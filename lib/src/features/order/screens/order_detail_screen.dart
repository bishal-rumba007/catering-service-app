import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/order/data/order_provider.dart';
import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:catering_service_app/src/features/order/screens/widgets/common_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class OrderDetailScreen extends ConsumerStatefulWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  final _textController = TextEditingController();
  late String formattedDate;
  @override
  void initState() {
    super.initState();
    _textController.text = widget.order.orderDetail.dietaryPref;
    DateTime dateTime = DateTime.parse(widget.order.orderDetail.orderDate);
    formattedDate = DateFormat('MMMM d').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    final totalPrice = double.parse(widget.order.price) * double.parse(widget.order.orderDetail.totalGuests);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 170.h,
              width: 290.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.order.categoryImage)
                  )
              ),
            ),
          ),
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.94,
              minChildSize: 0.94,
              maxChildSize: 1.0,
              shouldCloseOnMinExtent: false,
              builder: (context, scrollController) {
                return Card(
                  elevation: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                      )
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Text(
                          '${widget.order.menuName} Party',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs. ${widget.order.price}',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              height: 34.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.grey.shade600,
                                )
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.people),
                                  SizedBox(width: 8.w,),
                                  Text(
                                    widget.order.orderDetail.totalGuests,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Date',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey.shade600
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Helpers',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                                Text(
                                  widget.order.orderDetail.helpers,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Total',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                                Text(
                                  'Rs. ${formatTotalPrice(totalPrice)}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            )

                          ],
                        ),
                        SizedBox(height: 25.h,),
                        BuildTextField(
                          controller: _textController,
                          maxLine: 2,
                          labelText: 'Dietary Preferences',
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          'Customer Details',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Name     :  ',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: widget.order.orderDetail.customerName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp
                                ),
                              ),
                            ]
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Address :  ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: widget.order.orderDetail.customerAddress,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp
                                  ),
                                ),
                              ]
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phone    :  ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: widget.order.orderDetail.customerPhone,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp
                                  ),
                                ),
                              ]
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        widget.order.orderStatus.index == 1 ? const SizedBox() : Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: (){},
                                  child: const Text('Decline'),
                              ),
                            ),
                            SizedBox(width: 16.w,),
                            Expanded(
                              child: BuildButton(
                                onPressed: (){
                                  setState(() {});
                                  ref.read(acceptOrderProvider(widget.order.orderId));
                                },
                                buttonWidget: const Text('Accept'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
