part of bank_components;

class ZarinId extends StatelessWidget {
  final ZarinIdTheme style;
  final String? id;
  ZarinId({required this.style, this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: style.borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(
            id ?? '',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          style.backgroundStatusColor != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundColor: style.backgroundStatusColor,
                    radius: 8,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: style.foregroundStatusColor,
                        ),
                        width: 8,
                        height: 8,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class ZarinIdTheme {
  final Color borderColor;
  final Color backgroundStatusColor;
  final Color foregroundStatusColor;
  ZarinIdTheme(
      {required this.borderColor,
      required this.backgroundStatusColor,
      required this.foregroundStatusColor});
}
