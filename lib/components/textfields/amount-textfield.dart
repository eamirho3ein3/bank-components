part of bank_components;

class AmountTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Color secondaryTextColor;
  final Function(String) onChanged;

  AmountTextField({
    @required this.controller,
    @required this.focusNode,
    @required this.secondaryTextColor,
    this.onChanged,
  });

  @override
  _AmountTextFieldState createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  String _input = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        border: Border.all(
            color: widget.focusNode.hasFocus
                ? Theme.of(context)
                    .inputDecorationTheme
                    .focusedBorder
                    .borderSide
                    .color
                : Theme.of(context)
                    .inputDecorationTheme
                    .enabledBorder
                    .borderSide
                    .color,
            width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The widget as shown by user's input
          _buildAmountItem(_input),

          // hiden textfield
          Opacity(
            opacity: 0.0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: MainTextField(
                type: TextfieldType.Reqular,
                controller: widget.controller,
                focusNode: widget.focusNode,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                ],
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _input = value;
                  widget.controller.text = value;
                  if (widget.onChanged != null) {
                    widget.onChanged(_input);
                  }
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAmountItem(String inputCode) {
    String _text = replaceFarsiNumber(
        addCommasToPrice(inputCode.length != 0 ? inputCode : '0'));
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _text,
            style: Theme.of(context).textTheme.headline1.copyWith(
                color:
                    inputCode.length != 0 ? null : widget.secondaryTextColor),
          ),
          Text(
            'ریال',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: widget.secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
