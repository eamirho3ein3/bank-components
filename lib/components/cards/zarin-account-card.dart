part of bank_components;

class ZarinAccountCard extends StatelessWidget {
  final CustomCardTheme style;
  final String title;
  final String amount;
  final Function onMoreClick;
  final CustomIconTheme icon;
  final bool isSkeleton;
  final SkeletonSetting setting;

  ZarinAccountCard({
    @required this.style,
    @required this.title,
    @required this.amount,
    @required this.onMoreClick,
    @required this.icon,
    @required this.isSkeleton,
    @required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: style.backgroundColor,
      ),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * (0.56)),
      child: isSkeleton ? _buildSkeleton(context) : _buildView(context),
    );
  }

  _buildSkeleton(BuildContext context) {
    return Skeleton(
      setting: setting,
      enabled: isSkeleton,
      child: CustomCardTypeTwo(
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // account icon
            CircleAvatar(
              radius: 24,
              backgroundColor: setting.color,
            ),

            // more button
            InkWell(
              onTap: () {},
              child: Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
        title: Padding(
          //account title
          padding: const EdgeInsets.only(bottom: 8, top: 28),
          child: Container(
            width: 120,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: setting.color,
            ),
          ),
        ),
        subtitle:
            // amount
            Container(
          width: 64,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: setting.color,
          ),
        ),
      ),
    );
  }

  _buildView(BuildContext context) {
    return CustomCardTypeTwo(
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // account icon
          CustomAvatar(
            radius: 24,
            icon: icon.icon,
            iconColor: icon.iconColor,
            backgroundColor: icon.backgroundColor,
          ),

          // more button
          InkWell(
            onTap: onMoreClick,
            child: Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      title: Padding(
        //account title
        padding: const EdgeInsets.only(bottom: 8, top: 28),
        child: Text(
          title,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      subtitle:
          // amount
          RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
            text: amount,
            style: Theme.of(context).textTheme.subtitle1,
            children: <TextSpan>[
              TextSpan(
                text: ' ' + 'ریال',
                style: Theme.of(context).textTheme.caption,
              ),
            ]),
      ),
    );
  }
}
