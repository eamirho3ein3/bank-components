part of bank_components;

class PersonalSettingItem extends StatefulWidget {
  final List<String> options;
  final String title;
  final String description;
  final PersonalSettingStyle style;
  final Function(String?) onSelect;
  final String? selected;

  const PersonalSettingItem({
    Key? key,
    required this.options,
    required this.title,
    required this.description,
    required this.style,
    required this.onSelect,
    this.selected,
  }) : super(key: key);

  @override
  State<PersonalSettingItem> createState() => _PersonalSettingItemState();
}

class _PersonalSettingItemState extends State<PersonalSettingItem> {
  String selected = '';
  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      selected = widget.selected!;
    }
    if (widget.options.isNotEmpty && widget.selected == null) {
      selected = widget.options[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.style.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.style.itemBackgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildSelectedItem(widget.options[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: widget.style.dividerColor,
                      height: 12,
                    );
                  },
                  itemCount: widget.options.length,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.description,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: widget.style.descriptionColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSelectedItem(String value) {
    return InkWell(
      onTap: () {
        widget.onSelect(value);
        setState(() {
          selected = value;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          AbsorbPointer(
            child: Radio<String>(
              value: value,
              groupValue: selected,
              fillColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return widget.style.activeColor;
                }
                return widget.style.inactiveColor;
              }),
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalSettingStyle {
  final Color backgroundColor;
  final Color itemBackgroundColor;
  final Color descriptionColor;
  final Color dividerColor;
  final Color activeColor;
  final Color inactiveColor;

  PersonalSettingStyle({
    required this.backgroundColor,
    required this.itemBackgroundColor,
    required this.descriptionColor,
    required this.dividerColor,
    required this.activeColor,
    required this.inactiveColor,
  });
}
