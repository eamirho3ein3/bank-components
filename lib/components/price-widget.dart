part of bank_components;

class PriceWidget extends StatelessWidget {
  final int price;
  final String convertedPrice;
  final PriceWidgetTheme theme;
  PriceWidget(
      {@required this.price,
      @required this.convertedPrice,
      @required this.theme});
  @override
  Widget build(BuildContext context) {
    TextStyle _style;
    if (price.isNegative) {
      _style = theme.negativeStyle;
    } else {
      _style = theme.posetiveStyle;
    }
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: convertedPrice, style: _style),
          TextSpan(
            text: ' ',
          ),
          TextSpan(text: 'ریال', style: theme.unitStyle),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}

class PriceWidgetTheme {
  final TextStyle negativeStyle;
  final TextStyle posetiveStyle;
  final TextStyle unitStyle;

  PriceWidgetTheme(
      {@required this.negativeStyle,
      @required this.posetiveStyle,
      @required this.unitStyle});
}
