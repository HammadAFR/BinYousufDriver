class DeliverOrderModel {
  String? id;
  String? placedBy;
  int? status;
  String? description;
  String? deliveryTime;
  int? deliveryDate;
  double? latitude;
  double? longitude;
  String? address;
  String? shopName;
  int? paidStatus;
  List<Items>? items;
  String? amount;
  int? createdAt;
  int? orderNumber;
  String? receiptNumber;
  int? iV;
  String? driverId;

  DeliverOrderModel(
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
      this.iV,
      this.driverId});

  DeliverOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    placedBy = json['placed_by'];
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
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    amount = json['amount'];
    createdAt = json['createdAt'];
    orderNumber = json['orderNumber'];
    receiptNumber = json['receipt_number'];
    iV = json['__v'];
    driverId = json['driverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['placed_by'] = placedBy;
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
    data['driverId'] = driverId;
    return data;
  }
}

class Items {
  String? itemId;
  String? id;

  Items({this.itemId, this.id});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['_id'] = id;
    return data;
  }
}
