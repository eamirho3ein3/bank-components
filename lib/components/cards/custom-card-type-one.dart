part of bank_components;

class CustomCardTypeOne extends StatelessWidget {
  final Widget? header;
  final Widget? content;
  final Widget? buttons;

  CustomCardTypeOne({
    this.header,
    this.content,
    this.buttons,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // header
        header ?? SizedBox(),

        // content
        content ?? SizedBox(),

        // buttons
        buttons ?? SizedBox(),
      ],
    );
  }
}
