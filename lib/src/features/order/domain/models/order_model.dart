

class OrderModel {
  final OrderDetail orderDetail;
  final String advancePayment;
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final String catererId;
  final String menuId;
  final String menuName;
  final List<String>? starterMenu;
  final List<String>? mainCourseMenu;
  final List<String>? dessertMenu;

  OrderModel({
    required this.orderDetail,
    required this.advancePayment,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.catererId,
    required this.menuId,
    required this.menuName,
    this.starterMenu,
    this.mainCourseMenu,
    this.dessertMenu,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderDetail: OrderDetail.fromJson(json['orderInfo']),
      advancePayment: json['advancePayment'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryImage: json['categoryImage'],
      catererId: json['catererId'] as String,
      menuId: json['menuId'] as String,
      menuName: json['menuName'] as String,
      starterMenu: List<String>.from(json['starterMenu'] as List<dynamic>),
      mainCourseMenu: List<String>.from(json['mainCourseMenu'] as List<dynamic>),
      dessertMenu: List<String>.from(json['dessertMenu'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderDetail': orderDetail.toJson(),
      'advancePayment': advancePayment,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'catererId': catererId,
      'menuId': menuId,
      'menuName': menuName,
      'starterMenu': starterMenu,
      'mainCourseMenu': mainCourseMenu,
      'dessertMenu': dessertMenu,
    };
  }
}



class OrderDetail {
  final String customerId;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final String dietaryPref;
  final String helpers;
  final String orderDate;
  final String totalGuests;

  OrderDetail({
    required this.customerId,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.dietaryPref,
    required this.helpers,
    required this.orderDate,
    required this.totalGuests,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerAddress: json['customerAddress'] as String,
      customerPhone: json['contact'] as String,
      dietaryPref: json['dietryPreference'] as String,
      helpers: json['helpers'] as String,
      orderDate: json['orderDate'] as String,
      totalGuests: json['totalGuests'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'dietaryPref': dietaryPref,
      'helpers': helpers,
      'orderDate': orderDate,
      'totalGuests': totalGuests,
    };
  }
}
