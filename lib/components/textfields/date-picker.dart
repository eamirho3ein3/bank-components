part of bank_components;

class CustomDatePicker extends StatefulWidget {
  final Function(String) onComplete;
  final String placeholder;
  final int minYear;
  final int maxYear;
  final Widget? confirmTitle;
  final Widget? cancelTitle;
  final String? Function(String?)? validator;
  final String? initValue;
  final String? dateFormat;
  CustomDatePicker(
      {required this.onComplete,
      required this.placeholder,
      required this.minYear,
      required this.maxYear,
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

  void _showDatePicker(BuildContext context) async {
    // List initials = widget.initValue != null ? widget.initValue.split('-') : [];
    // Jalali pickedDate = await showModalBottomSheet<Jalali>(
    //   context: context,
    //   builder: (context) {
    //     Jalali tempPickedDate;
    //     return Container(
    //       height: 250,
    //       child: Column(
    //         children: <Widget>[
    //           Container(
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 CupertinoButton(
    //                   child: Text(
    //                     'لغو',
    //                     style: Theme.of(context).textTheme.labelLarge,
    //                   ),
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                 ),
    //                 CupertinoButton(
    //                   child: Text(
    //                     'تایید',
    //                     style: Theme.of(context).textTheme.labelLarge,
    //                   ),
    //                   onPressed: () {
    //                     dateController.text = _formatDate(tempPickedDate.year,
    //                         tempPickedDate.month, tempPickedDate.day);
    //                     widget.onComplete(_formatDate(tempPickedDate.year,
    //                         tempPickedDate.month, tempPickedDate.day));
    //                     // Navigator.of(context).pop(tempPickedDate ?? Jalali.now());
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Divider(
    //             height: 0,
    //             thickness: 1,
    //           ),
    //           Expanded(
    //             child: Container(
    //               child: CupertinoTheme(
    //                 data: CupertinoThemeData(
    //                   textTheme: CupertinoTextThemeData(
    //                     dateTimePickerTextStyle:
    //                         Theme.of(context).textTheme.titleMedium,
    //                   ),
    //                 ),
    //                 child: PCupertinoDatePicker(
    //                   mode: PCupertinoDatePickerMode.dateAndTime,
    //                   onDateTimeChanged: (Jalali dateTime) {
    //                     tempPickedDate = dateTime;
    //                   },
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
    // DatePicker.showDatePicker(
    //   context,
    //   minYear: widget.minYear,
    //   maxYear: widget.maxYear,
    //   confirm: widget.confirmTitle != null
    //       ? widget.confirmTitle
    //       : Text(
    //           'تایید',
    //           style:
    //               TextStyle(color: Theme.of(context).textTheme.bodyLarge.color),
    //         ),
    //   cancel: widget.cancelTitle != null
    //       ? widget.cancelTitle
    //       : Text(
    //           'لغو',
    //           style: TextStyle(color: Colors.red),
    //         ),
    //   dateFormat: widget.dateFormat != null ? widget.dateFormat : 'yyyy-mm-dd',
    //   initialDay: initials.isNotEmpty ? initials[2] : null,
    //   initialMonth: initials.isNotEmpty ? initials[1] : null,
    //   initialYear: initials.isNotEmpty ? initials[0] : null,
    //   onChanged: (year, month, day) {
    //     dateController.text = _formatDate(year, month, day);
    //     widget.onComplete(_formatDate(year, month, day));
    //   },
    //   onConfirm: (year, month, day) {
    //     dateController.text = _formatDate(year, month, day);
    //     widget.onComplete(_formatDate(year, month, day));
    //   },
    // );
  }

  String _formatDate(int year, int month, int day) {
    final DateTime date = DateTime(year, month, day);

    switch (widget.dateFormat) {
      case 'mm-yyyy':
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
