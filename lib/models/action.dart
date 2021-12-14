part of components;

class ComponentAction {
  final String text;
  final Function onClick;
  final NeoButtonTheme style;
  ComponentAction({@required this.text, @required this.onClick, this.style});
}
