part of bank_components;

class CustomChoiceChip extends StatelessWidget {
  final ChipType type;
  final String title;
  final String numbers;
  final IconData icon;
  final Function onClick;
  final Function onClose;
  final bool selected;

  CustomChoiceChip(
      {@required this.title,
      this.numbers,
      this.icon,
      this.onClick,
      @required this.selected,
      @required this.type,
      this.onClose});
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (numbers != null ? numbers + " " : '') + title,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: selected ? Theme.of(context).primaryColor : null),
          ),
          selected && type == ChipType.Action
              ? InkWell(
                  onTap: onClose,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 12,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).chipTheme.backgroundColor,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
      selected: selected,
      avatar: icon != null
          ? Icon(
              icon,
              color: selected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
              size: 24,
            )
          : null,
      backgroundColor: Theme.of(context).chipTheme.backgroundColor,
      onSelected: (value) {
        if (value) {
          onClick();
        }
      },
      elevation: 0,
      selectedColor: Theme.of(context).chipTheme.selectedColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: selected
              ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
              : BorderSide.none),
      padding: EdgeInsets.all(0),
      labelPadding: EdgeInsets.only(
          left: numbers != null ? 4 : 12,
          top: 2,
          bottom: 2,
          right: icon != null ? 4 : 12),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

enum ChipType { Action, Filter }
