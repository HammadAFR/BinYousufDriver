class UserModel {
  String? userId;
  String? name;
  String? mobileNumber;
  String? fcmToken;
  String? otp;
  String? location;
  String? businessName;
  double? latitude;
  double? longitude;
  int? role;
  int? readonlyPrivilage;
  int? status;
  int? isBlocked;
  int? createdAt;
  int? iV;
  String? businessAttachment;
  String? nicBackAttachment;
  String? nicFrontAttachment;
  String? email;
  String? cnic;
  String? vehicleNumber;
  String? profileImage;

  UserModel({
    this.userId,
    this.name,
    this.mobileNumber,
    this.fcmToken,
    this.otp,
    this.location,
    this.businessName,
    this.latitude,
    this.longitude,
    this.role,
    this.readonlyPrivilage,
    this.status,
    this.isBlocked,
    this.createdAt,
    this.iV,
    this.businessAttachment,
    this.nicBackAttachment,
    this.nicFrontAttachment,
    this.email,
    this.cnic,
    this.vehicleNumber,
    this.profileImage,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    fcmToken = json['fcmToken'];
    otp = json['otp'];
    location = json['location'];
    businessName = json['business_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    role = json['role'];
    readonlyPrivilage = json['readonly_privilage'];
    status = json['status'];
    isBlocked = json['is_blocked'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    businessAttachment = json['business_attachment'];
    nicBackAttachment = json['nic_back_attachment'];
    nicFrontAttachment = json['nic_front_attachment'];
    vehicleNumber = json['vehicle_number'];
    email = json['email'];
    cnic = json['cnic'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = userId;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['fcmToken'] = fcmToken;
    data['otp'] = otp;
    data['location'] = location;
    data['business_name'] = businessName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['role'] = role;
    data['readonly_privilage'] = readonlyPrivilage;
    data['status'] = status;
    data['is_blocked'] = isBlocked;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['business_attachment'] = businessAttachment;
    data['nic_back_attachment'] = nicBackAttachment;
    data['nic_front_attachment'] = nicFrontAttachment;
    data['email'] = email;
    data['cnic'] = cnic;
    data['vehicle_number'] = vehicleNumber;
    data['profile_image'] = profileImage;
    return data;
  }
}
