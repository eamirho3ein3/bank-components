part of bank_components;

class CustomCardTypeOne extends StatelessWidget {
  final Widget header;
  final Widget content;
  final Widget buttons;
  final CustomCardTheme style;

  CustomCardTypeOne(
      {@required this.header,
      @required this.content,
      @required this.buttons,
      @required this.style});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: style.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // header
          header != null ? header : SizedBox(),

          // content
          content != null ? content : SizedBox(),

          // buttons
          buttons != null ? buttons : SizedBox(),
        ],
      ),
    );
  }
}
