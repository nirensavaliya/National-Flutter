import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/profile/controllers/profile_controller.dart';
import '../../../commons/font_family.dart';
import '../../../commons/font_size.dart';
import '../../../commons/get_storage_data.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading:   IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title:  Text(
            "Profile",
            style: TextStyle(
              fontFamily: FontFamily.semiBold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                _showDeleteConfirmation(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            )
          ],
        )
      ),
      body: Obx(() {
        final profileData = controller.profile.value?.data;

        if (profileData == null) {
          return const Center(child: Text(""));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReadOnlyField("Customer Name", profileData.customerName ?? ""),
              _buildReadOnlyField("Address 1", profileData.address1 ?? ""),
              _buildReadOnlyField("Address 2", profileData.address2 ?? ""),
              _buildReadOnlyField("City", profileData.city ?? ""),
              _buildReadOnlyField("Area", profileData.area ?? ""),
              _buildReadOnlyField("Zipcode", profileData.zipcode ?? ""),
              _buildReadOnlyField("State", profileData.state ?? ""),
              _buildReadOnlyField("Country", profileData.countryName ?? ""),
              _buildReadOnlyField("Contact 1", profileData.contact1 ?? ""),
              _buildReadOnlyField("Contact 2", profileData.contact2 ?? ""),
              _buildReadOnlyField("Email", profileData.email ?? ""),
              _buildReadOnlyField("Contact Person", profileData.contactPerson ?? ""),
              _buildReadOnlyField("PAN Number", profileData.panNumber ?? ""),
              _buildReadOnlyField("GSTIN Number", profileData.gstinNumber ?? ""),
              _buildReadOnlyField("Customer GST Type", profileData.customerGSTType ?? ""),
/*
          GestureDetector(
            onTap: (){
              _showDeleteConfirmation(context);
            },
            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                decoration: ShapeDecoration(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)), side: BorderSide(color: Colors.red, width: 1)),
                  color: Colors.red.withOpacity(0.2),
                ),
                child:Center(
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),


            ),
          )
*/
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: FontSize.s18,
            color: Colors.black45,
          ),),
          SizedBox(height: 3,),
          TextFormField(
            initialValue: value,
            readOnly: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: FontSize.s16,
              fontFamily: FontFamily.bold,
            ),
            decoration: InputDecoration(
              border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo)),
            ),
          ),
        ],
      ),
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
          title:  Text('Delete Account Request' ,style: TextStyle(
            color: Colors.black,
            fontSize: FontSize.s18,
            fontFamily: FontFamily.bold,
          ),),
          content:  Text(
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
              child: Text("Cancel",style: TextStyle(
                  color: Colors.black
              ),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  )
              ),
              onPressed: () async {
                await controller.apiCallDeleteCustomer(
                  context: context,
                );
              },
              child: Text("Delete Account",style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        );
      },
    );
  }


}
