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
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
          icon: Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: onClick),
    );
  }
}
