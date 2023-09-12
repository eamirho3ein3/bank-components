part of bank_components;

class CustomBanner extends StatelessWidget {
  final CustomIconTheme icon;
  final String message;
  final ComponentAction? action;
  final BannerTheme style;
  CustomBanner(
      {required this.icon,
      required this.message,
      this.action,
      required this.style});
  @override
  Widget build(BuildContext context) {
    return _buildBanner(context);
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: style.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: style.backgroundColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // icon
              Container(
                padding: EdgeInsets.all(10),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: icon.backgroundColor != null
                        ? icon.backgroundColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(24)),
                child: Icon(
                  icon.icon,
                  size: 24,
                  color: icon.iconColor != null
                      ? icon.iconColor
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              SizedBox(
                width: 16,
              ),

              // message
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),

          // actions
          action == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: InkWell(
                    onTap: action?.onClick,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          action!.text,
                          style: Theme.of(context).textTheme.button,
                        ),
                        action!.icon != null
                            ? Icon(action!.icon!.icon,
                                color: action!.icon!.iconColor)
                            : SizedBox(),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class BannerTheme {
  final Color borderColor;
  final Color backgroundColor;

  BannerTheme({required this.borderColor, required this.backgroundColor});
}

class CustomIconTheme {
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  CustomIconTheme(
      {required this.icon,
      this.iconColor,
      this.backgroundColor,
      this.borderColor});
}
