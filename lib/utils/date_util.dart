import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateToYYYYMMDD(DateTime date) {
  final DateFormat formatter = DateFormat(dateFormat2);
  final String formatted = formatter.format(date);
  return formatted;
}

String formatDateToYYYYMMDDFromStringDDMMYYYY(String date) {
  var inputFormat = DateFormat('dd-MM-yyyy');
  var date1 = inputFormat.parse(date);

  var outputFormat = DateFormat('yyyy-MM-dd');
  var formatted = outputFormat.format(date1);
  return formatted;
}

String formatDateToDDMMYYYY(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

/*final f = new DateFormat('yyyy-MM-dd hh:mm');
Text(f.format(new DateTime.fromMillisecondsSinceEpoch(values[index]["start_time"]*1000)));*/

String formatDateToYYYYMMDDString(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}
String formatDateToHHMMAPM(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('hh:mm a');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String formatDateYYYYMMDD(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String setDateTimeFormatForAppointment(String date) {
  debugPrint("inputFormat: $date");
  var inputFormat = DateFormat('dd-MM-yyyy hh:mm a');
  DateTime dateToConvert = inputFormat.parse(date);
  DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  final String formatted = outputFormat.format(dateToConvert);
  debugPrint("outputFormat:: $formatted");
  return formatted;
}

String getDateFormatForAppointment(String dateTime) {
  debugPrint("inputFormat: $dateTime");
  var inputFormat = DateFormat("'yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateTime dateToConvert = DateTime.parse(dateTime);
  DateFormat outputFormat = DateFormat("dd-MM-yyyy");
  final String formatted = outputFormat.format(dateToConvert);
  debugPrint("outputFormat:: $formatted");
  return formatted;
}

String getTimeFormatForAppointment(String dateTime) {
  debugPrint("inputFormat: $dateTime");
  var inputFormat = DateFormat("'yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateTime dateToConvert = DateTime.parse(dateTime);
  DateFormat outputFormat = DateFormat("hh:mm a");
  final String formatted = outputFormat.format(dateToConvert);
  debugPrint("outputFormat:: $formatted");
  return formatted;
}

String formatDateTimeToDDMMYYYYHHMM(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('dd MMM hh:mm a');
  final String formatted = formatter.format(dateToConvert
      .toLocal()); //To local function is used to convert time to the device
  return formatted;
}

String formatDateTimeToDDMMYYYYHHMMfromUTC(String date) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateTime parsedDate = inputFormat.parse(date);
  final DateFormat formatter = DateFormat('dd MMM hh:mm a');
  final String formatted = formatter.format(parsedDate
      .toLocal()); //To local function is used to convert time to the device
  return formatted;
}

String formatTimeToHHMM(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('hh:mm');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String formatDateTimeToAmPm(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat.jm();
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String formatDate1(String date) {
  return formatDate(date, dateFormat1);
}

String formatDate(String date, String format) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat(format);
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String dateFormat1 = "dd-MM-yyyy";
String dateFormat2 = "yyyy-MM-dd";
String dateFormat3 = "dd MMMM yyyy";
String dateFormat4 = "MMM dd";
String dateFormat5 = "MMM dd yyyy";

String formatDateToDDEEEE(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('dd. EEEE');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String formatDateToEEEEdd(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('EEEE dd');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}

String formatDateToMMMMYYYY(String date) {
  DateTime dateToConvert = DateTime.parse(date);
  final DateFormat formatter = DateFormat('MMMM yyyy');
  final String formatted = formatter.format(dateToConvert);
  return formatted;
}
