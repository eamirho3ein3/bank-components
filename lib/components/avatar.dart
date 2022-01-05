part of bank_components;

class CustomAvatar extends StatelessWidget {
  final String image;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double radius;
  final double iconSize;

  CustomAvatar(
      {this.image,
      this.iconSize,
      @required this.icon,
      @required this.backgroundColor,
      @required this.iconColor,
      @required this.radius});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundImage: image != null ? NetworkImage(image) : null,
      child: icon != null
          ? Icon(
              icon,
              color: iconColor,
              size: iconSize ?? null,
            )
          : SizedBox(),
      onForegroundImageError: image != null
          ? (object, stackTrace) {
              print("stackTrace = $stackTrace");
            }
          : null,
    );
  }
}
