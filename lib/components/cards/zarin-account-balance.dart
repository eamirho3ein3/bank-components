part of bank_components;

class ZarinAccountBalance extends StatelessWidget {
  final ComponentAction button;
  final CustomCardTheme style;
  final String title;
  final String amount;

  ZarinAccountBalance({
    @required this.button,
    @required this.style,
    @required this.title,
    @required this.amount,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: style.backgroundColor,
      ),
      child: CustomCardTypeOne(
        header: Padding(
          // title
          padding: EdgeInsets.only(bottom: 24),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: style.secondaryTextColor),
          ),
        ),
        content: Row(
          // amount
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              amount + '~',
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: style.secondaryTextColor),
            ),
            Text(
              ' ' + 'ریال',
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: style.secondaryTextColor),
            ),
          ],
        ),
        buttons: CustomButton(
          title: button.text,
          size: ButtonSize.large,
          onClick: button.onClick,
          style: CustomButtonTheme(
            backgroundColor: button.style.backgroundColor,
            foregroundColor: button.style.foregroundColor,
            disabledColor: button.style.disabledColor,
          ),
          rightIcon: Icons.pie_chart_outline_sharp,
        ),
      ),
    );
  }
}
