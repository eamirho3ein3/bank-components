part of bank_components;

class ProfileCard extends StatelessWidget {
  final CustomCardTheme style;
  final String title;
  final String profileImage;
  final String mobile;
  final ZarinId zarinId;
  final Function changeProfileImage;
  final CustomIconTheme icon;

  ProfileCard({
    @required this.style,
    @required this.title,
    @required this.profileImage,
    @required this.mobile,
    @required this.zarinId,
    @required this.icon,
    @required this.changeProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardTypeTwo(
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              // profile photo
              CircleAvatar(
                radius: 40,
                foregroundImage: NetworkImage(profileImage),
                child: Icon(
                  icon.icon,
                  color: icon.iconColor,
                ),
                backgroundColor: icon.backgroundColor,
              ),

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

          // zarin id
          zarinId != null ? zarinId : SizedBox(),
        ],
      ),
      title: Padding(
        //profile name
        padding: const EdgeInsets.only(bottom: 8, top: 28),
        child: Text(
          title,
          textAlign: TextAlign.end,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: style.secondaryTextColor),
        ),
      ),
      subtitle:
          // profile mobile
          Text(
        mobile,
        textAlign: TextAlign.end,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: style.secondaryTextColor),
      ),
      style: style,
    );
  }
}
