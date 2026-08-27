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
                  color: SplashColors.accent.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: SplashColors.nightSky, size: 18),
              ),
              const Gap(10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s16,
                  color: SplashColors.nightSky,
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
            SplashColors.nightSkyMid,
            SplashColors.nightSky,
            SplashColors.nightSkyDeep,
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
              color: SplashColors.accent.withOpacity(0.55),
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
                color: SplashColors.accentSoft.withOpacity(0.9),
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
      ? SplashColors.accent
      : SplashColors.nightSky.withOpacity(0.25);
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
      child: Icon(Icons.search, size: 26, color: SplashColors.nightSky),
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 30),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SplashColors.nightSky.withOpacity(0.25)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SplashColors.nightSky.withOpacity(0.25)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: SplashColors.accent, width: 1.5),
    ),
  );
}

BoxDecoration salesOrderDropdownDecoration() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: SplashColors.nightSky.withOpacity(0.25)),
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
              color: SplashColors.nightSkyDeep.withOpacity(0.2),
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
                    SplashColors.nightSkyDeep,
                    SplashColors.nightSky,
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
                      color: SplashColors.nightSky.withOpacity(0.08),
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
                      color: SplashColors.nightSky,
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
                        color: SplashColors.accent,
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
                              color: SplashColors.nightSky.withOpacity(0.4),
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
                              color: SplashColors.nightSky,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAdd,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.accent,
                            foregroundColor: SplashColors.nightSkyDeep,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: SplashColors.nightSkyDeep,
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
              color: SplashColors.nightSkyDeep.withOpacity(0.2),
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
                    SplashColors.nightSkyDeep,
                    SplashColors.nightSky,
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
                      color: SplashColors.nightSky.withOpacity(0.08),
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
                      color: SplashColors.nightSky,
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
                                color: SplashColors.nightSky,
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
                                    color: SplashColors.nightSky,
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
                                  color: SplashColors.nightSky,
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
                              color: SplashColors.nightSky.withOpacity(0.4),
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
                              color: SplashColors.nightSky,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.accent,
                            foregroundColor: SplashColors.nightSkyDeep,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: SplashColors.nightSkyDeep,
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

class CustomSizeDialog extends StatefulWidget {
  const CustomSizeDialog({
    super.key,
    required this.itemName,
    required this.lengthController,
    required this.widthController,
    required this.pieceController,
    required this.remarksController,
    required this.onCancel,
    required this.onSave,
    this.imageUrl,
  });

  final String itemName;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController pieceController;
  final TextEditingController remarksController;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String? imageUrl;

  @override
  State<CustomSizeDialog> createState() => _CustomSizeDialogState();
}

class _CustomSizeDialogState extends State<CustomSizeDialog> {
  final _lengthFocus = FocusNode();
  final _widthFocus = FocusNode();
  final _pieceFocus = FocusNode();
  final _remarksFocus = FocusNode();

  @override
  void dispose() {
    _lengthFocus.dispose();
    _widthFocus.dispose();
    _pieceFocus.dispose();
    _remarksFocus.dispose();
    super.dispose();
  }

  String get _sqFtLabel {
    final length = double.tryParse(widget.lengthController.text.trim());
    final width = double.tryParse(widget.widthController.text.trim());
    if (length == null || width == null || length <= 0 || width <= 0) {
      return '0';
    }
    final sqFt = length * width;
    return sqFt % 1 == 0 ? sqFt.toInt().toString() : sqFt.toStringAsFixed(2);
  }

  void _recalculate() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: SplashColors.nightSkyDeep.withOpacity(0.2),
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
                    SplashColors.nightSkyDeep,
                    SplashColors.nightSky,
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Text(
                'Customize',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: SplashColors.nightSky.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: widget.imageUrl != null &&
                                widget.imageUrl!.trim().isNotEmpty
                            ? Image.network(
                                widget.imageUrl!,
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
                              )
                            : Image.asset(
                                AppImages.appIcon_g,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const Gap(14),
                  Text(
                    widget.itemName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.nightSky,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Details',
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.nightSky,
                    ),
                  ),
                  const Gap(12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: widget.lengthController,
                          focusNode: _lengthFocus,
                          title: 'Length',
                          isTitle: true,
                          hintText: 'L',
                          textInputAction: TextInputAction.next,
                          // iOS number pad has no Next key; text + filter keeps digits only.
                          textInputType: TextInputType.text,
                          inputFormatters: [
                       FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                          ],
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_widthFocus),
                          onChanged: (_) => _recalculate(),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: widget.widthController,
                          focusNode: _widthFocus,
                          title: 'Width',
                          isTitle: true,
                          hintText: 'W',
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                          ],
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_pieceFocus),
                          onChanged: (_) => _recalculate(),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: widget.pieceController,
                          focusNode: _pieceFocus,
                          title: 'Piece',
                          isTitle: true,
                          hintText: 'P',
                          textInputAction: TextInputAction.next,
                          maxLength: 4,
                          textInputType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_remarksFocus),
                          onChanged: (_) => _recalculate(),
                        ),
                      ),
                    ],
                  ),
                  // const Gap(12),
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 14,
                  //     vertical: 12,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: SplashColors.accent.withOpacity(0.12),
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(
                  //       color: SplashColors.accent.withOpacity(0.35),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         '= Sq.ft',
                  //         style: TextStyle(
                  //           fontFamily: FontFamily.medium,
                  //           fontSize: FontSize.s14,
                  //           color: SplashColors.nightSky,
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         _sqFtLabel,
                  //         style: TextStyle(
                  //           fontFamily: FontFamily.bold,
                  //           fontSize: FontSize.s16,
                  //           color: SplashColors.nightSkyDeep,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const Gap(16),
                  CommonTextField(
                    borderRadius: 12,
                    controller: widget.remarksController,
                    focusNode: _remarksFocus,
                    title: 'Remarks',
                    isTitle: true,
                    hintText: 'Enter remarks',
                    maxLine: 2,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                  ),
                  const Gap(22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onCancel,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: SplashColors.nightSky.withOpacity(0.4),
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
                              color: SplashColors.nightSky,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: widget.onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.accent,
                            foregroundColor: SplashColors.nightSkyDeep,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: SplashColors.nightSkyDeep,
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
                color: highlight ? SplashColors.accent : SplashColors.nightSky,
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
              color: SplashColors.nightSky,
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
              color: SplashColors.nightSkyDeep.withOpacity(0.2),
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
                    SplashColors.nightSkyDeep,
                    SplashColors.nightSky,
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
                      color: SplashColors.nightSky,
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
                              color: SplashColors.nightSky.withOpacity(0.4),
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
                              color: SplashColors.nightSky,
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
          side: BorderSide(color: SplashColors.nightSky.withOpacity(0.1)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
            splashColor: SplashColors.nightSky.withOpacity(0.08),
            highlightColor: SplashColors.nightSky.withOpacity(0.05),
          ),
          child: ExpansionTile(
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            key: Key(salesOrderId),
          onExpansionChanged: onExpansionChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: EdgeInsets.zero,
          iconColor: SplashColors.accent,
          collapsedIconColor: SplashColors.accent,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: SplashColors.accent.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.store_outlined,
                  color: SplashColors.nightSky,
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
                        color: SplashColors.nightSky,
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
                        color: SplashColors.nightSky.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '#$orderNumber',
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s10,
                          color: SplashColors.nightSky,
                        ),
                      ),
                    ),
                  Text(
                    netAmount,
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: FontSize.s16,
                      color: SplashColors.nightSky,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Divider(
              color: SplashColors.nightSky.withOpacity(0.1),
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
