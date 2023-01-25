// To parse this JSON data, do
//
//     final dealearWiseBenListModel = dealearWiseBenListModelFromJson(jsonString);

import 'dart:convert';

List<DealearWiseBenListModel> dealearWiseBenListModelFromJson(dynamic str) =>
    List<DealearWiseBenListModel>.from(
        (str as List<dynamic>).map((x) => DealearWiseBenListModel.fromJson(x)));

String dealearWiseBenListModelToJson(List<DealearWiseBenListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealearWiseBenListModel {
  DealearWiseBenListModel({
    this.id,
    this.ecBeneficiaryName,
    this.ecBeneficiaryNameEn,
    this.nationalId,
    this.secondNationalId,
    this.givenMobileNo,
    this.dateOfBirth,
    this.status,
    this.finalStatus,
    this.image,
    this.dealerId,
    this.dealerName,
    this.unionId,
    this.unionName,
    this.cardNo,
  });

  final int? id;
  final String? ecBeneficiaryName;
  final String? ecBeneficiaryNameEn;
  final String? nationalId;
  final String? secondNationalId;
  final String? givenMobileNo;
  final DateTime? dateOfBirth;
  final int? status;
  final int? finalStatus;
  final String? image;
  final int? dealerId;
  final String? dealerName;
  final int? unionId;
  final String? unionName;
  final String? cardNo;

  factory DealearWiseBenListModel.fromJson(Map<String, dynamic> json) =>
      DealearWiseBenListModel(
        id: json["id"],
        ecBeneficiaryName: json["ecBeneficiaryName"],
        ecBeneficiaryNameEn: json["ecBeneficiaryNameEn"],
        nationalId: json["nationalID"],
        secondNationalId: json["secondNationalID"],
        givenMobileNo: json["givenMobileNo"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        status: json["status"],
        finalStatus: json["finalStatus"],
        image: json["image"],
        dealerId: json["dealerId"],
        dealerName: json["dealerName"],
        unionId: json["unionId"],
        unionName: json["unionName"],
        cardNo: json["cardNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ecBeneficiaryName": ecBeneficiaryName,
        "ecBeneficiaryNameEn": ecBeneficiaryNameEn,
        "nationalID": nationalId,
        "secondNationalID": secondNationalId,
        "givenMobileNo": givenMobileNo,
        "dateOfBirth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "status": status,
        "finalStatus": finalStatus,
        "image": image,
        "dealerId": dealerId,
        "dealerName": dealerName,
        "unionId": unionId,
        "unionName": unionName,
        "cardNo": cardNo,
      };
}
