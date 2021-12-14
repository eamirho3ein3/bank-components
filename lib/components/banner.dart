part of components;

class NeoBanner extends StatelessWidget {
  final IconData icon;
  final String message;
  final ComponentAction action;
  final BannerTheme style;
  NeoBanner(
      {@required this.icon,
      @required this.message,
      this.action,
      @required this.style});
  @override
  Widget build(BuildContext context) {
    return _buildBanner(
        context: context,
        icon: icon,
        message: message,
        style: style,
        action: action);
  }
}

Widget _buildBanner(
    {@required IconData icon,
    @required String message,
    ComponentAction action,
    @required BannerTheme style,
    @required BuildContext context}) {
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
            Container(
              padding: EdgeInsets.all(10),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(24)),
              child: Icon(
                icon,
                size: 24,
                color: style.iconColor != null
                    ? style.iconColor
                    : Theme.of(context).iconTheme.color,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        action == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 16),
                child: InkWell(
                  onTap: action.onClick,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        action.text,
                        style: Theme.of(context).textTheme.button,
                      ),
                      Icon(Icons.chevron_left)
                    ],
                  ),
                ),
              )
      ],
    ),
  );
}

class BannerTheme {
  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;

  BannerTheme({this.borderColor, this.backgroundColor, this.iconColor});
}

class NeoIconTheme {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  NeoIconTheme(
      {this.icon, this.iconColor, this.backgroundColor, this.borderColor});
}
