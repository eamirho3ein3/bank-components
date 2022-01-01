part of bank_components;

class CustomButton extends StatelessWidget {
  final ButtonSize size;
  final String title;
  final IconData rightIcon;
  final IconData leftIcon;
  final Function onClick;
  final CustomButtonTheme style;
  final double horizontalPadding;

  CustomButton(
      {this.size,
      this.title,
      this.rightIcon,
      this.leftIcon,
      this.onClick,
      @required this.style,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size == ButtonSize.large ? 12 : 8,
            horizontal: horizontalPadding != null ? horizontalPadding : 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // right icon
            rightIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(rightIcon),
                  )
                : SizedBox(),

            // title
            Flexible(
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: style.foregroundColor)),
            ),

            // left icon
            leftIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(leftIcon),
                  )
                : SizedBox(),
          ],
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.08)),
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
          EdgeInsets.zero,
        ),
        // padding: MaterialStateProperty.all(EdgeInsets.symmetric(
        //     vertical: size == ButtonSize.large ? 12 : 8,
        //     horizontal: size == ButtonSize.large ? 24 : 16)),
      ),
    );
  }
}

class CustomButtonTheme {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledColor;
  final Color foregroundDisabledColor;
  CustomButtonTheme({
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.disabledColor,
    @required this.foregroundDisabledColor,
  });
}

enum ButtonSize { medium, large }
