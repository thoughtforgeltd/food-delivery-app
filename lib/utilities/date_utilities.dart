import 'package:cloud_firestore/cloud_firestore.dart';

extension DateUtilities on DateTime {
  bool isSameDay(DateTime dateTime) {
    return this.year == dateTime.year && this.month == dateTime.month
        && this.day == dateTime.day;
  }
}

extension TimestampUtilities on Timestamp {
  bool isSameDay(DateTime dateTime) {
    final timestamp = this.toDate();
    return timestamp.year == dateTime.year && timestamp.month == dateTime.month
        && timestamp.day == dateTime.day;
  }
}