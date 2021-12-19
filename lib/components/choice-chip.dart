part of bank_components;

class CustomChoiceChip extends StatelessWidget {
  final String title;
  final String numbers;
  final IconData icon;
  final Function(bool) onClick;
  final bool selected;
  CustomChoiceChip(
      {this.title,
      this.numbers,
      this.icon,
      this.onClick,
      @required this.selected});
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: selected ? Theme.of(context).primaryColor : null),
          ),
          numbers != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 12,
                    child: Center(
                      child: Text(numbers,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Theme.of(context)
                                  .chipTheme
                                  .secondarySelectedColor)),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
      selected: selected,
      avatar: Icon(
        icon,
        color: selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).iconTheme.color,
        size: 24,
      ),
      backgroundColor: Theme.of(context).chipTheme.backgroundColor,
      onSelected: onClick,
      elevation: 0,
      selectedColor: Theme.of(context).chipTheme.selectedColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: selected
              ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
              : BorderSide.none),
      padding: EdgeInsets.all(0),
      labelPadding:
          EdgeInsets.only(left: numbers != null ? 4 : 12, top: 2, bottom: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
