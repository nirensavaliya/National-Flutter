import '../../../commons/all.dart';

class SalesOrderCartActionButton extends StatelessWidget {
  const SalesOrderCartActionButton({
    super.key,
    required this.itemCount,
    required this.onTap,
  });

  final int itemCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 18,
            ),
            if (itemCount > 0)
              Positioned(
                right: -10,
                top: -10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    itemCount > 99 ? '99+' : itemCount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.s10,
                      fontFamily: FontFamily.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
