import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/modules/outstanding/views/payable_view.dart';
import 'package:gurukrupa/app/modules/outstanding/views/receivable_view.dart';

import '../../../commons/app_colors.dart';
import '../controllers/outstanding_controller.dart';

class OutstandingView extends GetView<OutstandingController> {
  const OutstandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutstandingController>(
      builder: (controller) {
        return CommonScreen(
          title: controller.title,
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: controller.title == AppString.outstandingReceivable
              ? const ReceivableView()
              : const PayableView(),
        );
      },
    );
  }
}
