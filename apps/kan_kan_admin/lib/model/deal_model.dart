class DealModel {
  late String productName;
  late int max;
  late int numberOfJoined;
  late String status;
  late String start;
  late String end;
  late String id;
  DealModel(
      {required this.id,
      required this.numberOfJoined,
      required this.max,
      required this.end,
      required this.productName,
      required this.start,
      required this.status});
}
