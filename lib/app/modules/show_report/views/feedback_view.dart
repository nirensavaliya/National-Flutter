import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';
import 'package:gurukrupa/app/modules/show_report/controllers/feedback_controller.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';

class ReportFeedbackView extends GetView<ReportFeedbackController> {
  const ReportFeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportFeedbackController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Feedback',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              children: [
                SalesOrderFormSection(
                  title: 'Your Feedback',
                  icon: Icons.feedback_outlined,
                  children: [
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.feedbackController,
                      title: 'Enter your feedback',
                      isTitle: true,
                      maxLine: 5,
                      hintText: 'Write your feedback here...',
                    ),
                  ],
                ),
                const Gap(20),
                CommonButton(
                  btnName: 'Save Feedback',
                  btnColor: SplashColors.primary,
                  onTap: () {
                    controller.validation(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
