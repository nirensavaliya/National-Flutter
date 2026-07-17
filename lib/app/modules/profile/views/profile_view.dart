import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/profile/controllers/profile_controller.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      title: 'Profile',
      brandAppBar: true,
      scaffoldColor: SplashColors.scaffoldBg,
      actions: [
        IconButton(
          onPressed: () {
            _showDeleteConfirmation(context);
          },
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.redAccent,
            size: 24,
          ),
        ),
      ],
      body: Obx(() {
        final profileData = controller.profile.value?.data;

        if (profileData == null) {
          return const Center(child: Text(''));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            children: [
              SalesOrderFormSection(
                title: 'Customer Details',
                icon: Icons.person_outline,
                children: [
                  SalesOrderDetailRow(
                    label: 'Customer Name',
                    value: profileData.customerName,
                    highlight: true,
                  ),
                  SalesOrderDetailRow(
                    label: 'Contact 1',
                    value: profileData.contact1,
                  ),
                  SalesOrderDetailRow(
                    label: 'Contact 2',
                    value: profileData.contact2,
                  ),
                  SalesOrderDetailRow(
                    label: 'Email',
                    value: profileData.email,
                  ),
                  SalesOrderDetailRow(
                    label: 'Contact Person',
                    value: profileData.contactPerson,
                  ),
                ],
              ),
              const Gap(12),
              SalesOrderFormSection(
                title: 'Address',
                icon: Icons.location_on_outlined,
                children: [
                  SalesOrderDetailRow(
                    label: 'Address 1',
                    value: profileData.address1,
                  ),
                  SalesOrderDetailRow(
                    label: 'Address 2',
                    value: profileData.address2,
                  ),
                  SalesOrderDetailRow(
                    label: 'City',
                    value: profileData.city,
                  ),
                  SalesOrderDetailRow(
                    label: 'Area',
                    value: profileData.area,
                  ),
                  SalesOrderDetailRow(
                    label: 'Zipcode',
                    value: profileData.zipcode,
                  ),
                  SalesOrderDetailRow(
                    label: 'State',
                    value: profileData.state,
                  ),
                  SalesOrderDetailRow(
                    label: 'Country',
                    value: profileData.countryName,
                  ),
                ],
              ),
              const Gap(12),
              SalesOrderFormSection(
                title: 'Tax Information',
                icon: Icons.receipt_long_outlined,
                children: [
                  SalesOrderDetailRow(
                    label: 'PAN Number',
                    value: profileData.panNumber,
                  ),
                  SalesOrderDetailRow(
                    label: 'GSTIN Number',
                    value: profileData.gstinNumber,
                  ),
                  SalesOrderDetailRow(
                    label: 'Customer GST Type',
                    value: profileData.customerGSTType,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Delete Account Request',
            style: TextStyle(
              color: Colors.black,
              fontSize: FontSize.s18,
              fontFamily: FontFamily.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(
              fontFamily: FontFamily.light,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () async {
                await controller.apiCallDeleteCustomer(
                  context: context,
                );
              },
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
