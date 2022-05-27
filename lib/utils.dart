import 'package:intl/intl.dart';

class Util{
  static String getFormattedDate(DateTime dateTime){
    return DateFormat('MMM d, y').format(dateTime);
  }
}