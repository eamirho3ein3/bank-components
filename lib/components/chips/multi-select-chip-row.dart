part of bank_components;

class MultiSelectChips extends StatefulWidget {
  final CustomChoiceChip mainChip;
  final List<CustomChoiceChip> actions;
  final List<ChipModel> filters;
  final Function(int) filterOnSelect;
  MultiSelectChips(
      {this.mainChip, this.actions, this.filters, this.filterOnSelect});
  @override
  _MultiSelectChipsState createState() => _MultiSelectChipsState();
}

class _MultiSelectChipsState extends State<MultiSelectChips> {
  List<int> filtersSelected = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // main chip
          widget.mainChip != null
              ? Row(
                  children: [
                    widget.mainChip,
                    VerticalDivider(
                      thickness: 16,
                      width: 1,
                    ),
                  ],
                )
              : SizedBox(),

          // actions
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: _addActionRoWItemSpace(widget.actions),
            ),
          ),

          // filters
          Row(
            children: _addFilterRoWItemSpace(widget.filters),
          ),
        ],
      ),
    );
  }

  List<Widget> _addActionRoWItemSpace(List<CustomChoiceChip> list) {
    if (list != null) {
      List<Widget> result = [];

      var index = 1;
      for (var item in list) {
        result.add(item);
        if (index != list.length) {
          result.add(SizedBox(width: 8));
        }
        index++;
      }

      return result;
    } else {
      return [];
    }
  }

  List<Widget> _addFilterRoWItemSpace(List<ChipModel> list) {
    if (list != null) {
      List<Widget> result = [];

      for (var i = 0; i < list.length; i++) {
        CustomChoiceChip chip = CustomChoiceChip(
          selected: filtersSelected.contains(i),
          title: list[i].title,
          type: ChipType.Filter,
          icon: list[i].icon,
          numbers: list[i].number,
          onClick: () {
            setState(() {
              filtersSelected.add(i);
            });
            widget.filterOnSelect(i);
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
