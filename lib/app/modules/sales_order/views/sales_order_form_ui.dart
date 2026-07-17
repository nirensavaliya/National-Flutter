import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';

import '../../../commons/all.dart';

class SalesOrderFormSection extends StatelessWidget {
  const SalesOrderFormSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SplashColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: SplashColors.primary, size: 18),
              ),
              const Gap(10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s16,
                  color: SplashColors.primaryDark,
                ),
              ),
            ],
          ),
          const Gap(14),
          ...children,
        ],
      ),
    );
  }
}

class SalesOrderSheetHeader extends StatelessWidget {
  const SalesOrderSheetHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SplashColors.primaryDeep,
            SplashColors.primary,
            SplashColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(12),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.semiBold,
              fontSize: FontSize.s18,
              color: SplashColors.text,
            ),
          ),
          if (subtitle != null) ...[
            const Gap(4),
            Text(
              subtitle!,
              style: TextStyle(
                fontFamily: FontFamily.regular,
                fontSize: FontSize.s12,
                color: SplashColors.subText.withOpacity(0.9),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Color salesOrderFieldBorder(bool isOpen) {
  return isOpen
      ? SplashColors.primary
      : SplashColors.primary.withOpacity(0.25);
}

InputDecoration salesOrderSearchDecoration() {
  return InputDecoration(
    hintText: 'Enter here to search',
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 10, right: 6),
      child: Icon(Icons.search, size: 26, color: SplashColors.primaryDark),
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 30),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SplashColors.primary.withOpacity(0.25)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SplashColors.primary.withOpacity(0.25)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: SplashColors.primary, width: 1.5),
    ),
  );
}

BoxDecoration salesOrderDropdownDecoration() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: SplashColors.primary.withOpacity(0.25)),
    borderRadius: BorderRadius.circular(12),
  );
}


class AddItemDialog extends StatelessWidget {
  const AddItemDialog({
    super.key,
    required this.itemName,
    required this.imageUrl,
    required this.rate,
    required this.sizeController,
    required this.pcsController,
    required this.onCancel,
    required this.onAdd,
  });

