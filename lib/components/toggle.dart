part of bank_components;

class CustomToggle extends StatelessWidget {
  final String? title;
  final ToggleTheme style;
  final Function(bool)? onToggle;
  final bool value;
  final bool? rightText;
  CustomToggle(
      {this.title,
      required this.style,
      this.onToggle,
      this.rightText,
      required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        rightText != null && rightText!
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: onToggle == null ? style.textColorDisabled : null),
                ),
              )
            : SizedBox(),
        SizedBox(
          height: 24,
          width: 40,
          child: Transform.scale(
            scale: 0.75,
            child: CupertinoSwitch(
              trackColor: style.trackColor,
              activeColor: style.activeColor,
              thumbColor: style.thumbColor,
              value: value,
              onChanged: onToggle,
            ),
          ),
        ),
        rightText != null && !rightText!
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: onToggle == null ? style.textColorDisabled : null),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class ToggleTheme {
  final Color? trackColor;
  final Color? activeColor;
  final Color? textColor;
  final Color? textColorDisabled;
  final Color? thumbColor;

  ToggleTheme(
      {this.trackColor,
      this.activeColor,
      this.textColorDisabled,
      this.thumbColor,
      this.textColor});
}
