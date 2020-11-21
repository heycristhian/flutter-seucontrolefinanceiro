class QtdMonth {
  static int quantityMonths(var day2) {
    var day1 = DateTime.now();
    var day1Milliseconds = day1.millisecondsSinceEpoch;
    var day2Milliseconds = DateTime.parse(day2).subtract(Duration(days: 29)).millisecondsSinceEpoch;

    double monthsCount = (day2Milliseconds - day1Milliseconds) / 1000 / 60 / 60 / 24 / 30 + 1;

    int monthsCard = int.parse(monthsCount.toStringAsFixed(0));

    if (monthsCount - monthsCount.round() == 0) {
      return monthsCard; 
    } else {
      return monthsCard+1; 
    }
  }
}