class OcurrencyQuantityModel {
  int? opened;
  int? inCurse;
  int? canceled;
  int? completed;
  OcurrencyQuantityModel({
    this.opened,
    this.inCurse,
    this.canceled,
    this.completed,
  });

  @override
  String toString() {
    return 'OcurrencyQuantityModel(opened: $opened, inCurse: $inCurse, canceled: $canceled, completed: $completed)';
  }
}
