part of bank_components;

class AddressItem extends StatelessWidget {
  final String title;
  final String address;
  final String code;
  final IconData icon;
  final AddressItemTheme style;
  final bool isSkeleton;
  final SkeletonSetting setting;
  final List<SlidableAction> actions;

  AddressItem({
    @required this.title,
    @required this.address,
    @required this.code,
    @required this.icon,
    @required this.style,
    @required this.isSkeleton,
    @required this.setting,
    @required this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return isSkeleton ? _buildSkeleton(context) : _buildView(context);
  }

  _buildSkeleton(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Skeleton(
        setting: setting,
        enabled: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // icon
            CircleAvatar(
              radius: 24,
              backgroundColor: setting.color,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Container(
                    margin: EdgeInsets.only(bottom: 6),
                    width: size.width * 100 / 340,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: setting.color,
                    ),
                  ),

                  // address + code
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
          ],
        ),
      ),
    );
  }

  _buildView(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      closeOnScroll: true,
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: actions,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // icon
            CircleAvatar(
              radius: 24,
              backgroundColor: style.iconBackgroundColor,
              child: Icon(
                icon,
                color: style.iconColor,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ),

                  // address + code
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(address + ' -  کدپستی: ' + code,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: style.addressColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressItemTheme {
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color addressColor;
  AddressItemTheme(
      {@required this.backgroundColor,
      @required this.addressColor,
      @required this.iconColor,
      @required this.iconBackgroundColor});
}
