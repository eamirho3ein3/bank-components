part of bank_components;

class CustomDatePicker extends StatefulWidget {
  final Function(String) onComplete;
  final String placeholder;
  final int minYear;
  final int maxYear;
  final Widget confirmTitle;
  final Widget cancelTitle;
  final Function(String) validator;
  final String initValue;
  final String dateFormat;
  CustomDatePicker(
      {@required this.onComplete,
      @required this.placeholder,
      @required this.minYear,
      @required this.maxYear,
      this.confirmTitle,
      this.cancelTitle,
      this.validator,
      this.initValue,
      this.dateFormat});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
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
    List initials = widget.initValue != null ? widget.initValue.split('-') : [];

    DatePicker.showDatePicker(
      context,
      minYear: widget.minYear,
      maxYear: widget.maxYear,
      confirm: widget.confirmTitle != null
          ? widget.confirmTitle
          : Text(
              'تایید',
              style: TextStyle(color: Colors.red),
            ),
      cancel: widget.cancelTitle != null
          ? widget.cancelTitle
          : Text(
              'لغو',
              style: TextStyle(color: Colors.cyan),
            ),
      dateFormat: widget.dateFormat != null ? widget.dateFormat : 'yyyy-mm-dd',
      initialDay: initials.isNotEmpty ? initials[2] : null,
      initialMonth: initials.isNotEmpty ? initials[1] : null,
      initialYear: initials.isNotEmpty ? initials[0] : null,
      onChanged: (year, month, day) {
        dateController.text = _formatDate(year, month, day);
        widget.onComplete(_formatDate(year, month, day));
      },
      onConfirm: (year, month, day) {
        dateController.text = _formatDate(year, month, day);
        widget.onComplete(_formatDate(year, month, day));
      },
    );
  }

  String _formatDate(int year, int month, int day) {
    final DateTime date = DateTime(year, month, day);

    switch (widget.dateFormat) {
      case 'yyyy-mm':
        final intel.DateFormat formatter = intel.DateFormat('yyyy-MM');
        return formatter.format(date);
      case 'yyyy':
        final intel.DateFormat formatter = intel.DateFormat('yyyy');
        return formatter.format(date);
      case 'yyyy-mm-dd':
      default:
        final intel.DateFormat formatter = intel.DateFormat('yyyy-MM-dd');
        return formatter.format(date);
    }
  }
}
