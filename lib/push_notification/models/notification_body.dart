class NotificationBody {
  int? orderId;
  String? type;
  String? farmId;
  String? farmName;
  String? productId;
  String? productSlug;

  NotificationBody({this.orderId, this.type, this.farmId, this.farmName, this.productId, this.productSlug});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    type = json['type'];
    farmId = json['farm_id'];
    farmName = json['farm_name'];
    productId = json['product_id'];
    productSlug = json['product_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['type'] = type;
    data['farm_id'] = farmId;
    data['farm_name'] = farmName;
    data['product_id'] = productId;
    data['product_slug'] = productSlug;
    return data;
  }
}
