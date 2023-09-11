part of bank_components;

class CustomCardTypeTwo extends StatelessWidget {
  final Widget header;
  final Widget title;
  final Widget subtitle;

  CustomCardTypeTwo({
    required this.header,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // header
        header,

        // title
        title,

        // subtitle
        subtitle,
      ],
    );
  }
}

class CustomCardTheme {
  final Color secondaryTextColor; // title || mobile || description color
  final Color backgroundColor; // card backgroundColor
  CustomCardTheme(
      {required this.backgroundColor, required this.secondaryTextColor});
}
