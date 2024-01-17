import 'dart:convert';

import 'package:doctor_baby/model/dates_model.dart';
import 'package:doctor_baby/services/dates_service.dart';
import 'package:get/get.dart';

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