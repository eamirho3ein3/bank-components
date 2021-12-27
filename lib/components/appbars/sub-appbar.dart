part of bank_components;

class SubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final IconData backIcon;
  final IconData titleIcon;
  final String title;

  SubAppBar(
      {this.actions,
      this.titleIcon,
      @required this.title,
      @required this.backIcon});

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: title != null || titleIcon != null
          ? _buildTitle(context)
          : SizedBox(),
      elevation: 0,
      leading: backIcon != null
          ? IconButton(
              icon: new Icon(
                backIcon,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  _buildTitle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        title != null
            ? Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              )
            : SizedBox(),
        titleIcon != null ? Icon(titleIcon) : SizedBox(),
      ],
    );
  }
}
