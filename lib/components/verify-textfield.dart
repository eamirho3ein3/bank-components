part of bank_components;

class CustomTextfield extends StatefulWidget {
  final TextfieldType type;
  final Function(String) onComplete;
  final Function(String) onValueChanged;
  final TextEditingController controller;
  final Color
      secondaryTextColor; // text color for unit text in amount textfield

  CustomTextfield(
      {this.onComplete,
      this.onValueChanged,
      @required this.controller,
      @required this.type,
      this.secondaryTextColor});

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String _input = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        border: Border.all(
            color: _focusNode.hasFocus
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
          // The widget that shows user's inputs
          widget.type == TextfieldType.Code
              ? _buildNumberItem(_input)
              : _buildAmountItem(_input),

          // hiden textfield
          Opacity(
            opacity: 0.0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                // only digits
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                ],
                keyboardType: TextInputType.number,
                focusNode: _focusNode,
                controller: _controller,
                maxLength: widget.type == TextfieldType.Code ? 6 : null,
                onTap: () {
                  setState(() {});
                },
                onChanged: (String value) {
                  _input = value;

                  if (widget.onValueChanged != null) {
                    widget.onValueChanged(_input);
                  }

                  // used only in code mode
                  if (widget.type == TextfieldType.Code && _input.length == 6) {
                    _focusNode.unfocus();
                    if (widget.onComplete != null) {
                      widget.onComplete(_input);
                    }
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

  _buildNumberItem(String inputCode) {
    List<Widget> _cells = [];
    for (int i = 0; i < 6; i++) {
      String _text = '';
      // the display text
      if (i < inputCode.length) {
        _text = inputCode.substring(i, i + 1);
      } else {
        _text = "-";
      }

      _cells.add(Text(
        _text,
        style: Theme.of(context).textTheme.headline1,
      ));
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: 280,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _cells,
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

      // RichText(
      //   text: TextSpan(
      //     style: TextStyle(fontSize: 22, color: Colors.black),
      //     children: <TextSpan>[
      //       TextSpan(
      //         text: inputCode,
      //         style: Theme.of(context).textTheme.headline1,
      //       ),
      //       TextSpan(
      //         text: 'ریال',
      //         style: Theme.of(context)
      //             .textTheme
      //             .bodyText1
      //             .copyWith(color: widget.secondaryTextColor),
      //       ),
      //     ],
      //   ),
      // ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: _cells,
      // ),
    );
  }
}
