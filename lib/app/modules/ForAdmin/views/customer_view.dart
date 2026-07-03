import 'package:gurukrupa/app/commons/all.dart';
import 'package:gap/gap.dart';

import '../../../routes/app_pages.dart';
import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), // Custom AppBar height
          child: Container(
            color: Colors.white, // AppBar background color
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea( // Ensure AppBar contents don't overlap system UI
              child: Row(
                children: [
                  // Custom Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.back(); // Navigate to the previous screen
                    },
                  ),
                  const SizedBox(width: 8),
                  // Custom Title
                  const Text(
                    "Customer Action",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          children: List.generate(
            controller.CustomerPending.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    if (controller.CustomerPending[index].name ==
                        AppString.customerPending) {
                      Get.toNamed(Routes.PENDING_CUSTOMER);
                    } else if (controller.CustomerPending[index].name ==
                        AppString.customerFeedback) {
                      Get.toNamed(Routes.CUSTOMER_FEEDBACK);
                    }
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFF78829A))),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            controller.CustomerPending[index].image ?? "",
                            height: 30,
                          ),
                          Gap(8),
                          Text(
                            controller.CustomerPending[index].name ?? "",
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: FontFamily.medium,
                                fontSize: FontSize.s16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
