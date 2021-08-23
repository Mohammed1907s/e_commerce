


import 'package:e_commerce/api/controllers/notification_api_controller.dart';
import 'package:e_commerce/models/notification.dart';
import 'package:get/get.dart';

class NotificationGetxController extends GetxController {
  final NotificationApiController notificationApiController = NotificationApiController();
  RxList<NotificationDetails> notification = <NotificationDetails>[].obs;
  RxBool loading = false.obs;

  static NotificationGetxController get to => Get.find();

  void onInit() {
    super.onInit();
    getNotification();
    notification.refresh();
  }

  Future<void> getNotification() async {
    loading.value = true;
    update();
    notification.value = await notificationApiController.getAllNotification();
    loading.value = false;
    update();
  }





}