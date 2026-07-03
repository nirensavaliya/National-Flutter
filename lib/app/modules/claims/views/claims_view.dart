import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../controllers/claims_controller.dart';
import 'claims_form_ui.dart';

class ClaimsView extends GetView<ClaimsController> {
  const ClaimsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimsController>(
      builder: (controller) {
        final claims = controller.filteredClaims;

        return CommonScreen(
          title: 'Claims',
          brandAppBar: true,
          scaffoldColor: const Color(0xFFF4F7F7),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const ClaimsHeaderCard(),
              const Gap(14),
              ClaimsToolbar(
                onNewClaim: () => showNewClaimDialog(controller),
              ),
              const Gap(14),
              if (claims.isEmpty)
                _emptyState()
              else
                ...claims.map((claim) => ClaimListCard(claim: claim)),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SplashColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48,
            color: SplashColors.primary.withOpacity(0.5),
          ),
          const Gap(12),
          Text(
            'No claims found',
            style: TextStyle(
              fontFamily: FontFamily.semiBold,
              fontSize: FontSize.s16,
              color: SplashColors.primaryDark,
            ),
          ),
          const Gap(6),
          Text(
            'Tap "New Claim" to submit a warranty claim',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.regular,
              fontSize: FontSize.s14,
              color: const Color(0xFF78829A),
            ),
          ),
        ],
      ),
    );
  }
}
