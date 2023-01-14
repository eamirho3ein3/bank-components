part of bank_components;

class CustomSnackBar extends SnackBar {
  final IconData icon;
  final Widget image;
  final DismissDirection dismissDirection;
  final String message;
  final String subMessage;
  final ComponentAction button;
  final SnackBarTheme style;
  final Duration duration;
  final double bottomMargin;
  final double horizontalMargin;
  final BuildContext context;
  CustomSnackBar({
    this.icon,
    this.image,
    this.dismissDirection,
    @required this.message,
    this.subMessage,
    @required this.style,
    @required this.context,
    this.button,
    this.bottomMargin,
    this.horizontalMargin = 16,
    @required this.duration,
  }) : super(
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
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: style.textColor),
                  ),
                  subMessage != null
                      ? Text(
                          subMessage,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: style.textColor),
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
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: style.textColor),
                      ),
                      style: ButtonStyle(
                        backgroundColor: style.buttonBackgroundColor,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          elevation: 0,
          duration: duration,
          backgroundColor: style.backgroundColor,
          dismissDirection: dismissDirection ?? DismissDirection.down,
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
  final Color textColor;
  final Color buttonTextColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final MaterialStateProperty<Color> buttonBackgroundColor;
  SnackBarTheme({
    @required this.backgroundColor,
    @required this.textColor,
    @required this.secondaryTextColor,
    @required this.buttonBackgroundColor,
    this.buttonTextColor,
  });
}
