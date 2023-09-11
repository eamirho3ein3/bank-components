part of bank_components;

class CustomButton extends StatelessWidget {
  final ButtonSize? size;
  final String? title;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final Function()? onClick;
  final CustomButtonTheme style;
  final double? horizontalPadding;
  final bool? isLoading;

  CustomButton(
      {this.size,
      this.title,
      this.rightIcon,
      this.leftIcon,
      this.onClick,
      required this.style,
      this.horizontalPadding,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading != null && isLoading! ? null : onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isLoading != null && isLoading!
                ? size == ButtonSize.large
                    ? 14
                    : 10
                : size == ButtonSize.large
                    ? 12
                    : 8,
            horizontal: horizontalPadding ?? 8),
        child: isLoading != null && isLoading!
            ? _buildLoading(context)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // right icon
                  rightIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(left: title != null ? 8 : 0),
                          child: Icon(rightIcon),
                        )
                      : SizedBox(),

                  // title
                  title != null
                      ? Flexible(
                          child: Text(title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(
                                      color: onClick != null
                                          ? style.foregroundColor
                                          : style.foregroundDisabledColor)),
                        )
                      : SizedBox(),

                  // left icon
                  leftIcon != null
                      ? Padding(
                          padding:
                              EdgeInsets.only(right: title != null ? 8 : 0),
                          child: Icon(leftIcon),
                        )
                      : SizedBox(),
                ],
              ),
      ),
      style: ButtonStyle(
        alignment: style.alignment,
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

  _buildLoading(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(style.loadingButtonTheme.valueColor),
        backgroundColor: style.loadingButtonTheme.backgroundColor,
      ),
    );
  }
}

class CustomButtonTheme {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledColor;
  final Color foregroundDisabledColor;
  final LoadingButtonTheme loadingButtonTheme;
  final AlignmentGeometry? alignment;

  CustomButtonTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledColor,
    required this.foregroundDisabledColor,
    required this.loadingButtonTheme,
    this.alignment,
  });
}

class LoadingButtonTheme {
  final Color valueColor;
  final Color backgroundColor;

  LoadingButtonTheme({
    required this.valueColor,
    required this.backgroundColor,
  });
}

enum ButtonSize { medium, large }
