import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/Recipt/views/receipt_add_view.dart';
import 'package:intl/intl.dart';

import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
import '../controllers/receipt_controller.dart';
import '../model/ReceiptListModel.dart';

class ReceiptView extends GetView<ReceiptController> {
  const ReceiptView({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ReceiptController>(
      builder: (controller) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   String role = GetStorageData.readString(GetStorageData.role);
        //   controller.collectedByController.text = role.isNotEmpty ? role : "";
        //   print("Role at ReceiptView post frame: $role");
        //   controller.update();
        // });

          String role = GetStorageData.readString(GetStorageData.role) ?? "";
          if (controller.collectedByController.text != role) {
            controller.collectedByController.text = role;
            controller.update();
          }
          print("Role at ReceiptView: $role");

        return CommonScreen(
          title: AppString.recipt,
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          floatingActionButton: controller.isAdd.value
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    controller.addDateController.text = DateFormat("dd/MM/yyyy")
                        .format(DateTime.now())
                        .toString();
                    controller.isAdd.value = true;
                    controller.nextSerialNoApi();
                    controller.update();
                  },
                  child: CircleAvatar(
                    backgroundColor: SplashColors.primary,
                    radius: 25,
                    child: Center(
                        child: Icon(Icons.add, size: 35, color: Colors.white)),
                  ),
                ),
          actions: controller.isAdd.value
              ? []
              : [
                ],
          body: controller.isAdd.value
              ? ReceiptAddView()
              : Constants.receiptList.isEmpty
                  ? Utils().noDataFound(context, controller.isData)
                  : ListView.builder(
                      itemCount: Constants.receiptList.length,
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 35),
                      itemBuilder: (context, index) {
                        var receipt = Constants.receiptList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _receiptCard(receipt),
                        );
                      },
                    ),
        );
      },
    );
  }

  Widget _receiptCard(ReceiptData receipt) {
    final date = DateFormat('yyyy-MM-dd').format(receipt.receiptDate);

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: SplashColors.primary.withOpacity(0.12)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.receipt_long_outlined,
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
                        "Receipt ID: ${receipt.receiptId}",
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s16,
                          color: SplashColors.primaryDark,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        "Serial No: ${receipt.serialNo}",
                        style: TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: FontSize.s12,
                          color: const Color(0xFF78829A),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${receipt.totalReceived}",
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: FontSize.s16,
                    color: SplashColors.primary,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                height: 1,
                color: SplashColors.primary.withOpacity(0.1),
              ),
            ),
            _detailRow('Sales Person', receipt.salesPerson ?? '-'),
            _detailRow('Party', receipt.party.isNotEmpty ? receipt.party : '-'),
            _detailRow('Total Received', '\$${receipt.totalReceived}'),
            _detailRow('Total Adjusted', '\$${receipt.totalAdjusted}'),
            _detailRow('Date', date),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 118,
            child: Text(
              '$label:',
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: FontSize.s12,
                color: const Color(0xFF78829A),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: FontFamily.semiBold,
                fontSize: FontSize.s12,
                color: SplashColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
