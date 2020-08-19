import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateUtilities on DateTime {
  bool isSameDay(DateTime dateTime) {
    return dateTime != null &&
        this.year == dateTime.year &&
        this.month == dateTime.month &&
        this.day == dateTime.day;
  }

  String toMenuDate() {
    return DateFormat('dd-MM-yyyy', Intl.defaultLocale).format(this);
  }

  String toUIDate() {
    return DateFormat('dd MMM yyyy', Intl.defaultLocale).format(this);
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

  String toUIDate(){
    return DateFormat('dd\nMMM', Intl.defaultLocale).format(this.toDate());
  }
}