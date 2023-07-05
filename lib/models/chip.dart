part of bank_components;

class ChipModel {
  final String title;
  final IconData icon;
  final String number;
  final Function onActionSelected;
  final Color color;

  ChipModel({
    @required this.title,
    this.icon,
    this.number,
    this.onActionSelected,
    this.color,
  });
}
