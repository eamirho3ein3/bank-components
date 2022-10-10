part of bank_components;

class SubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final IconData backIcon;
  final Widget titleWidget;
  final String title;
  final Color backgroundColor;
  final Color backIconColor;

  SubAppBar(
      {this.actions,
      this.titleWidget,
      this.title,
      @required this.backIcon,
      this.backgroundColor,
      this.backIconColor});

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: title != null || titleWidget != null
          ? _buildTitle(context)
          : SizedBox(),
      elevation: 0,
      leading: backIcon != null
          ? CustomIconButton(
              icon: backIcon,
              backgroundColor: Colors.transparent,
              iconColor: backIconColor,
              onClick: () => Navigator.of(context).maybePop(),
            )
          : null,
      centerTitle: true,
      backgroundColor: backgroundColor,
    );
  }

  _buildTitle(BuildContext context) {
    return titleWidget != null
        ? titleWidget
        : Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          );
  }
}
