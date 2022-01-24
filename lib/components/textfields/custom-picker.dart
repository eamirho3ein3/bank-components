part of bank_components;

class CustomPicker extends StatefulWidget {
  final Function(String) onComplete;
  final Function(String) onChanged;
  final String placeholder;
  final int minYear;
  final int maxYear;
  final Widget confirmTitle;
  final Widget cancelTitle;
  final Function(String) validator;
  CustomPicker(
      {@required this.onComplete,
      @required this.onChanged,
      @required this.placeholder,
      @required this.minYear,
      @required this.maxYear,
      this.confirmTitle,
      this.cancelTitle,
      this.validator});

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDatePicker(context);
      },
      child: AbsorbPointer(
        child: MainTextField(
          controller: dateController,
          type: TextfieldType.Reqular,
          label: widget.placeholder,
          keyboardType: TextInputType.text,
          validator: widget.validator,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      minYear: widget.minYear,
      maxYear: widget.maxYear,
      confirm: widget.confirmTitle != null
          ? widget.confirmTitle
          : Text(
              'لغو',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.cyan),
            ),
      cancel: widget.cancelTitle != null
          ? widget.cancelTitle
          : Text(
              'تایید',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.red),
            ),
      dateFormat: 'yyyy-mm-dd',
      onChanged: (year, month, day) {
        dateController.text = '$year-$month-$day';
        widget.onChanged('$year-$month-$day');
      },
      onConfirm: (year, month, day) {
        dateController.text = '$year-$month-$day';
        widget.onComplete('$year-$month-$day');
      },
    );
  }
}
