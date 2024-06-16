enum PayMethod {
  creditCatd('신용카드'),
  checkCard('체크카드'),
  cash('현금'),
  accountTransfer('계좌이체'),
  none('없음');

  final String name;

  const PayMethod(this.name);
}
