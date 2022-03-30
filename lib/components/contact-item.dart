part of bank_components;

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String image;
  final String title;
  final String subtitle;
  final String subtitleImage;
  final String suffixImage;
  final ComponentAction button;
  final ContactItemTheme style;
  final bool isSkeleton;
  final SkeletonSetting setting;

  ContactItem({
    this.icon,
    this.image,
    this.subtitle,
    this.subtitleImage,
    this.button,
    this.suffixImage,
    @required this.style,
    @required this.title,
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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Skeleton(
        setting: setting,
        enabled: true,
        child: Row(
          children: [
            // logo
            CustomAvatar(
              radius: 24,
              icon: icon,
              iconColor: style.logoColor,
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
                    width: size.width * 104 / 340,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: setting.color,
                    ),
                  ),
                  SizedBox(
                    height: subtitle != null ? 6 : 0,
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 6),
                    width: size.width * 144 / 340,
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
    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // logo
          CustomAvatar(
            radius: 24,
            icon: icon,
            iconColor: style.logoColor,
            backgroundColor: style.logoBackgroundColor,
            image: image,
          ),

          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(title, style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: subtitle != null ? 6 : 0,
                ),

                subtitle != null
                    ? Row(
                        children: [
                          // subtitle
                          Text(subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: style.subtitleColor)),
                          SizedBox(
                            width: subtitleImage != null ? 8 : 0,
                          ),

                          // subtitle image
                          subtitleImage != null
                              ? SvgPicture.asset(
                                  subtitleImage,
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.contain,
                                )
                              : SizedBox(),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          suffixImage != null
              // suffix image
              ? SvgPicture.asset(
                  suffixImage,
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                )

              // button
              : button != null
                  ? CustomButton(
                      title: button.text,
                      size: ButtonSize.medium,
                      onClick: button.onClick,
                      style: button.style,
                    )
                  : SizedBox(),
        ],
      ),
    );
  }
}

class ContactItemTheme {
  final Color backgroundColor;
  final Color logoColor;
  final Color logoBackgroundColor;
  final Color subtitleColor;

  ContactItemTheme({
    @required this.backgroundColor,
    @required this.logoColor,
    @required this.logoBackgroundColor,
    @required this.subtitleColor,
  });
}
