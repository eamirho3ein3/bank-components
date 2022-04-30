part of bank_components;

class NeoPriceWidget extends StatelessWidget {
  final int price;
  final String convertedPrice;
  final PriceWidgetTheme theme;
  NeoPriceWidget(
      {@required this.price,
      @required this.convertedPrice,
      @required this.theme});
  @override
  Widget build(BuildContext context) {
    TextStyle _style;
    if (price.isNegative) {
      _style = Theme.of(context)
          .textTheme
          .headline1
          .copyWith(color: theme.negativeColor);
    } else {
      _style = Theme.of(context)
          .textTheme
          .headline1
          .copyWith(color: theme.posetiveColor);
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
  final Color negativeColor;
  final Color posetiveColor;

  PriceWidgetTheme(
      {@required this.negativeColor, @required this.posetiveColor});
}
