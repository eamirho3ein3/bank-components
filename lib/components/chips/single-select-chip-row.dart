part of bank_components;

class SingleSelectChips extends StatefulWidget {
  final List<ChipModel> filters;
  final Function(int) onSelect;
  SingleSelectChips({@required this.filters, @required this.onSelect});
  @override
  _SingleSelectChipsState createState() => _SingleSelectChipsState();
}

class _SingleSelectChipsState extends State<SingleSelectChips> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _addRoWItemSpace(widget.filters),
      ),
    );
  }

  List<Widget> _addRoWItemSpace(List<ChipModel> list) {
    if (list != null) {
      List<Widget> result = [];

      for (var i = 0; i < list.length; i++) {
        CustomChoiceChip chip = CustomChoiceChip(
          selected: selected == i,
          title: list[i].title,
          type: ChipType.Filter,
          icon: list[i].icon,
          numbers: list[i].number,
          onClick: () {
            setState(() {
              selected = i;
            });
            widget.onSelect(i);
          },
        );
        result.add(chip);
        if (i + 1 != list.length) {
          result.add(SizedBox(width: 8));
        }
      }
      return result;
    } else {
      return [];
    }
  }
}
