part of bank_components;

class CoinItem extends StatelessWidget {
  final CustomIconTheme icon;
  final String? title;
  final ConinTheme style;
  final SkeletonSetting setting;
  final bool isSkeleton;
  final String symbolTitle;
  final SymbolTheme symbolTheme;
  final Function(BuildContext)? onClick;
  final CoinStatus status;
  final Widget spinner;

  CoinItem({
    required this.icon,
    this.title,
    required this.style,
    required this.isSkeleton,
    required this.setting,
    this.onClick,
    required this.symbolTitle,
    required this.symbolTheme,
    required this.status,
    required this.spinner,
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
            backgroundColor: !isSkeleton ? icon.backgroundColor : setting.color,
          ),

          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                !isSkeleton
                    ? Text(title ?? '',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: status == CoinStatus.selected
                                ? style.colorDisable
                                : null))
                    : Container(
                        width: 104,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: setting.color,
                        ),
                      ),

                // subtitle
                !isSkeleton
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: CryptoSymbol(
                          title: symbolTitle,
                          style: symbolTheme,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),

          SizedBox(
            width: 12,
          ),
          // end widget
          !isSkeleton
              ? _buildEndWidget(context)
              : Container(
                  width: 24,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: setting.color,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildEndWidget(BuildContext context) {
    switch (status) {
      case CoinStatus.selected:
        return Icon(
          style.selectedIcon,
          color: style.colorDisable,
        );
      case CoinStatus.loading:
        return spinner;
      case CoinStatus.none:
      default:
        return Icon(
          style.defaultIcon,
          color: Theme.of(context).iconTheme.color,
        );
    }
  }
}

class ConinTheme extends TransactionItemTheme {
  final IconData defaultIcon; // state none endWidget icon
  final IconData selectedIcon; // state selected endWidget icon
  final Color colorDisable;
  ConinTheme({
    @required backgroundColor,
    @required subtitleColor,
    required this.defaultIcon,
    required this.selectedIcon,
    required this.colorDisable,
  }) : super(
            backgroundColor: backgroundColor,
            subtitleColor: subtitleColor,
            badgeBackgroundColor: null);
}

enum CoinStatus {
  selected,
  none,
  loading,
}
