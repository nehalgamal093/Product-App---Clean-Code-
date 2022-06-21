import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CustomerResponse(this.id, this.name, this.numOfNotifications);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);
  //from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ServicesResponse{
  @JsonKey(name:'id')
  int? id;

  @JsonKey(name:'title')
  String? title;

  @JsonKey(name:'image')
  String? image;

  ServicesResponse(this.id,this.title,this.image);

  //toJson
Map<String,dynamic> toJson()=> _$ServicesResponseToJson(this);

//fromJson
factory ServicesResponse.fromJson(Map<String,dynamic>json) => _$ServicesResponseFromJson(json);
}


@JsonSerializable()
class BannersResponse{
  @JsonKey(name:'id')
  int? id;

  @JsonKey(name:'title')
  String? title;

  @JsonKey(name:'image')
  String? image;

  @JsonKey(name:'link')
  String? link;

  BannersResponse(this.id,this.title,this.image,this.link);

  //toJson
  Map<String,dynamic> toJson()=> _$BannersResponseToJson(this);

//fromJson
  factory BannersResponse.fromJson(Map<String,dynamic>json) => _$BannersResponseFromJson(json);
}

@JsonSerializable()
class StoreResponse{
  @JsonKey(name:'id')
  int? id;

  @JsonKey(name:'title')
  String? title;

  @JsonKey(name:'image')
  String? image;

  StoreResponse(this.id,this.title,this.image);

  //toJson
  Map<String,dynamic> toJson()=> _$StoreResponseToJson(this);

//fromJson
  factory StoreResponse.fromJson(Map<String,dynamic>json) => _$StoreResponseFromJson(json);
}


@JsonSerializable()
class HomeDataResponse{
  @JsonKey(name:'services')
  List<ServicesResponse>? services;

  @JsonKey(name:'banners')
  List<BannersResponse>? banners;

  @JsonKey(name:'stores')
  List<StoreResponse>? stores;

  HomeDataResponse(this.services,this.banners,this.stores);

  //toJson
  Map<String,dynamic> toJson()=> _$HomeDataResponseToJson(this);

//fromJson
  factory HomeDataResponse.fromJson(Map<String,dynamic>json) => _$HomeDataResponseFromJson(json);
}
@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name:'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

  Map<String,dynamic> toJson()=> _$HomeResponseToJson(this);

//fromJson
  factory HomeResponse.fromJson(Map<String,dynamic>json) => _$HomeResponseFromJson(json);


}