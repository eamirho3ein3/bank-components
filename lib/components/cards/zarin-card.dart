part of bank_components;

class ZarinCard extends StatelessWidget {
  final ComponentAction button;
  final ZarinCardTheme style;
  final List<String> cardNumbers;
  final bool isActive;

  ZarinCard({
    @required this.button,
    @required this.style,
    @required this.cardNumbers,
    @required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? style.backgroundColor : style.deactiveBackgroundColor,
      ),
      child: CustomCardTypeOne(
        header: Padding(
          padding: EdgeInsets.only(bottom: 24, top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  'assets/svgs/zarrin-logo-type.svg',
                  height: 28,
                  width: 92,
                  alignment: Alignment.centerRight,
                ),
              ),
              SvgPicture.asset(
                'assets/svgs/circuit.svg',
                color: isActive ? Colors.red : Colors.black,
                height: 40,
                width: 49,
              ),
            ],
          ),
        ),
        content: //card number
            _buildCardNumberText(context),
        buttons: Container(
          width: double.infinity,
          child: CustomButton(
            title: button.text,
            size: ButtonSize.large,
            onClick: button.onClick,
            style: CustomButtonTheme(
              backgroundColor: button.style.backgroundColor,
              foregroundColor: button.style.foregroundColor,
              disabledColor: button.style.disabledColor,
              foregroundDisabledColor: button.style.foregroundDisabledColor,
            ),
            rightIcon: button.icon.icon,
          ),
        ),
      ),
    );
  }

  _buildCardNumberText(BuildContext context) {
    List<Widget> _children = [];
    for (var item in cardNumbers) {
      var widget = Text(
        item,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2.copyWith(
            fontWeight: FontWeight.w700, color: style.secondaryTextColor),
      );
      _children.add(widget);
    }

    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _children,
        ),
      ),
    );
  }
}

class ZarinCardTheme extends CustomCardTheme {
  final Color deactiveBackgroundColor;

  ZarinCardTheme({@required this.deactiveBackgroundColor});
}
