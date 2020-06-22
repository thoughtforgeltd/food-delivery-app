import 'package:cloud_firestore/cloud_firestore.dart';

extension DateUtilities on DateTime {
  bool isSameDay(DateTime dateTime) {
    return dateTime != null && this.year == dateTime.year && this.month == dateTime.month
        && this.day == dateTime.day;
  }
}

extension TimestampUtilities on Timestamp {
  bool isSameDay(DateTime dateTime) {
    final timestamp = this.toDate();
    return dateTime != null && timestamp.year == dateTime.year && timestamp.month == dateTime.month
        && timestamp.day == dateTime.day;
  }

  bool isSameDayFromTimestamp(Timestamp dateTime) {
    final timestamp = this.toDate();
    final other = dateTime.toDate();
    return dateTime != null && timestamp.year == other.year && timestamp.month == other.month
        && timestamp.day == other.day;
  }
}