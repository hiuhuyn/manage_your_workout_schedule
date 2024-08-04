String formatDateTime(DateTime dateTime) {
  // Lấy các thành phần ngày, tháng, năm, giờ, phút
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  // Định dạng theo kiểu ngày/tháng/năm giờ:phút
  return "$day/$month/$year $hour:$minute";
}
