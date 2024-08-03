import 'package:noteapp/constant/msg.dart';

validInput(String val, int min, int max) {
  if (val.length > max) {
    return "$msgInputMax $max";
  } else if (val.isEmpty) {
    return "$msgInputEmpty ";
  } else if (val.length < min) {
    return "$msgInputMin $min";
  }
}
