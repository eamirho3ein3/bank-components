part of bank_components;

class ProfileSettingItem extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;
  final ProfileSettingItemTheme style;
  final ToggleTheme toggleTheme;
  final Function(bool) onToggleChange;
  final bool toggleValue;
  final double size;

  ProfileSettingItem(
      {this.onTap,
      this.icon,
      @required this.style,
      this.toggleTheme,
      this.onToggleChange,
      this.toggleValue,
      this.size,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            width: 24,
            child: Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
              size: size ?? 24,
            ),
          ),
        ),
        Expanded(
          child: RawMaterialButton(
            onPressed: onTap,
            fillColor: style.backgroundColor,
            elevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightElevation: 0,
            highlightColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.fromLTRB(8, 12, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                toggleValue != null
                    ? CustomToggle(
                        style: toggleTheme,
                        onToggle: onToggleChange,
                        value: toggleValue,
                      )
                    : Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ProfileSettingItemTheme {
  final Color backgroundColor;
  ProfileSettingItemTheme({this.backgroundColor});
}
