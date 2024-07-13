class Statistic {
  double paidBills = 0;
  double unpaidBills = 0;
  double totalBills = 0;

  Statistic({
    this.paidBills = 0,
    this.unpaidBills = 0,
    this.totalBills = 0,
  });

  Statistic.fromJson(Map<String, dynamic> json) {
    paidBills = json['paidBills'];
    unpaidBills = json['unpaidBills'];
    totalBills = json['totalBills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, double> data = <String, double>{};
    data['paidBills'] = paidBills;
    data['unpaidBills'] = unpaidBills;
    data['totalBills'] = totalBills;
    return data;
  }
}
