import 'dart:convert';
import 'dart:typed_data';

import '../models/dealear_wise_ben_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  List<DealearWiseBenListModel> dealearWiseBenListModelList =
      <DealearWiseBenListModel>[];
  List<DealearWiseBenListModel> get taskModelList =>
      dealearWiseBenListModelList;
  Future<DealearWiseBenListModel?> findUserInfo(String id) async {
    Map<String, dynamic> bodyData = {"token": "FFP@DGFOOD#BCL&0088", "id": 2};
    var body = jsonEncode(bodyData);

    try {
      var uri = Uri.parse('https://202.84.36.139/FFPAPI/api/mobile/dealerId');
      final response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      print("response.body = ${response.body}");

      if (response.statusCode == 200) {
        var resData = dealearWiseBenListModelFromJson(
            jsonDecode(utf8.decode(response.bodyBytes))["ben"]);
        // setState(() {
        dealearWiseBenListModelList = resData;
        print("........................${dealearWiseBenListModelList.length}");
        print("00000000009 ${taskModelList.length}");

        // });
        // print("====================== ${dealearWiseBenListModel.id}");
        // Uint8List decodedbytes =
        //     base64.decode(dealearWiseBenListModel.image.toString());
      }
    } catch (e) {
      print("error = $e");
    }
  }
}
