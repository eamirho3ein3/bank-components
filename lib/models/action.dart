part of bank_components;

class ComponentAction {
  final String text;
  final Function onClick;
  final CustomButtonTheme style;
  final CustomIconTheme icon;
  ComponentAction(
      {@required this.text,
      @required this.onClick,
      @required this.style,
      this.icon});
}
