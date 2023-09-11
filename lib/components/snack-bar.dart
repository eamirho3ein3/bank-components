part of bank_components;

class CustomSnackBar extends SnackBar {
  final IconData? icon;
  final Widget? image;

  /// use when you want show text as message
  final String? message;

  /// use when you want show custom widget as message
  final Widget? messageWidget;
  final String? subMessage;
  final ComponentAction? button;
  final SnackBarTheme style;
  final Duration duration;
  final double? bottomMargin;
  final double horizontalMargin;
  final BuildContext context;
  final BorderRadius radius;
  CustomSnackBar({
    this.icon,
    this.image,
    this.message,
    this.messageWidget,
    this.subMessage,
    required this.style,
    required this.context,
    this.button,
    this.bottomMargin,
    this.horizontalMargin = 16,
    required this.duration,
    BorderRadius? radius,
  })  : this.radius = radius ?? BorderRadius.circular(4),
        super(
          content: Row(
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: style.textColor,
                      size: 24,
                    )
                  : SizedBox(),
              image != null ? image : SizedBox(),
              SizedBox(
                width: icon != null || image != null ? 8 : 0,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message == null
                      ? (messageWidget ?? SizedBox())
                      : Text(
                          message,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: style.textColor),
                        ),
                  subMessage != null
                      ? Text(
                          subMessage,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color:
                                  style.secondaryTextColor ?? style.textColor),
                        )
                      : SizedBox(),
                ],
              )),
              SizedBox(
                width: button != null ? 8 : 0,
              ),
              button != null
                  ? ElevatedButton(
                      onPressed: button.onClick,
                      child: Text(
                        button.text,
                        style: Theme.of(context).textTheme.button!.copyWith(
                            color: style.buttonTextColor ?? style.textColor),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: style.buttonBackgroundColor,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          elevation: 0,
          duration: duration,
          shape: RoundedRectangleBorder(
            borderRadius: radius!,
          ),
          backgroundColor: style.backgroundColor,
          dismissDirection: DismissDirection.down,
          padding: EdgeInsets.only(
              left: button != null ? 8 : 12, right: 12, top: 12, bottom: 12),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              bottom: bottomMargin != null ? bottomMargin : 16),
        );
}

class SnackBarTheme {
  /// use for message color
  final Color textColor;

  /// use for button color
  final Color? buttonTextColor;

  /// use for subMessage color
  final Color? secondaryTextColor;
  final Color backgroundColor;
  final MaterialStateProperty<Color> buttonBackgroundColor;
  SnackBarTheme({
    required this.backgroundColor,
    required this.textColor,
    this.secondaryTextColor,
    required this.buttonBackgroundColor,
    this.buttonTextColor,
  });
}
