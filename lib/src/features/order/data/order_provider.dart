



import 'package:catering_service_app/src/features/order/data/order_datasource.dart';
import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = StreamProvider<List<OrderModel>>((ref) => OrderDataSource().getOrdersStream());

final orderDetailProvider = StreamProvider.family<OrderModel, String>((ref, String id) => OrderDataSource().getOrderDetail(id));

final acceptOrderProvider = FutureProvider.family<String, String>(
        (ref, String orderId) => OrderDataSource().acceptOrder(orderId: orderId)
);


final completeOrderProvider = FutureProvider.family<String, String>(
        (ref, String orderId) => OrderDataSource().completeOrder(orderId: orderId)
);

final rejectOrderProvider = FutureProvider.family<String, String>(
        (ref, String orderId) => OrderDataSource().rejectOrder(orderId: orderId)
);












