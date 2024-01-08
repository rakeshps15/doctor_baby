import 'dart:convert';
import 'package:get/get.dart';
import '../model/dates_model.dart';
import '../service/date_service.dart';

class DatesController extends GetxController{

  var dates = <DateTime>[].obs;

  @override
  void onInit() {
    getDates();
    super.onInit();
  }

  void getDates() async{
    try {
      var data = await Httpdates.fetchDates();
      var jsondata = json.decode(data);
      VaccinationDates vaccinationDates = VaccinationDates.fromJson(jsondata);
      dates.assignAll(vaccinationDates.vaccinationDates ?? []);
      print(dates);
    } catch (e) {
      print(e);
    }
  }
}