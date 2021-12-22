part of bank_components;

class ZarinCardBalance extends StatelessWidget {
  final ComponentAction rightButton;
  final ComponentAction leftButton;
  final CustomCardTheme style;
  final String title;
  final String amount;
  final bool isSkeleton;
  final SkeletonSetting setting;

  ZarinCardBalance({
    @required this.rightButton,
    @required this.leftButton,
    @required this.style,
    @required this.title,
    @required this.amount,
    @required this.isSkeleton,
    @required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardTypeOne(
      header: Padding(
        // title
        padding: EdgeInsets.only(bottom: 24),
        child: isSkeleton
            ? Skeleton(
                setting: setting,
                child: Container(
                  width: 104,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: setting.color,
                  ),
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: style.secondaryTextColor),
              ),
      ),
      content: Row(
        // amount
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isSkeleton
              ? Skeleton(
                  setting: setting,
                  child: Container(
                    width: 176,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: setting.color,
                    ),
                  ),
                )
              : Text(
                  amount,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline1,
                ),
          isSkeleton
              ? Skeleton(
                  setting: setting,
                  child: Container(
                    width: 40,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: setting.color,
                    ),
                  ),
                )
              : Text(
                  ' ' + 'ریال',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
        ],
      ),
      buttons: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Row(
          children: [
            rightButton != null
                ? Expanded(
                    child: CustomButton(
                      title: rightButton.text,
                      size: ButtonSize.large,
                      onClick: rightButton.onClick,
                      style: CustomButtonTheme(
                        backgroundColor: rightButton.style.backgroundColor,
                        foregroundColor: rightButton.style.foregroundColor,
                        disabledColor: rightButton.style.disabledColor,
                      ),
                      rightIcon: Icons.pie_chart_outline_sharp,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: leftButton != null ? 12 : 0,
            ),
            leftButton != null
                ? Expanded(
                    child: CustomButton(
                      title: leftButton.text,
                      size: ButtonSize.large,
                      onClick: rightButton.onClick,
                      style: CustomButtonTheme(
                        backgroundColor: leftButton.style.backgroundColor,
                        foregroundColor: leftButton.style.foregroundColor,
                        disabledColor: leftButton.style.disabledColor,
                      ),
                      rightIcon: Icons.pie_chart_outline_sharp,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
      style: style,
    );
  }
}
