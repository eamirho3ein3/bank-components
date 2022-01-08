part of bank_components;

class CustomIconButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Function onClick;
  CustomIconButton(
      {@required this.backgroundColor,
      @required this.icon,
      @required this.onClick});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Ink(
          color: backgroundColor,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        onTap: onClick);
  }
}
