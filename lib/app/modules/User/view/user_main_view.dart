import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/customer/controllers/customer_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import 'package:marquee/marquee.dart';

import '../../../commons/all.dart';
import '../controller/user_controller.dart';


class UserMainHomeView extends GetView<UserMainController> {
  const UserMainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMainController>(
      builder: (controller) {
        return SafeArea(
          child: ListView(
            padding:
                EdgeInsets.fromLTRB(20, 30, 20, 20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.hiWelcomeBack,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s24,
                            fontFamily: FontFamily.bold,
                          ),
                        ),
                        // Text(
                        //   AppString.salesAndPurchase,
                        //   style: TextStyle(
                        //     color: Color(0xFF78829A),
                        //     fontSize: FontSize.s14,
                        //     fontFamily: FontFamily.semiBold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showLogoutDialog(context);

                      },
                      child: Icon(
                        Icons.login,
                        size: 30,
                        color: Colors.red,
                      )),
                ],
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  // Add your promotional banner click action here
                },
                child: Constants.promoMessageModel.message != "No promotional message available." ? Container(
                  margin: EdgeInsets.only(bottom: 20),  // Adjust spacing
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.orange.shade300,  // Background color
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 25,
                          child: Marquee(
                            text: Constants.promoMessageModel.message.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: FontFamily.bold
                            ),
                            scrollAxis: Axis.horizontal,
                            blankSpace: 50,
                            velocity: 30,
                            pauseAfterRound: Duration(seconds: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox(),  // If no message, hide the banner
              ),
              GestureDetector(
                onTap: () {
                  // Get.toNamed(Routes.ADD_SALE_ORDER_CUSTOMER);
                  Get.toNamed(Routes.SALES_ORDER);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Color(0xFF306FEA),
                        Color(0xFF7596F1),
                      ])),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.salesOrder,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                        // Gap(12),
                        // Text(
                        //   controller.todaySale,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: FontSize.s18,
                        //     fontFamily: FontFamily.semiBold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ITEM_LIST);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Color(0xFFF84664),
                        Color(0xFFF76980),
                      ])),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.itemList,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                        // Gap(12),
                        // Text(
                        //   controller.monthSale,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: FontSize.s18,
                        //     fontFamily: FontFamily.semiBold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LEDGER_STATEMENT);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Color(0xFFFBBC0E),
                        Color(0xFFFBBC0E),
                      ],),),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.ledgerStatement,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                        // Gap(12),
                        // Text(
                        //   controller.todayPurchase,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: FontSize.s18,
                        //     fontFamily: FontFamily.semiBold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ORDER_FROM_IMAGE);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Color(0xFF6D1514),
                        Color(0xFFC41B22),
                      ],),),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.orderFromImage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                        // Gap(12),
                        // Text(
                        //   controller.todayPurchase,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: FontSize.s18,
                        //     fontFamily: FontFamily.semiBold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.SALE_PERSON_VISIT_FROM_IMAGE);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Color(0xFFDB4708),
                        Color(0xFFF07039),
                      ],),),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.salesVisitFromImage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                        // Gap(12),
                        // Text(
                        //   controller.todayPurchase,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: FontSize.s18,
                        //     fontFamily: FontFamily.semiBold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.RECEIPT);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        Color(0xFF14186D),
                        Color(0xFF1B4BC4),
                      ],),),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.receipt,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Gap(20),

              Obx(() {
                print("Image URL: ${controller.offerImage.value}");
                if (controller.offerImage.value.isEmpty) {
                  return SizedBox();
                }
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: controller.offerImage.value,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                      fadeInDuration: Duration(milliseconds: 0),  // Instantly show the image
                      fadeOutDuration: Duration(milliseconds: 0),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                );
              }),

              // Gap(20),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(Routes.SHOW_REPORT,arguments: AppString.monthlyPurchase);
              //   },
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(12),
              //         gradient: LinearGradient(colors: [
              //           Color(0xFF0FA172),
              //           Color(0xFF44D2A4),
              //         ])),
              //     child: Padding(
              //       padding: EdgeInsets.all(12),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             AppString.monthlyPurchase,
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: FontSize.s14,
              //               fontFamily: FontFamily.semiBold,
              //             ),
              //           ),
              //           Gap(12),
              //           Text(
              //             controller.monthPurchase,
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: FontSize.s18,
              //               fontFamily: FontFamily.semiBold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // if(controller.isAdmin)
              // Gap(20),
              // if(controller.isAdmin)
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(Routes.CUSTOMER_VIEW);
              //   },
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(12),
              //         gradient: LinearGradient(colors: [
              //           Color(0xFF6D1514),
              //           Color(0xFFC41B22),
              //         ])),
              //     child: Padding(
              //       padding: EdgeInsets.all(12),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Check Pending Customers and Read Customers Feedback.",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: FontSize.s16,
              //               fontFamily: FontFamily.semiBold,
              //             ),
              //           ),
              //           // Gap(12),
              //           // Text(
              //           //   "Check Pending Customers and Read Customers Feedback.",
              //           //   style: TextStyle(
              //           //     color: Colors.white,
              //           //     fontSize: FontSize.s14,
              //           //     fontFamily: FontFamily.semiBold,
              //           //   ),
              //           // ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }


  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  )
              ),
              onPressed: () {
                GetStorageData.removeData(GetStorageData.token);
                GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
                GetStorageData.removeData(GetStorageData.isOtpVerified);
                GetStorageData.removeData(GetStorageData.isAdmin);
                GetStorageData.removeData(GetStorageData.isCustomer);
                GetStorageData.removeData(GetStorageData.isEmployee);
                Get.offAllNamed(Routes.LOGIN,arguments: {
                  'isEmployee': true, // Replace with the appropriate boolean value
                });
              },
              child: Text("Logout",style: TextStyle(
        color: Colors.white
        ),),
            ),
          ],
        );
      },
    );
  }


  Widget _buildGradientBox(String title, List<Color> colors) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(colors: colors),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: FontSize.s18,
            fontFamily: FontFamily.semiBold,
          ),
        ),
      ),
    );
  }
}


class LineGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Paint fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.4),
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path linePath = Path();
    Path fillPath = Path();

    // Start of the path (at the bottom-left corner)
    fillPath.moveTo(0, size.height);
    linePath.moveTo(0, size.height * 0.7);

    // Drawing the zigzag pattern
    linePath.lineTo(size.width * 0.1, size.height * 0.75);
    linePath.lineTo(size.width * 0.2, size.height * 0.65);
    linePath.lineTo(size.width * 0.3, size.height * 0.75);
    linePath.lineTo(size.width * 0.4, size.height * 0.6);
    linePath.lineTo(size.width * 0.5, size.height * 0.7);
    linePath.lineTo(size.width * 0.6, size.height * 0.65);
    linePath.lineTo(size.width * 0.7, size.height * 0.8);
    linePath.lineTo(size.width * 0.8, size.height * 0.7);
    linePath.lineTo(size.width * 0.9, size.height * 0.75);
    linePath.lineTo(size.width, size.height * 0.7);

    // Copying the line path to the fill path
    fillPath.addPath(linePath, Offset.zero);
    fillPath.lineTo(size.width, size.height); // Close to bottom-right
    fillPath.lineTo(0, size.height); // Close back to bottom-left
    fillPath.close();

    // Draw the filled area
    canvas.drawPath(fillPath, fillPaint);

    // Draw the white line path
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
