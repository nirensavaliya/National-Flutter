import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_screen.dart';
import '../controllers/CustomerFeedbackController.dart';
import '../model/CustomerFeedbackModel.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      title: 'Customer Feedback',
      brandAppBar: true,
      scaffoldColor: SplashColors.scaffoldBg,
      body: Obx(() {
        final feedbackList = controller.feedbackList;

        if (feedbackList.isEmpty) {
          return Utils().noDataFound(context, true);
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _FeedbackCard(feedback: feedbackList[index]),
            );
          },
        );
      }),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({required this.feedback});

  final CustomerFeedback feedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SplashColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.rate_review_outlined,
                    color: SplashColors.primary,
                    size: 22,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    feedback.customerName ?? 'Unknown Customer',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: SplashColors.primary.withOpacity(0.1),
          ),
          SalesOrderDetailRow(
            label: 'Mobile',
            value: feedback.mobileNumber ?? 'N/A',
          ),
          SalesOrderDetailRow(
            label: 'Feedback',
            value: feedback.feedback ?? 'N/A',
          ),
          SalesOrderDetailRow(
            label: 'Date',
            value: feedback.dateTime ?? 'N/A',
          ),
        ],
      ),
    );
  }
}
