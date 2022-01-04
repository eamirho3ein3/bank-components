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
  ContactItem({
    this.icon,
    this.image,
    this.subtitle,
    this.subtitleImage,
    this.button,
    this.suffixImage,
    @required this.style,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // logo
          CircleAvatar(
            radius: 24,
            backgroundColor: style.logoBackgroundColor,
            child: icon != null
                ? Icon(
                    icon,
                    color: style.logoColor,
                  )
                : Container(),
            foregroundImage: image != null ? NetworkImage(image) : null,
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
                      style: CustomButtonTheme(
                        backgroundColor: button.style.backgroundColor,
                        foregroundColor: button.style.foregroundColor,
                        disabledColor: button.style.disabledColor,
                        foregroundDisabledColor:
                            button.style.foregroundDisabledColor,
                      ),
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
