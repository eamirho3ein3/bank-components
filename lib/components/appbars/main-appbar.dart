part of bank_components;

class MainAppBar extends StatelessWidget {
  final String title;
  final List<CustomIconButton> actions;

  MainAppBar({@required this.title, @required this.actions});
  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    var index = 1;
    for (var item in actions) {
      _children.add(item);
      if (index != actions.length) {
        _children.add(SizedBox(
          width: 12,
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        Row(
          children: _children,
        ),
      ],
    );
  }
}
