part of bank_components;

class ProfileCard extends StatelessWidget {
  final CustomCardTheme style;
  final String title;
  final String profileImage;
  final String mobile;
  final Function changeProfileImage;
  final CustomAvatar avatar;
  final ComponentAction button;

  ProfileCard({
    @required this.style,
    @required this.title,
    @required this.profileImage,
    @required this.mobile,
    @required this.avatar,
    @required this.changeProfileImage,
    @required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: style.backgroundColor,
      ),
      child: CustomCardTypeOne(
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                // profile photo
                avatar,

                // change button
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: changeProfileImage,
                    child: CircleAvatar(
                      radius: 14,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 24,
            ),
            Column(
              children: [
                Padding(
                  //profile name
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    title,
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: style.secondaryTextColor),
                  ),
                ),

                // profile mobile
                Text(
                  mobile,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: style.secondaryTextColor),
                )
              ],
            ),
          ],
        ),
        content: null,
        buttons: Container(
          margin: EdgeInsets.only(top: 32),
          width: double.infinity,
          child: CustomButton(
            title: button.text,
            size: ButtonSize.large,
            onClick: button.onClick,
            style: CustomButtonTheme(
              backgroundColor: button.style.backgroundColor,
              foregroundColor: button.style.foregroundColor,
              disabledColor: button.style.disabledColor,
              foregroundDisabledColor: button.style.foregroundDisabledColor,
            ),
            rightIcon: button.icon.icon,
          ),
        ),
      ),
    );
  }
}
