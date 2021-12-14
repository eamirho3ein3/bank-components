part of components;

class NeoSnackBar extends SnackBar {
  final IconData icon;
  final String message;
  final ComponentAction button;
  final SnackBarTheme style;
  final double bottomMargin;
  final BuildContext context;
  NeoSnackBar({
    this.icon,
    @required this.message,
    @required this.style,
    @required this.context,
    this.button,
    this.bottomMargin,
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
              SizedBox(
                width: icon != null ? 8 : 0,
              ),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: style.textColor),
                ),
              ),
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
          duration: Duration(seconds: 10),
          backgroundColor: style.backgroundColor,
          padding: EdgeInsets.only(
            left: button != null ? 8 : 12,
            right: 12,
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: bottomMargin != null ? bottomMargin : 16),
        );
}

class SnackBarTheme {
  final Color textColor;
  final Color backgroundColor;
  final MaterialStateProperty<Color> buttonBackgroundColor;
  SnackBarTheme({
    @required this.backgroundColor,
    @required this.textColor,
    @required this.buttonBackgroundColor,
  });
}
