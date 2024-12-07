part of bank_components;

class CustomTooltip extends StatefulWidget {
  final Widget child;

  final TooltipSetting setting;
  CustomTooltip({required this.child, required this.setting});
  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  final tooltipKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        final dynamic _tooltip = tooltipKey.currentState;
        _tooltip.ensureTooltipVisible();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      excludeFromSemantics: false,
      key: tooltipKey,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: ShapeDecoration(
        color: widget.setting.backgroundColor,
        shape: TooltipShapeBorder(arrowArc: 0),
      ),
      textStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: widget.setting.textColor),
      showDuration: Duration(seconds: 4),
      preferBelow: false,
      message: widget.setting.message,
      child: GestureDetector(
        onLongPress: () {},
        child: widget.child,
      ),
    );
  }
}

class TooltipSetting {
  final Color textColor;
  final Color backgroundColor;
  final String message;
  TooltipSetting(
      {required this.textColor,
      required this.backgroundColor,
      required this.message});
}

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  TooltipShapeBorder({
    this.radius = 4.0,
    this.arrowWidth = 12.0,
    this.arrowHeight = 7.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx * 1.3 - x, rect.bottomCenter.dy)
      ..relativeLineTo(-x / 2 * r, y * r)
      ..relativeQuadraticBezierTo(
          -x / 2 * (1 - r), y * (1 - r), -x * (1 - r), 0)
      ..relativeLineTo(-x / 2 * r, -y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
