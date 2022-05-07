part of bank_components;

class PriceWidget extends StatelessWidget {
  final int price;
  final String convertedPrice;
  final PriceWidgetTheme theme;
  final String unit;
  PriceWidget(
      {@required this.price,
      @required this.convertedPrice,
      @required this.theme,
      @required this.unit});
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
          TextSpan(text: unit, style: theme.unitStyle),
          TextSpan(
            text: ' ',
          ),
          TextSpan(text: convertedPrice, style: _style),
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
