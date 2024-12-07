part of bank_components;

class ZarinCardBalance extends StatelessWidget {
  final Widget? rightButton;
  final Widget? leftButton;
  final CustomCardTheme style;
  final String title;
  final Widget? titleIcon;
  final String? subtitle;
  final String? lastUpdate;
  final String amount;
  final String? currency;
  final bool isSkeleton;
  final SkeletonSetting setting;
  final Widget? leadingTitleIcon;
  final TooltipSetting? tooltipSetting;

  ZarinCardBalance({
    this.rightButton,
    this.leftButton,
    required this.style,
    required this.title,
    this.titleIcon,
    this.currency,
    this.subtitle,
    this.lastUpdate,
    required this.amount,
    required this.isSkeleton,
    required this.setting,
    this.leadingTitleIcon,
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
                .bodyMedium!
                .copyWith(color: style.secondaryTextColor),
          ),
        ),
        content: Row(
          // amount
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 6.5),
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
                      child: IgnorePointer(
                        child: rightButton!,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: leftButton != null ? 12 : 0,
              ),
              leftButton != null
                  ? Expanded(
                      child: IgnorePointer(
                        child: leftButton!,
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
            Row(
              children: [
                leadingTitleIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(left: 8, top: 2),
                        child: leadingTitleIcon!,
                      )
                    : SizedBox(),
                Expanded(
                  child: Text(title,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                titleIcon != null || lastUpdate != null
                    ? Row(
                        children: [
                          lastUpdate != null
                              ? Text(
                                  lastUpdate!,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: style.secondaryTextColor),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: lastUpdate != null ? 4 : 0,
                          ),
                          titleIcon != null ? titleIcon! : SizedBox(),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
            // subtitle
            subtitle != null
                ? Text(
                    subtitle!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
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
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            currency ?? ' ' + 'ریال',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyLarge,
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
                      child: rightButton!,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: leftButton != null ? 12 : 0,
            ),
            leftButton != null ? leftButton! : SizedBox()
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
