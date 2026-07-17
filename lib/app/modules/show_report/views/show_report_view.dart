import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../controllers/show_report_controller.dart';
import 'show_report_form_ui.dart';

class ShowReportView extends GetView<ShowReportController> {
  const ShowReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowReportController>(
      builder: (controller) {
        final isPurchase = Get.arguments == AppString.monthlyPurchase ||
            Get.arguments == AppString.todayPurchase;

        return CommonScreen(
          title: AppString.showReport,
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: isPurchase
              ? _buildPurchaseList(controller)
              : _buildSaleList(controller),
        );
      },
    );
  }

  Widget _buildSaleList(ShowReportController controller) {
    if (controller.monthlySaleList.isEmpty) {
      return Utils().noDataFound(Get.context!, true);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: controller.monthlySaleList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ShowReportSaleCard(
            model: controller.monthlySaleList[index],
            index: index,
          ),
        );
      },
    );
  }

  Widget _buildPurchaseList(ShowReportController controller) {
    if (controller.monthlyPurchaseList.isEmpty) {
      return Utils().noDataFound(Get.context!, true);
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: controller.monthlyPurchaseList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ShowReportPurchaseCard(
            model: controller.monthlyPurchaseList[index],
            index: index,
          ),
        );
      },
    );
  }
}
