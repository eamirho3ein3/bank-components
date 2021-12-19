part of bank_components;

class CustomSpinner extends StatelessWidget {
  final SpinnerTheme style;
  CustomSpinner({@required this.style});
  @override
  Widget build(BuildContext context) {
    return _buildSpinner(
      style: style,
    );
  }
}

Widget _buildSpinner({@required SpinnerTheme style}) {
  return Container(
    padding: EdgeInsets.all(style.size == SpinerSize.Small ? 2 : 4),
    height: style.size == SpinerSize.Small ? 24 : 48,
    width: style.size == SpinerSize.Small ? 24 : 48,
    child: CircularProgressIndicator(
      strokeWidth: style.size == SpinerSize.Small ? 4 : 6,
      valueColor: AlwaysStoppedAnimation<Color>(style.color),
      backgroundColor: style.backgroundColor,
    ),
  );
}

class SpinnerTheme {
  final Color color;
  final Color backgroundColor;
  final SpinerSize size;

  SpinnerTheme({this.color, this.backgroundColor, @required this.size});
}

enum SpinerSize { Small, Large }
