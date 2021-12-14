part of components;

class NeoTextField extends StatelessWidget {
  final TextfieldType type;
  final TextEditingController controller;
  final TextAlign textAlign;
  final String label;
  final TextfieldHelper helper;
  final int limit;
  final TextfieldExtend prefix;
  final TextfieldExtend suffix;
  final bool hidePassword;
  final Function(String) validator;
  final TextInputType keyboardType;
  final Function(String) verificationOnComplete; //only use in verification code
  final Function(String) verificationOnChanged; //only use in verification code
  final Color secondaryTextColor;
  NeoTextField(
      {@required this.controller,
      this.textAlign,
      this.label,
      this.helper,
      this.limit,
      this.prefix,
      this.suffix,
      this.hidePassword,
      this.validator,
      @required this.type,
      this.keyboardType,
      this.verificationOnComplete,
      this.verificationOnChanged,
      this.secondaryTextColor});
  @override
  Widget build(BuildContext context) {
    if (type == TextfieldType.Reqular) {
      // regular textfield

      return Stack(
        children: [
          TextFormField(
            controller: controller,
            textAlign: textAlign != null ? textAlign : TextAlign.start,
            maxLength: limit,
            buildCounter: (context, {currentLength, isFocused, maxLength}) {
              return Container(
                child: Text(
                  limit != null
                      ? replaceFarsiNumber(
                          '$maxLength/${controller.text.length}')
                      : '',
                  style: Theme.of(context).inputDecorationTheme.counterStyle,
                ),
              );
            },
            decoration: InputDecoration(
              labelText: label,
              helperText: helper != null ? '' : null,
              prefixIcon: _buildExtendWidget(prefix, context, false),
              suffixIcon: _buildExtendWidget(suffix, context, true),
              contentPadding: EdgeInsets.all(12),
            ),
            obscureText: hidePassword != null ? hidePassword : false,
            validator: validator,
            keyboardType: keyboardType,
          ),
          helper != null
              ? Positioned(
                  bottom: 0,
                  right: 12,
                  child: _buildTextFieldHelperWidget(context),
                )
              : SizedBox(),
        ],
      );
    } else if (type == TextfieldType.Amount) {
      // amount textfield
      return CustomTextfield(
        type: type,
        controller: controller,
        secondaryTextColor: secondaryTextColor,
      );
    } else {
      // code textfield
      return CustomTextfield(
        type: type,
        controller: controller,
        onComplete: verificationOnComplete,
        onValueChanged: verificationOnChanged,
      );
    }
  }

  _buildTextFieldHelperWidget(BuildContext context) {
    if (helper.type == HeplerType.Regular) {
      // regular
      return Text(
        helper.text,
        style: Theme.of(context).inputDecorationTheme.helperStyle,
      );
    } else {
      // success or error
      return Row(
        children: [
          // TODO: change icon data with real one
          Icon(
            helper.type == HeplerType.Success ? Icons.info : Icons.info,
            color: helper.type == HeplerType.Success
                ? helper.theme.success
                : helper.theme.error,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              helper.text,
              style: Theme.of(context)
                  .inputDecorationTheme
                  .helperStyle
                  .copyWith(
                      color: helper.type == HeplerType.Success
                          ? helper.theme.success
                          : helper.theme.error),
            ),
          ),
        ],
      );
    }
  }

  _buildExtendWidget(
      TextfieldExtend widget, BuildContext context, bool isSuffix) {
    if (widget == null) {
      return null;
    } else if (widget.type == TextfieldExtendType.Icon) {
      // icon

      return InkWell(
        onTap: widget.onTap,
        child: Icon(
          widget.icon.icon,
          color: widget.icon.iconColor,
        ),
      );
    } else if (widget.type == TextfieldExtendType.Text) {
      // text

      return Padding(
        padding:
            EdgeInsets.only(left: isSuffix ? 4 : 8, right: !isSuffix ? 4 : 8),
        child: Container(
          height: 40,
          width: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: widget.textBackgroundColor,
          ),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      );
    } else {
      // child
      return widget.child;
    }
  }
}

class TextfieldHelper {
  final HeplerType type;
  final String text;
  final HelperWidgetTheme theme;

  TextfieldHelper(
      {@required this.type, @required this.text, @required this.theme});
}

class HelperWidgetTheme {
  // on regular type you don't need to pass this
  final Color success;
  final Color error;

  HelperWidgetTheme({@required this.success, @required this.error});
}

class TextfieldExtend {
  final TextfieldExtendType type;
  final NeoIconTheme icon;
  final String text;
  final Widget child;
  final Function onTap;
  final Color textBackgroundColor;

  TextfieldExtend({
    @required this.type,
    this.icon,
    this.text,
    this.child,
    this.onTap,
    this.textBackgroundColor,
  });
}

enum HeplerType { Regular, Error, Success }

enum TextfieldExtendType { Icon, Text, Child }

enum TextfieldType { Reqular, Amount, Code }

class CodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var numberIndex = oldValue.text.lastIndexOf(RegExp(r'@"^\d$"'));

    if (newValue.text.length > oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text.replaceFirst(RegExp(r'- |-'), ''),
        selection: TextSelection.collapsed(offset: numberIndex + 2),
      );
    } else {
      return TextEditingValue(
        text: newValue.text + '- ',
        selection: TextSelection.collapsed(offset: numberIndex + 2),
      );
    }
  }
}
