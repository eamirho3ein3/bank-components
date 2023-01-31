part of bank_components;

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<CustomIconButton> actions;

  MainAppBar({@required this.title, @required this.actions});
  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      actions: actions,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
