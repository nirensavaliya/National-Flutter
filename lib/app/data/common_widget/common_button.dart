import '../../commons/all.dart';

class CommonButton extends StatelessWidget {
  final String? btnName;
  final Color? btnColor;
  final Color? textColor;
  final Color? borderColor;
  final void Function()? onTap;
  const CommonButton({super.key, this.btnName, this.onTap, this.btnColor, this.textColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: btnColor ?? Colors.blue[900],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? Colors.transparent)
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              btnName ?? "",
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontFamily: FontFamily.PlayfairDisplayMedium,
                fontSize: FontSize.s16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
