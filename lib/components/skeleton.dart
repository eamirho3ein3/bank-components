part of bank_components;

class Skeleton extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final SkeletonSetting setting;
  Skeleton(
      {@required this.child, @required this.setting, @required this.enabled});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: setting.color,
      highlightColor: setting.highlightColor,
      direction: setting.direction,
      enabled: enabled,
      child: child,
    );
  }
}

class SkeletonSetting {
  final Color color;
  final Color highlightColor;
  final ShimmerDirection direction;

  SkeletonSetting(
      {@required this.color,
      @required this.highlightColor,
      @required this.direction});
}
