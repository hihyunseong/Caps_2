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
        return '신용카드';
      case PayMethod.checkCard:
        return '체크카드';
      case PayMethod.cash:
        return '현금';
      case PayMethod.accountTransfer:
        return '계좌이체';
      case PayMethod.none:
        return '없음';
    }
  }
}
