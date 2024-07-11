class OrderModel {
  String? id;
  PlacedBy? placedBy;
  int? status;
  String? description;
  int? deliveryDate;
  String? deliveryTime;
  double? latitude;
  double? longitude;
  String? address;
  String? shopName;
  int? paidStatus;
  List<OrderItems>? items;
  String? amount;
  int? createdAt;
  int? orderNumber;
  String? receiptNumber;
  int? iV;

  OrderModel(
      {this.id,
      this.placedBy,
      this.status,
      this.description,
      this.deliveryDate,
      this.deliveryTime,
      this.latitude,
      this.longitude,
      this.address,
      this.shopName,
      this.paidStatus,
      this.items,
      this.amount,
      this.createdAt,
      this.orderNumber,
      this.receiptNumber,
      this.iV});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    placedBy =
        json['placed_by'] != null ? PlacedBy.fromJson(json['placed_by']) : null;
    status = json['status'];
    description = json['description'];
    deliveryDate = json['deliveryDate'];
    deliveryTime = json['deliveryTime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    shopName = json['shop_name'];
    paidStatus = json['paid_status'];
    if (json['items'] != null) {
      items = <OrderItems>[];
      json['items'].forEach((v) {
        items!.add(OrderItems.fromJson(v));
      });
    }
    amount = json['amount'];
    createdAt = json['createdAt'];
    orderNumber = json['orderNumber'];
    receiptNumber = json['receipt_number'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (placedBy != null) {
      data['placed_by'] = placedBy!.toJson();
    }
    data['status'] = status;
    data['description'] = description;
    data['deliveryDate'] = deliveryDate;
    data['deliveryTime'] = deliveryTime;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['shop_name'] = shopName;
    data['paid_status'] = paidStatus;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['amount'] = amount;
    data['createdAt'] = createdAt;
    data['orderNumber'] = orderNumber;
    data['receipt_number'] = receiptNumber;
    data['__v'] = iV;
    return data;
  }
}

class PlacedBy {
  String? id;
  String? name;
  String? mobileNumber;

  PlacedBy({this.id, this.name, this.mobileNumber});

  PlacedBy.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    return data;
  }
}

class OrderItems {
  String? itemId;
  String? id;
  String? name;
  String? attachment;
  int? quantity;
  String? weight;
  int? price;
  String? subcategoryId;
  int? iV;
  int? originalPrice;

  OrderItems({
    this.itemId,
    this.id,
    this.name,
    this.attachment,
    this.quantity,
    this.weight,
    this.price,
    this.subcategoryId,
    this.iV,
    this.originalPrice,
  });

  OrderItems.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    id = json['_id'];
    name = json['name'];
    attachment = json['attachment'];
    quantity = json['quantity'];
    weight = json['weight'];
    price = json['price'];
    subcategoryId = json['subcategoryId'];
    iV = json['__v'];
    originalPrice = json['original_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['_id'] = id;
    data['name'] = name;
    data['attachment'] = attachment;
    data['quantity'] = quantity;
    data['weight'] = weight;
    data['price'] = price;
    data['subcategoryId'] = subcategoryId;
    data['__v'] = iV;
    data['original_price'] = originalPrice;
    return data;
  }
}
