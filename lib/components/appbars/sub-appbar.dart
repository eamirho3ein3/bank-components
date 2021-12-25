part of bank_components;

class SubAppBar extends StatelessWidget {
  final List<Widget> actions;
  final IconData icon;
  final String title;
  SubAppBar({this.actions, this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: title != null || icon != null ? _buildTitle(context) : SizedBox(),
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
        icon != null ? Icon(icon) : SizedBox(),
      ],
    );
  }
}
