enum PayMethod {
  creditCatd('신용카드'),
  checkCard('체크카드'),
  cash('현금'),
  accountTransfer('계좌이체'),
  none('없음');

  final String name;

  const PayMethod(this.name);

  @override
  String toString() {
    switch (this) {
      case PayMethod.creditCatd:
        return 'CREDIT_CARD';
      case PayMethod.checkCard:
        return 'DEBIT_CARD';
      case PayMethod.cash:
        return 'CASH';
      case PayMethod.accountTransfer:
        return 'BANK_TRANSFER';
      case PayMethod.none:
        return 'NONE';
    }
  }
}
