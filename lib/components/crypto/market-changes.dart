part of bank_components;

class MarketChanges extends StatelessWidget {
  final double value;
  final Color color;
  final bool isPositive;
  MarketChanges(
      {@required this.value, @required this.color, @required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Text(
      (isPositive ? '+' : '-') + "$value" + "٪",
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.caption.copyWith(color: color),
    );
  }
}
