



import 'package:catering_service_app/src/features/order/data/order_datasource.dart';
import 'package:catering_service_app/src/features/order/domain/models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = FutureProvider<List<OrderModel>>((ref) => OrderDataSource().getOrders());