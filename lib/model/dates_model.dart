
import 'dart:convert';

VaccinationDates vaccinationDatesFromJson(String str) => VaccinationDates.fromJson(json.decode(str));

String vaccinationDatesToJson(VaccinationDates data) => json.encode(data.toJson());

class VaccinationDates {
    List<DateTime>? vaccinationDates;

    VaccinationDates({
        this.vaccinationDates,
    });

    factory VaccinationDates.fromJson(Map<String, dynamic> json) => VaccinationDates(
        vaccinationDates: json["vaccination_dates"] == null ? [] : List<DateTime>.from(json["vaccination_dates"]!.map((x) => DateTime.parse(x))),
    );

    Map<String, dynamic> toJson() => {
        "vaccination_dates": vaccinationDates == null ? [] : List<dynamic>.from(vaccinationDates!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    };
}
