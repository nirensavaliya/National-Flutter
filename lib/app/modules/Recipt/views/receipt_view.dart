import 'package:gap/gap.dart';
import 'package:gurukrupa/app/modules/Recipt/views/receipt_add_view.dart';
import 'package:intl/intl.dart';

import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
import '../controllers/receipt_controller.dart';

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
                    backgroundColor: Colors.blue,
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
                      itemBuilder: (context, index) {
                        var receipt = Constants.receiptList[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          color: Colors.white,
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              "Receipt ID: ${receipt.receiptId}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Serial No: ${receipt.serialNo}"),
                                Text("Sales Person: ${receipt.salesPerson}"),
                                Text("Party: ${receipt.party}"),
                                Text(
                                    "Total Received: \$${receipt.totalReceived}"),
                                Text(
                                    "Total Adjusted: \$${receipt.totalAdjusted}"),
                                Text(
                                    "Date: ${DateFormat('yyyy-MM-dd').format(receipt.receiptDate)}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }

  Widget commonTableText({String? title, bool? isLight, bool? isEnd}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title ?? "",
        textAlign: isEnd == true ? TextAlign.end : TextAlign.start,
        style: TextStyle(
          fontSize: FontSize.s16,
          color: isLight == true ? Colors.black45 : Colors.black,
          fontFamily: FontFamily.medium,
        ),
      ),
    );
  }
}
