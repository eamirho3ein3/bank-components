part of bank_components;

class CircleButton extends StatelessWidget {
  final Function() onClick;
  final IconData icon;
  final String? label;
  final double? padding;

  final CustomButtonTheme style;
  CircleButton({
    required this.onClick,
    this.label,
    required this.icon,
    required this.style,
    this.padding,
  });

  double get width => 24 + (2 * (padding ?? 12));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // button
        ElevatedButton(
          onPressed: onClick,
          child: Icon(
            icon,
            color: style.foregroundColor,
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              CircleBorder(),
            ),
            overlayColor:
                MaterialStateProperty.all(Colors.black.withOpacity(0.08)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return style.disabledColor;
                } else {
                  return style.backgroundColor;
                }
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return style.foregroundDisabledColor;
                } else {
                  return style.foregroundColor;
                }
              },
            ),
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(padding ?? 12),
            ),
          ),
        ),

        // label
        label != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  label!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
