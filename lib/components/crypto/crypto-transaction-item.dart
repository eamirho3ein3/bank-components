part of bank_components;

class CryptoTransactionItem extends StatelessWidget {
  final CustomIconTheme icon;
  final String? title;
  final String? subtitle;
  final String? price;
  final CryptoTransactionItemTheme style;
  final SkeletonSetting setting;
  final bool isSkeleton;
  final TransactionType type;
  final CryptoSymbol symbolWidget;

  final Function(BuildContext)? onClick;

  CryptoTransactionItem({
    required this.icon,
    this.title,
    this.subtitle,
    required this.style,
    this.price,
    required this.isSkeleton,
    required this.setting,
    required this.type,
    this.onClick,
    required this.symbolWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: isSkeleton ? _buildShimmer(context) : _buildView(context),
    );
  }

  _buildShimmer(BuildContext context) {
    return Skeleton(
      setting: setting,
      enabled: true,
      child: _buildView(context),
    );
  }

  _buildView(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClick != null) {
          onClick!(context);
        }
      },
      child: Row(
        children: [
          // logo
          CustomAvatar(
            radius: 24,
            icon: icon.icon,
            iconColor: icon.iconColor,
            backgroundColor: icon.backgroundColor ?? setting.color,
          ),

          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // title
                    !isSkeleton
                        ? Text(title ?? '',
                            style: Theme.of(context).textTheme.titleMedium)
                        : Container(
                            width: 120,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: setting.color,
                            ),
                          ),
                    SizedBox(
                      width: 12,
                    ),

                    !isSkeleton
                        ? Row(
                            children: [
                              // symbol
                              symbolWidget,

                              SizedBox(
                                width: 8,
                              ),

                              // price
                              Text(price ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: _getColor())),
                            ],
                          )
                        : Container(
                            width: 48,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: setting.color,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                // subtitle
                !isSkeleton
                    ? Text(subtitle ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: style.subtitleColor))
                    : Container(
                        width: 64,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: setting.color,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    if (type == TransactionType.income) {
      return style.incomeColor;
    } else {
      return style.outgoingColor;
    }
  }
}

class CryptoTransactionItemTheme extends TransactionItemTheme {
  final Color incomeColor;
  final Color outgoingColor;

  CryptoTransactionItemTheme(
      {required backgroundColor,
      required subtitleColor,
      required this.incomeColor,
      required this.outgoingColor})
      : super(
            backgroundColor: backgroundColor,
            subtitleColor: subtitleColor,
            badgeBackgroundColor: null);
}

enum TransactionType { income, outgoing }
