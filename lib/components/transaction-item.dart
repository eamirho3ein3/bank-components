part of bank_components;

class TransactionItem extends StatelessWidget {
  final CustomIconTheme icon;
  final String? title;
  final String? subtitle;
  final String? imageBadge;
  final PriceWidget priceWidget;
  final TransactionItemTheme style;
  final SkeletonSetting setting;
  final bool isSkeleton;
  final Function(BuildContext)? onClick;

  TransactionItem({
    required this.icon,
    this.title,
    this.subtitle,
    required this.style,
    required this.priceWidget,
    required this.isSkeleton,
    required this.setting,
    this.onClick,
    this.imageBadge,
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
        if (!isSkeleton && onClick != null) {
          onClick!(context);
        }
      },
      child: Row(
        children: [
          // logo
          Stack(
            children: [
              CustomAvatar(
                radius: 24,
                icon: icon.icon,
                iconColor: icon.iconColor,
                backgroundColor: icon.backgroundColor ?? setting.color,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: imageBadge != null
                    ? Container(
                        alignment: Alignment.center,
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: style.badgeBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff0000000).withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          imageBadge!,
                          height: 10,
                          width: 10,
                        ),
                      )
                    : SizedBox(),
              ),
            ],
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
                        ? Expanded(
                            child: Text(title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: Theme.of(context).textTheme.subtitle1),
                          )
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
                        ? priceWidget
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
}

class TransactionItemTheme {
  final Color backgroundColor;
  final Color subtitleColor;
  final Color? badgeBackgroundColor;

  TransactionItemTheme({
    required this.backgroundColor,
    required this.subtitleColor,
    required this.badgeBackgroundColor,
  });
}
