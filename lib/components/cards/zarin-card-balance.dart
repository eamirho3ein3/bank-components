part of bank_components;

class ZarinCardBalance extends StatelessWidget {
  final ComponentAction? rightButton;
  final ComponentAction? leftButton;
  final CustomCardTheme style;
  final String title;
  final String? subtitle;
  final String amount;
  final String? currency;
  final bool isSkeleton;
  final SkeletonSetting setting;
  final TooltipSetting? tooltipSetting;

  ZarinCardBalance({
    this.rightButton,
    this.leftButton,
    required this.style,
    required this.title,
    this.currency,
    this.subtitle,
    required this.amount,
    required this.isSkeleton,
    required this.setting,
    this.tooltipSetting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: style.backgroundColor,
      ),
      child: isSkeleton ? _buildSkeleton(context) : _buildView(context),
    );
  }

  _buildSkeleton(BuildContext context) {
    return Skeleton(
      setting: setting,
      enabled: isSkeleton,
      child: CustomCardTypeOne(
        header: Padding(
          // title
          padding: EdgeInsets.only(bottom: 24),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: style.secondaryTextColor),
          ),
        ),
        content: Row(
          // amount
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 176,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: setting.color,
              ),
            ),
            Container(
              width: 40,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: setting.color,
              ),
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
                        title: rightButton!.text,
                        size: ButtonSize.large,
                        onClick: () {},
                        style: rightButton!.style,
                        rightIcon: rightButton!.icon?.icon,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: leftButton != null ? 12 : 0,
              ),
              leftButton != null
                  ? Expanded(
                      child: CustomButton(
                        title: leftButton!.text,
                        size: ButtonSize.large,
                        onClick: () {},
                        style: leftButton!.style,
                        rightIcon: leftButton!.icon?.icon,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  _buildView(BuildContext context) {
    return CustomCardTypeOne(
      header: Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Text(title,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText2),

            // subtitle
            subtitle != null
                ? Text(
                    subtitle!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: style.secondaryTextColor),
                  )
                : SizedBox(),
          ],
        ),
      ),
      content: Row(
        // amount
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            currency ?? ' ' + 'ریال',
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
                    child: _buildRightButton(
                      child: CustomButton(
                        title: rightButton!.text,
                        size: ButtonSize.large,
                        onClick: rightButton!.onClick,
                        style: rightButton!.style,
                        rightIcon: rightButton!.icon?.icon,
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: leftButton != null ? 12 : 0,
            ),
            leftButton != null
                ? Expanded(
                    child: CustomButton(
                      title: leftButton!.text,
                      size: ButtonSize.large,
                      onClick: leftButton!.onClick,
                      style: leftButton!.style,
                      rightIcon: leftButton!.icon?.icon,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  _buildRightButton({required Widget child}) {
    return tooltipSetting != null
        ? CustomTooltip(
            setting: tooltipSetting!,
            child: child,
          )
        : child;
  }
}
