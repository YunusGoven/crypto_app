class Transaction {
  final String cryptoId;
  final num number;
  final num currentValue;
  final num total;
  final String type;
  final DateTime date;

  Transaction(this.cryptoId, this.number, this.currentValue, this.total,
      this.type, this.date);
}
