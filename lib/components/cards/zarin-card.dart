part of bank_components;

class ZarinCard extends StatelessWidget {
  final ComponentAction button;
  final ZarinCardTheme style;
  final String backgroundImage;
  final List<String> cardNumbers;
  final bool isActive;

  ZarinCard({
    this.button,
    @required this.style,
    this.cardNumbers,
    @required this.isActive,
    @required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        alignment: Alignment.center,
        // padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: style.borderColor),
          color:
              isActive ? style.backgroundColor : style.deactiveBackgroundColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              backgroundImage,
              height: constraints.maxWidth / 1.65,
              width: constraints.maxWidth,
              fit: BoxFit.fitWidth,
            ),
            button != null
                ? Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Container(
                      width: double.infinity,
                      child: CustomButton(
                        title: button.text,
                        size: ButtonSize.large,
                        onClick: button.onClick,
                        style: button.style,
                        rightIcon: button.icon.icon,
                      ),
                    ))
                : SizedBox(),
            // CustomCardTypeOne(
            //   header: SizedBox(
            //     height: 28,
            //   ),
            //   // Padding(
            //   //   padding: EdgeInsets.only(bottom: 24, top: 4),
            //   //   child: Row(
            //   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   //     children: [
            //   //       Expanded(
            //   //         child: SvgPicture.asset(
            //   //           'assets/svgs/zarrin-logo-type.svg',
            //   //           height: 28,
            //   //           width: 92,
            //   //           alignment: Alignment.centerRight,
            //   //         ),
            //   //       ),
            //   //       SvgPicture.asset(
            //   //         'assets/svgs/circuit.svg',
            //   //         color: isActive ? Colors.red : Colors.black,
            //   //         height: 40,
            //   //         width: 49,
            //   //       ),
            //   //     ],
            //   //   ),
            //   // ),
            //   content: //card number
            //       _buildCardNumberText(context),
            //   buttons: Container(
            //     width: double.infinity,
            //     child: CustomButton(
            //       title: button.text,
            //       size: ButtonSize.large,
            //       onClick: button.onClick,
            //       style: button.style,
            //       rightIcon: button.icon.icon,
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  _buildCardNumberText(BuildContext context) {
    if (cardNumbers == null) {
      return SizedBox(
        height: 28,
      );
    }
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
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _children,
        ),
      ),
    );
  }
}

class ZarinCardTheme extends CustomCardTheme {
  final Color deactiveBackgroundColor;
  final Color borderColor;

  ZarinCardTheme(
      {@required this.deactiveBackgroundColor,
      @required this.borderColor,
      @required backgroundColor,
      @required secondaryTextColor})
      : super(
            backgroundColor: backgroundColor,
            secondaryTextColor: secondaryTextColor);
}
