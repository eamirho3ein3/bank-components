part of bank_components;

class WalletItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String price;
  final WalletItemTheme style;
  final SkeletonSetting setting;
  final bool isSkeleton;
  final Function(BuildContext) onClick;
  final MarketChanges changewWidget;
  final CryptoSymbol symbolWidget;

  WalletItem({
    @required this.title,
    @required this.image,
    @required this.subtitle,
    @required this.style,
    @required this.price,
    @required this.isSkeleton,
    @required this.setting,
    this.onClick,
    @required this.changewWidget,
    @required this.symbolWidget,
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
        onClick(context);
      },
      child: Row(
        children: [
          // logo
          CircleAvatar(
            radius: 24,
            backgroundColor: image == null || image.isEmpty
                ? setting.color
                : Colors.transparent,
            child: image == null || image.isEmpty
                ? SizedBox()
                : Image.network(
                    image,
                    errorBuilder: (context, error, stackTrace) => SizedBox(),
                  ),
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
                            style: Theme.of(context).textTheme.subtitle1)
                        : Container(
                            width: 120,
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
                    ? Row(
                        children: [
                          Text(subtitle ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: style.subtitleColor)),
                          SizedBox(
                            width: 8,
                          ),
                          changewWidget,
                        ],
                      )
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

          SizedBox(
            width: 12,
          ),

          !isSkeleton
              ? Row(
                  children: [
                    // symbol
                    symbolWidget,

                    // price
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(price ?? '',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
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
    );
  }
}

class WalletItemTheme extends TransactionItemTheme {
  WalletItemTheme({@required backgroundColor, @required subtitleColor})
      : super(backgroundColor: backgroundColor, subtitleColor: subtitleColor);
}
