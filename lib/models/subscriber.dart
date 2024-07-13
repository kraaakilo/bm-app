import 'package:intl/intl.dart';

class Subscriber {
  String? name;
  String? reference;
  String? provider;
  List<Bill>? bills;

  Subscriber({this.name, this.reference, this.bills});

  Subscriber.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    reference = json['reference'];
    provider = json['subscriberType'];
    if (json['bills'] != null) {
      bills = <Bill>[];
      json['bills'].forEach((v) {
        bills!.add(Bill.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['reference'] = reference;
    data['subscriberType'] = provider;
    if (bills != null) {
      data['bills'] = bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bill {
  int? id;
  double? amount;
  String? period;
  String? dueDate;
  String? reference;
  bool? paid;

  Bill({
    this.id,
    this.amount,
    this.period,
    this.dueDate,
    this.reference,
    this.paid,
  });

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    period = json['period'];
    dueDate = json['dueDate'];
    reference = json['reference'];
    paid = json['paid'];
  }

  String getFormattedDueDate() {
    DateTime dateTime = DateTime.parse(
      '${dueDate!.substring(0, 4)}-${dueDate!.substring(4, 6)}-01',
    );
    String formattedDate = DateFormat.yMMMM("fr").format(dateTime);
    return formattedDate.substring(0, 1).toUpperCase() +
        formattedDate.substring(1);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['period'] = period;
    data['dueDate'] = dueDate;
    data['reference'] = reference;
    data['paid'] = paid;
    return data;
  }
}
