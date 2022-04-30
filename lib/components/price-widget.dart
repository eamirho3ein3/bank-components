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
      _style = theme.negativeColor;
    } else {
      _style = theme.posetiveColor;
    }
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: convertedPrice, style: _style),
          TextSpan(
            text: ' ',
          ),
          TextSpan(text: 'ریال', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}

class PriceWidgetTheme {
  final TextStyle negativeColor;
  final TextStyle posetiveColor;

  PriceWidgetTheme(
      {@required this.negativeColor, @required this.posetiveColor});
}
