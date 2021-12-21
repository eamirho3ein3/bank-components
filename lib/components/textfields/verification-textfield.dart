part of bank_components;

class VerificationTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onComplete;
  final Function(String) onChanged;
  VerificationTextField(
      {@required this.controller,
      @required this.onComplete,
      @required this.onChanged});

  @override
  _VerificationTextFieldState createState() => _VerificationTextFieldState();
}

class _VerificationTextFieldState extends State<VerificationTextField> {
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
          _buildNumberItem(_input),

          // hiden textfield
          Opacity(
            opacity: 0.0,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: MainTextField(
                type: TextfieldType.Reqular,
                controller: _controller,
                focusNode: _focusNode,
                limit: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                ],
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _input = value;
                  if (widget.onChanged != null) {
                    widget.onChanged(_input);
                  }

                  if (_input.length == 6) {
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
}
