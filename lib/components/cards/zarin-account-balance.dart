part of bank_components;

class ZarinAccountBalance extends StatelessWidget {
  final ComponentAction button;
  final CustomCardTheme style;
  final String title;
  final String amount;
  final String priceUnit;
  final Function()? cardTap;

  ZarinAccountBalance({
    required this.button,
    required this.style,
    required this.title,
    required this.amount,
    required this.priceUnit,
    this.cardTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardTap,
      child: Container(
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
                  .bodyMedium!
                  .copyWith(color: style.secondaryTextColor),
            ),
          ),
          content: Row(
            // amount
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: style.secondaryTextColor),
              ),
              Text(
                ' ' + priceUnit,
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: style.secondaryTextColor),
              ),
            ],
          ),
          buttons: button.onClick == null
              ? null
              : Container(
                  padding: EdgeInsets.only(top: 24),
                  width: double.infinity,
                  child: CustomButton(
                    title: button.text,
                    size: ButtonSize.large,
                    onClick: button.onClick,
                    style: button.style,
                    rightIcon: Icons.pie_chart_outline_sharp,
                  ),
                ),
        ),
      ),
    );
  }
}
