part of bank_components;

class CryptoSymbol extends StatelessWidget {
  final String title;
  final SymbolTheme style;
  CryptoSymbol({required this.title, required this.style});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: style.titleColor),
      ),
    );
  }
}

class SymbolTheme {
  final Color titleColor;
  final Color backgroundColor;

  SymbolTheme({required this.titleColor, required this.backgroundColor});
}
