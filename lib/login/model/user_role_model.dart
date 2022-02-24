class UserRole {
  UserRole(
      {this.reportMain,
      this.attendanceReport,
      this.flavorReport,
      this.poundReport,
      this.deliveryReport,
      this.paymentReport,
      this.stockMain,
      this.stockUpdate,
      this.stockHistory,
      this.supplierBill,
      this.supplierCheque,
      this.leave,
      this.qc,
      this.delivery,
      this.baker,
      this.ticket,
      this.salesReport,
      this.routeLog});

  List<String>? reportMain;
  List<String>? attendanceReport;
  List<String>? flavorReport;
  List<String>? poundReport;
  List<String>? deliveryReport;
  List<String>? paymentReport;
  List<String>? stockMain;
  List<String>? stockUpdate;
  List<String>? stockHistory;
  List<String>? supplierBill;

  List<String>? supplierCheque;

  List<String>? leave;
  List<String>? qc;
  List<String>? delivery;
  List<String>? baker;
  List<String>? ticket;
  List<String>? salesReport;
  List<String>? routeLog;

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
      reportMain: json["report-main"] == null
          ? null
          : List<String>.from(json["report-main"].map((x) => x)),
      attendanceReport: json["attendance-report"] == null
          ? null
          : List<String>.from(json["attendance-report"].map((x) => x)),
      flavorReport: json["flavor-report"] == null
          ? null
          : List<String>.from(json["flavor-report"].map((x) => x)),
      poundReport: json["pound-report"] == null
          ? null
          : List<String>.from(json["pound-report"].map((x) => x)),
      paymentReport: json["payment-report"] == null
          ? null
          : List<String>.from(json["payment-report"].map((x) => x)),
      stockMain: json["stock-main"] == null
          ? null
          : List<String>.from(json["stock-main"].map((x) => x)),
      stockUpdate: json["stock-update"] == null
          ? null
          : List<String>.from(json["stock-update"].map((x) => x)),
      stockHistory: json["stock-history"] == null
          ? null
          : List<String>.from(json["stock-history"].map((x) => x)),
      supplierBill: json["supplier-bill"] == null
          ? null
          : List<String>.from(json["supplier-bill"].map((x) => x)),
      supplierCheque: json["supplier-cheque"] == null
          ? null
          : List<String>.from(json["supplier-cheque"].map((x) => x)),
      deliveryReport: json["delivery-report"] == null
          ? null
          : List<String>.from(json["delivery-report"].map((x) => x)),
      leave: json["leave"] == null
          ? null
          : List<String>.from(json["leave"].map((x) => x)),
      qc: json["qc"] == null
          ? null
          : List<String>.from(json["qc"].map((x) => x)),
      delivery: json["delivery"] == null
          ? null
          : List<String>.from(json["delivery"].map((x) => x)),
      baker: json["baker"] == null
          ? null
          : List<String>.from(json["baker"].map((x) => x)),
      ticket: json["ticket"] == null
          ? null
          : List<String>.from(json["ticket"].map((x) => x)),
      salesReport: json["sales-report"] == null
          ? null
          : List<String>.from(json["sales-report"].map((x) => x)),
      routeLog: json["route-log"] == null
          ? null
          : List<String>.from(json["route-log"].map((x) => x)));
}
