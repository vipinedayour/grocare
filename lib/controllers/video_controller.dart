import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/video_model.dart';

class VideoController extends GetxController {
  var videoList = <Model>[].obs;
  var page = 1.obs;
  var isLoading = false.obs;

  getData() async {
    try {
      isLoading.value = true;
      var url = Uri.parse(
          'https://internship-service.onrender.com/videos?page=$page');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        videoList.addAll(modelFromJson(response.body));
        log(page.value.toString());
        page++;
      }
    } catch (err) {
      log('$err');
    } finally {
      isLoading.value = false;
    }
  }
}
