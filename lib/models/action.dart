part of bank_components;

class ComponentAction {
  final String text;
  final Function onClick;
  final CustomButtonTheme style;
  ComponentAction({@required this.text, @required this.onClick, this.style});
}
