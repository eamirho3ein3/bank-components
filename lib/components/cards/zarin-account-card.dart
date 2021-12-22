part of bank_components;

class ZarinAccountCard extends StatelessWidget {
  final CustomCardTheme style;
  final String title;
  final String amount;
  final Function onMoreClick;
  final CustomIconTheme icon;

  ZarinAccountCard({
    @required this.style,
    @required this.title,
    @required this.amount,
    @required this.onMoreClick,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * (0.56)),
      child: CustomCardTypeTwo(
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // account icon
            CircleAvatar(
              radius: 24,
              backgroundColor: icon.backgroundColor,
              child: Icon(
                icon.icon,
                color: icon.iconColor,
              ),
            ),

            // more button
            InkWell(
              onTap: onMoreClick,
              child: Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
        title: Padding(
          //account title
          padding: const EdgeInsets.only(bottom: 8, top: 28),
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        subtitle:
            // amount
            RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
              text: amount,
              style: Theme.of(context).textTheme.subtitle1,
              children: <TextSpan>[
                TextSpan(
                  text: ' ' + 'ریال',
                  style: Theme.of(context).textTheme.caption,
                ),
              ]),
        ),
        style: null,
      ),
    );
  }
}
