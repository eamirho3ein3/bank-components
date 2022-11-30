part of bank_components;

class ComponentAction {
  final String text;
  final Function onClick;
  final CustomButtonTheme style;
  final CustomIconTheme icon;
  final bool isLoading;
  ComponentAction({
    @required this.text,
    this.onClick,
    @required this.style,
    this.icon,
    this.isLoading,
  });
}
