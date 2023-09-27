part of bank_components;

class CustomAvatar extends StatelessWidget {
  final String? image;
  final String? placeholderImage;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double radius;
  final double? iconSize;

  CustomAvatar(
      {this.image,
      this.iconSize,
      this.icon,
      this.backgroundColor,
      this.iconColor,
      required this.radius,
      this.placeholderImage});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.white,
      foregroundImage: image != null ? NetworkImage(image!) : null,
      child: placeholderImage != null
          ? Image.asset(placeholderImage!)
          : icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? Colors.grey,
                  size: iconSize ?? null,
                )
              : SizedBox(),
      onForegroundImageError: image != null
          ? (object, stackTrace) {
              print("error in avatar network image");
            }
          : null,
    );
  }
}
