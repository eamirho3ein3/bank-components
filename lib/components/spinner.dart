part of bank_components;

class CustomSpinner extends StatelessWidget {
  final SpinnerTheme style;
  final SpinerSize size;
  CustomSpinner({required this.style, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size == SpinerSize.Small ? 2 : 4),
      height: size == SpinerSize.Small ? 24 : 48,
      width: size == SpinerSize.Small ? 24 : 48,
      child: CircularProgressIndicator(
        strokeWidth: size == SpinerSize.Small ? 4 : 6,
        valueColor: AlwaysStoppedAnimation<Color>(style.color),
        backgroundColor: style.backgroundColor,
      ),
    );
  }
}

class SpinnerTheme {
  final Color color;
  final Color backgroundColor;

  SpinnerTheme({required this.color, required this.backgroundColor});
}

enum SpinerSize { Small, Large }
