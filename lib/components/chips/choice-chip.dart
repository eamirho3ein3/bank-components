part of bank_components;

class CustomChoiceChip extends StatelessWidget {
  final ChipType type;
  final String title;
  final String? numbers;
  final IconData? icon;
  final Function()? onClick;
  final Function()? onClose;
  final bool selected;
  final bool isSkeleton;
  final SkeletonSetting setting;
  final Color? titleColor;

  CustomChoiceChip(
      {required this.title,
      this.numbers,
      this.icon,
      this.onClick,
      this.titleColor,
      required this.selected,
      required this.type,
      this.onClose,
      required this.isSkeleton,
      required this.setting});
  @override
  Widget build(BuildContext context) {
    return isSkeleton ? _buildSkeletonView(context) : _buildChip(context);
  }

  _buildChip(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (numbers != null ? (numbers! + " ") : '') + title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: selected ? Theme.of(context).primaryColor : titleColor),
          ),
          selected && type == ChipType.Action
              ? InkWell(
                  onTap: onClose,
                  child: CustomAvatar(
                    radius: 12,
                    icon: Icons.close,
                    iconColor: Theme.of(context).chipTheme.backgroundColor ??
                        Colors.black,
                    backgroundColor: Theme.of(context).primaryColor,
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
        if (value && onClick != null) {
          onClick!();
        }
      },
      elevation: 0,
      selectedColor: Theme.of(context).chipTheme.selectedColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
              color: selected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).dividerColor,
              width: 1)),
      padding: EdgeInsets.all(0),
      labelPadding: EdgeInsets.only(
          left: numbers != null ? 4 : 12,
          top: 2,
          bottom: 2,
          right: icon != null ? 4 : 12),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  _buildSkeletonView(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1),
      ),
      child: Skeleton(
        setting: setting,
        enabled: isSkeleton,
        child: Container(
          width: 87,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: setting.color,
          ),
        ),
      ),
    );
  }
}

enum ChipType { Action, Filter }
