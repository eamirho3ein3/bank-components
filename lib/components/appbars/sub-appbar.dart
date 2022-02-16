part of bank_components;

class SubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final IconData backIcon;
  final Widget titleWidget;
  final String title;

  SubAppBar(
      {this.actions, this.titleWidget, this.title, @required this.backIcon});

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
              onClick: () => Navigator.of(context).pop(),
            )
          : null,
      centerTitle: true,
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
