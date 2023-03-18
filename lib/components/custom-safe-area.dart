part of bank_components;

class CustomSafeArea extends SafeArea {
  final Widget child;

  CustomSafeArea({@required this.child})
      : super(
          bottom: false,
          child: child,
          minimum: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
        );
}