  final String itemName;
  final String imageUrl;
  final String rate;
  final TextEditingController sizeController;
  final TextEditingController pcsController;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: SplashColors.primaryDeep.withOpacity(0.2),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SplashColors.primaryDeep,
                    SplashColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Text(
                'Add Item',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s18,
                  color: SplashColors.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SplashColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImages.appIcon_g,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const Gap(14),
                  Text(
                    itemName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                  const Gap(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: sizeController,
                          title: 'Size',
                          isTitle: true,
                          hintText: 'e.g. 6x6',
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: pcsController,
                          title: 'PCS',
                          isTitle: true,
                          hintText: 'Qty',
                          maxLength: 4,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rate',
                      style: TextStyle(
                        fontFamily: FontFamily.medium,
                        fontSize: FontSize.s12,
                        color: const Color(0xFF78829A),
                      ),
                    ),
                  ),
                  const Gap(6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: SplashColors.scaffoldBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      rate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        fontSize: FontSize.s16,
                        color: SplashColors.primary,
                      ),
                    ),
                  ),
                  const Gap(22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onCancel,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: SplashColors.primary.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAdd,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddQuantityDialog extends StatelessWidget {
  const AddQuantityDialog({
    super.key,
    required this.itemName,
    required this.imageUrl,
    required this.rate,
    required this.qtyController,
    required this.onConfirm,
  });

  final String itemName;
  final String imageUrl;
  final String rate;
  final TextEditingController qtyController;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: SplashColors.primaryDeep.withOpacity(0.2),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SplashColors.primaryDeep,
                    SplashColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Text(
                'Add Quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s18,
                  color: SplashColors.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SplashColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImages.appIcon_g,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const Gap(14),
                  Text(
                    itemName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(
                                fontFamily: FontFamily.medium,
                                fontSize: FontSize.s12,
                                color: const Color(0xFF78829A),
                              ),
                            ),
                            const Gap(6),
                            TextField(
                              controller: qtyController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FontFamily.bold,
                                fontSize: FontSize.s16,
                                color: SplashColors.primaryDark,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Qty',
                                filled: true,
                                fillColor: SplashColors.scaffoldBg,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: SplashColors.primary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rate',
                              style: TextStyle(
                                fontFamily: FontFamily.medium,
                                fontSize: FontSize.s12,
                                color: const Color(0xFF78829A),
                              ),
                            ),
                            const Gap(6),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: SplashColors.scaffoldBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                rate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.bold,
                                  fontSize: FontSize.s16,
                                  color: SplashColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: SplashColors.primary.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSizeDialog extends StatelessWidget {
  const CustomSizeDialog({
    super.key,
    required this.sizeController,
    required this.pcsController,
    required this.onCancel,
    required this.onAdd,
  });

  final TextEditingController sizeController;
  final TextEditingController pcsController;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: SplashColors.primaryDeep.withOpacity(0.2),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [SplashColors.primaryDeep, SplashColors.primary],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Text(
                'Custom Size',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s18,
                  color: SplashColors.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Size + PCS — bas yahi
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: sizeController,
                          title: 'Size',
                          isTitle: true,
                          hintText: 'e.g. 6x6',
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: pcsController,
                          title: 'PCS',
                          isTitle: true,
                          hintText: 'Qty',
                          maxLength: 4,
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(22),
                  // Cancel + Add
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onCancel,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: SplashColors.primary.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAdd,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesOrderDetailRow extends StatelessWidget {
  const SalesOrderDetailRow({
    super.key,
    required this.label,
    this.value,
    this.highlight = false,
  });

  final String label;
  final String? value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: FontSize.s12,
                color: const Color(0xFF78829A),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? '',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: highlight ? FontFamily.bold : FontFamily.semiBold,
                fontSize: highlight ? FontSize.s16 : FontSize.s14,
                color: highlight ? SplashColors.primary : SplashColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SalesOrderActionBar extends StatelessWidget {
  const SalesOrderActionBar({
    super.key,
    this.onEdit,
    required this.onPdf,
    this.onDelete,
  });

  final VoidCallback? onEdit;
  final VoidCallback onPdf;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: SplashColors.scaffoldBg,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onEdit != null)
            _ActionButton(
              icon: Icons.edit_outlined,
              label: 'Edit',
              color: const Color(0xFF3B82F6),
              onTap: onEdit!,
            )
          else
            const SizedBox(width: 72),
          _ActionButton(
            icon: Icons.picture_as_pdf_outlined,
            label: 'PDF',
            color: const Color(0xFF22C55E),
            onTap: onPdf,
          ),
          if (onDelete != null)
            _ActionButton(
              icon: Icons.delete_outline,
              label: 'Delete',
              color: const Color(0xFFEF4444),
              onTap: onDelete!,
            )
          else
            const SizedBox(width: 72),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: FontSize.s10,
              color: SplashColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

class SalesOrderDeleteDialog extends StatelessWidget {
  const SalesOrderDeleteDialog({
    super.key,
    required this.onConfirm,
  });

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: SplashColors.primaryDeep.withOpacity(0.2),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SplashColors.primaryDeep,
                    SplashColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Text(
                'Delete Order',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s18,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Are you sure you want to delete this?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.medium,
                      fontSize: FontSize.s16,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                  const Gap(22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: SplashColors.primary.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF4444),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesOrderListCard extends StatelessWidget {
  const SalesOrderListCard({
    super.key,
    required this.salesOrderId,
    required this.customerName,
    required this.netAmount,
    required this.orderNumber,
    required this.date,
    required this.salesPerson,
    required this.contactNumber,
    required this.invoiceType,
    required this.allowEditEntry,
    required this.allowDeleteEntry,
    required this.onExpansionChanged,
    required this.onEdit,
    required this.onPdf,
    required this.onDelete,
  });

  final String salesOrderId;
  final String? customerName;
  final String netAmount;
  final String? orderNumber;
  final String? date;
  final String? salesPerson;
  final String? contactNumber;
  final String? invoiceType;
  final bool? allowEditEntry;
  final bool? allowDeleteEntry;
  final ValueChanged<bool> onExpansionChanged;
  final VoidCallback onEdit;
  final VoidCallback onPdf;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: SplashColors.primary.withOpacity(0.1)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
            splashColor: SplashColors.primary.withOpacity(0.08),
            highlightColor: SplashColors.primary.withOpacity(0.05),
          ),
          child: ExpansionTile(
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            key: Key(salesOrderId),
          onExpansionChanged: onExpansionChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: EdgeInsets.zero,
          iconColor: SplashColors.primary,
          collapsedIconColor: SplashColors.primary,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: SplashColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.store_outlined,
                  color: SplashColors.primary,
                  size: 22,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName ?? 'N/A',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontFamily.semiBold,
                        fontSize: FontSize.s14,
                        color: SplashColors.primaryDark,
                      ),
                    ),
                    if (date != null && date!.isNotEmpty) ...[
                      const Gap(2),
                      Text(
                        date!,
                        style: TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: FontSize.s12,
                          color: const Color(0xFF78829A),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (orderNumber != null && orderNumber!.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: SplashColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '#$orderNumber',
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s10,
                          color: SplashColors.primary,
                        ),
                      ),
                    ),
                  Text(
                    netAmount,
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: FontSize.s16,
                      color: SplashColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Divider(
              color: SplashColors.primary.withOpacity(0.1),
              height: 1,
            ),
            SalesOrderDetailRow(
              label: 'Customer Name',
              value: customerName,
            ),
            SalesOrderDetailRow(
              label: 'Sales Person',
              value: salesPerson,
            ),
            SalesOrderDetailRow(
              label: 'Contact Number',
              value: contactNumber,
            ),
            SalesOrderDetailRow(
              label: 'Order No.',
              value: orderNumber,
            ),
            SalesOrderDetailRow(
              label: 'Date',
              value: date,
            ),
            SalesOrderDetailRow(
              label: 'Invoice Type',
              value: invoiceType,
            ),
            SalesOrderDetailRow(
              label: 'Net Amount',
              value: netAmount,
              highlight: true,
            ),
            SalesOrderActionBar(
              onEdit: allowEditEntry == true ? onEdit : null,
              onPdf: onPdf,
              onDelete: allowDeleteEntry == true ? onDelete : null,
            ),
          ],
        ),
      ),
      ),
    );
  }
}
