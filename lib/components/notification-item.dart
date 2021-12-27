part of bank_components;

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String image;
  final String title;
  final String description;
  final String date;
  final NotificationItemTheme style;
  final bool isSkeleton;
  final SkeletonSetting setting;

  NotificationItem({
    this.icon,
    this.image,
    this.description,
    @required this.style,
    @required this.title,
    @required this.date,
    @required this.isSkeleton,
    @required this.setting,
  });
  @override
  Widget build(BuildContext context) {
    return isSkeleton ? _buildSkeleton(context) : _buildView(context);
  }

  _buildSkeleton(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.all(16),
      child: Skeleton(
        setting: setting,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6),
              width: size.width * 160 / 340,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: setting.color,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 6),
              width: size.width * 260 / 340,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: setting.color,
              ),
            ),
            Container(
              width: size.width * 120 / 340,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: setting.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildView(BuildContext context) {
    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // image
          image != null
              ? Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    image,
                    height: 176,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, exception, stackTrace) {
                      return Image.asset('assets/images/image-empty.png');
                    },
                  ),
                )
              : SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              icon != null
                  ? Icon(
                      icon,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : Container(),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),

                    // description
                    description != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(description,
                                style: Theme.of(context).textTheme.subtitle1),
                          )
                        : SizedBox(),

                    // date
                    Text(date,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: style.secondaryColor)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationItemTheme {
  final Color secondaryColor;
  final Color backgroundColor;

  NotificationItemTheme(
      {@required this.secondaryColor, @required this.backgroundColor});
}
