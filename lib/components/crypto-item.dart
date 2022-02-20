part of bank_components;

class CryptoItem extends StatelessWidget {
  final CustomIconTheme icon;
  final String title;
  final String subtitle;
  final String price;
  final CryptoItemTheme style;
  final SkeletonSetting setting;
  final bool isSkeleton;
  final Function(BuildContext) onClick;

  CryptoItem({
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    @required this.style,
    @required this.price,
    @required this.isSkeleton,
    @required this.setting,
    this.onClick,
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
                            style: Theme.of(context).textTheme.subtitle1)
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
                    // price
                    !isSkeleton
                        ? Expanded(
                            child: Text(price ?? '',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.subtitle1),
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
                            .caption
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
}

class CryptoItemTheme extends TransactionItemTheme {
  CryptoItemTheme({@required backgroundColor, @required subtitleColor})
      : super(backgroundColor: backgroundColor, subtitleColor: subtitleColor);
}
