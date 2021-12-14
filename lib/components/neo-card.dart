part of neo_components;

class NeoCard extends StatelessWidget {
  final CardType type;
  final String title; // card title & profile name
  final String amount;
  final ComponentAction rightButton;
  final ComponentAction leftButton;
  final NeoCardTheme style;

  // profile card
  final String profile;
  final String mobile;
  final ZarinId zarinId;
  final Function changeProfile;

  // zarinCard
  final List<String> cardNumbers;

  // zarrin account card
  final NeoIconTheme icon; // profile place holdeer & zarrin account icon
  final Function onMoreClick;

  // setting card
  final String description;
  final Function(bool) onToggleChange;
  final Function onCardClick;
  final ToggleTheme toggleTheme;
  final bool toggleValue;

  NeoCard(
      {@required this.type,
      this.title,
      this.amount,
      this.rightButton,
      this.leftButton,
      @required this.style,
      this.profile,
      this.mobile,
      this.changeProfile,
      this.cardNumbers,
      this.zarinId,
      this.icon,
      this.onMoreClick,
      this.description,
      this.onToggleChange,
      this.onCardClick,
      this.toggleTheme,
      this.toggleValue});
  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (type == CardType.Default ||
        type == CardType.AccountBalance ||
        type == CardType.ActiveZarinCard ||
        type == CardType.DeactiveZarinCard) {
      widget = _buildCardWidget(context);
    } else if (type == CardType.Account || type == CardType.Profile) {
      // profile & account
      widget = _buildSecondTypeWidget(context);
    } else {
      // setting
      widget = _buildThirdTypeWidget(context);
    }
    return widget;
  }

  _buildCardWidget(BuildContext context) {
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
          // title
          Padding(
            padding: EdgeInsets.only(
                bottom: 24,
                top: type == CardType.DeactiveZarinCard ||
                        type == CardType.ActiveZarinCard
                    ? 4
                    : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                type == CardType.AccountBalance || type == CardType.Default
                    ? Text(
                        title,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: style.secondaryTextColor),
                      )
                    : SizedBox(),
                type == CardType.DeactiveZarinCard ||
                        type == CardType.ActiveZarinCard
                    ? Expanded(
                        child: SvgPicture.asset(
                          'svgs/zarrin-logo-type.svg',
                          height: 28,
                          width: 92,
                          alignment: Alignment.centerRight,
                        ),
                      )
                    : SizedBox(),
                type == CardType.DeactiveZarinCard ||
                        type == CardType.ActiveZarinCard
                    ? SvgPicture.asset(
                        'svgs/circuit.svg',
                        color: type == CardType.ActiveZarinCard
                            ? Colors.red
                            : Colors.black,
                        height: 40,
                        width: 49,
                      )
                    : SizedBox(),
              ],
            ),
          ),

          // amount
          amount != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      amount + (type == CardType.AccountBalance ? '~' : ''),
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: type == CardType.AccountBalance
                              ? style.secondaryTextColor
                              : null),
                    ),
                    Text(
                      ' ' + 'ریال',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: type == CardType.AccountBalance
                              ? style.secondaryTextColor
                              : null),
                    ),
                  ],
                )
              : //card number
              _buildCardNumberText(context),

          // buttons
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                rightButton != null
                    ? Expanded(
                        child: NeoButton(
                          title: rightButton.text,
                          size: ButtonSize.large,
                          onClick: rightButton.onClick,
                          style: NeoButtonTheme(
                            backgroundColor: rightButton.style.backgroundColor,
                            foregroundColor: rightButton.style.foregroundColor,
                            disabledColor: rightButton.style.disabledColor,
                          ),
                          rightIcon: Icons.pie_chart_outline_sharp,
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: leftButton != null ? 12 : 0,
                ),
                leftButton != null
                    ? Expanded(
                        child: NeoButton(
                          title: leftButton.text,
                          size: ButtonSize.large,
                          onClick: rightButton.onClick,
                          style: NeoButtonTheme(
                            backgroundColor: leftButton.style.backgroundColor,
                            foregroundColor: leftButton.style.foregroundColor,
                            disabledColor: leftButton.style.disabledColor,
                          ),
                          rightIcon: Icons.pie_chart_outline_sharp,
                        ),
                      )
                    : SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildSecondTypeWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: style.backgroundColor,
      ),
      constraints: type == CardType.Account
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * (0.56))
          : BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: type == CardType.Profile
                ? [
                    // profile photo
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          foregroundImage: NetworkImage(profile),
                          child: Icon(
                            icon.icon,
                            color: icon.iconColor,
                          ),
                          backgroundColor: icon.backgroundColor,
                        ),
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 14,
                                foregroundImage: NetworkImage(''),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                ),
                              ),
                            ))
                      ],
                    ),

                    zarinId != null ? zarinId : SizedBox(),
                  ]
                : [
                    // acount icon
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
                        child: Icon(Icons.more_horiz_rounded))
                  ],
          ),

          //profile name
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 28),
            child: Text(
              title,
              textAlign: TextAlign.end,
              style: type == CardType.Profile
                  ? Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: style.secondaryTextColor)
                  : Theme.of(context).textTheme.bodyText2,
            ),
          ),

          // profile mobile
          Text(
            type == CardType.Profile ? mobile : amount,
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: style.secondaryTextColor),
          ),
        ],
      ),
    );
  }

  _buildThirdTypeWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: style.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Icon(
                icon.icon,
                color: icon.iconColor,
              ),

              // toggle button or arrow icon
              toggleValue != null
                  ? NeoToggle(
                      style: toggleTheme,
                      onToggle: onToggleChange,
                      value: toggleValue,
                    )
                  : Icon(Icons.chevron_right_rounded)
            ],
          ),

          //title
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              title,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          // description
          description != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    description,
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: style.secondaryTextColor),
                  ),
                )
              : SizedBox(),
        ],
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

class NeoCardTheme {
  final Color secondaryTextColor; // title || mobile || description color
  final Color backgroundColor; // card backgroundColor
  NeoCardTheme(
      {@required this.backgroundColor, @required this.secondaryTextColor});
}

enum CardType {
  Default, // zarinCard balance card
  Account, // zarinAccount card
  AccountBalance, // zarinAccount balance card
  ActiveZarinCard, // active zarinCard
  DeactiveZarinCard, // deactive zarinCard
  Profile, // user profile card
  Setting, // setting card
}
