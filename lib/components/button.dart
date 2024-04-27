part of bank_components;

class CustomButton extends StatefulWidget {
  final ButtonSize? size;
  final String? title;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final Function()? onClick;
  final Function()? onSingleClick;
  final int clickInterval;
  final CustomButtonTheme style;
  final double? horizontalPadding;
  final bool? isLoading;

  CustomButton(
      {this.size,
      this.title,
      this.rightIcon,
      this.leftIcon,
      this.onClick,
      this.onSingleClick,
      this.clickInterval = 1000,
      required this.style,
      this.horizontalPadding,
      this.isLoading});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  var isClicked = false;

  Timer? _timer;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading != null &&
              widget.isLoading! &&
              (widget.onClick == null || widget.onSingleClick == null)
          ? null
          : widget.onSingleClick != null
              ? () {
                  if (isClicked == false) {
                    _startTimer();
                    widget.onSingleClick!();
                    isClicked = true;
                  }
                }
              : widget.onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.isLoading != null && widget.isLoading!
                ? widget.size == ButtonSize.large
                    ? 14
                    : 10
                : widget.size == ButtonSize.large
                    ? 12
                    : 8,
            horizontal: widget.horizontalPadding ?? 8),
        child: widget.isLoading != null && widget.isLoading!
            ? _buildLoading(context)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // right icon
                  widget.rightIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: widget.title != null ? 8 : 0),
                          child: Icon(widget.rightIcon),
                        )
                      : SizedBox(),

                  // title
                  widget.title != null
                      ? Flexible(
                          child: Text(widget.title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(
                                      color: widget.onClick != null
                                          ? widget.style.foregroundColor
                                          : widget
                                              .style.foregroundDisabledColor)),
                        )
                      : SizedBox(),

                  // left icon
                  widget.leftIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: widget.title != null ? 8 : 0),
                          child: Icon(widget.leftIcon),
                        )
                      : SizedBox(),
                ],
              ),
      ),
      style: ButtonStyle(
        alignment: widget.style.alignment,
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.08)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return widget.style.disabledColor;
            } else {
              return widget.style.backgroundColor;
            }
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return widget.style.foregroundDisabledColor;
            } else {
              return widget.style.foregroundColor;
            }
          },
        ),
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(
          EdgeInsets.zero,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
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
        valueColor: AlwaysStoppedAnimation<Color>(
            widget.style.loadingButtonTheme.valueColor),
        backgroundColor: widget.style.loadingButtonTheme.backgroundColor,
      ),
    );
  }

  _startTimer() {
    _timer = Timer(
        Duration(milliseconds: widget.clickInterval), () => isClicked = false);
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
