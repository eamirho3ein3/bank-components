part of bank_components;

class SettingCard extends StatelessWidget {
  final CustomCardTheme style;
  final String title;
  final String description;
  final bool toggleValue;
  final CustomIconTheme icon;
  final Function(bool) onToggleChange;
  final Function onClick;
  final ToggleTheme toggleTheme;

  SettingCard({
    @required this.style,
    @required this.title,
    @required this.description,
    @required this.toggleValue,
    @required this.icon,
    @required this.onToggleChange,
    @required this.toggleTheme,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: style.backgroundColor,
      ),
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // icon
                Icon(
                  icon.icon,
                  color: icon.iconColor,
                ),

                // toggle button or arrow icon
                toggleValue != null
                    ? CustomToggle(
                        style: toggleTheme,
                        onToggle: onToggleChange,
                        value: toggleValue,
                      )
                    : Icon(Icons.chevron_right_rounded)
              ],
            ),

            //title
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),

            // description
            description != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      description,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: style.secondaryTextColor),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
