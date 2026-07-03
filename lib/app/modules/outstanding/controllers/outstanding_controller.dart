import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';
import '../model/outstanding_model.dart';
import '../model/outstanding_payables_model.dart';

class OutstandingController extends GetxController {
  String title = "";
  TextEditingController asPerDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String dateValue = DateTime.now().toString();

  @override
  void onInit() {

    if (Get.arguments != null) {
      title = Get.arguments;
    }
    if(title == AppString.outstandingReceivable)
      {
        asPerDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
        dateValue = DateFormat('yyyy-MM-dd').format(DateTime.now());
        outStandingListApi();
      }
    else
      {
        outStandingPayableListApi();
      }
    super.onInit();
  }

  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      final date = DateFormat("dd/MM/yyyy").format(picked).toString();
      dateValue = DateFormat("yyyy-MM-dd").format(picked).toString();
      asPerDateController.text = date;
      if(title == AppString.outstandingReceivable)
        {
          outStandingListApi();
        }
      else
        {
          outStandingPayableListApi();
        }
    }
  }

  List<OutStandingData> outStandingList = [];
  List<PayableData> outStandingPayableList = [];

  Future<void> outStandingListApi() async {
    String url = "${Constants.outstandingReceivables}?AsPerDate=$dateValue";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    GetOutstandingReceivablesModel model = GetOutstandingReceivablesModel.fromJson(responseData);
    if(model.statusCode == 200)
    {
      outStandingList = model.data ?? [];
      update();
    }
  }

  Future<void> outStandingPayableListApi() async {
    String url = "${Constants.outstandingPayables}?AsOnDate=$dateValue";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    GetOutstandingPayablesModel model = GetOutstandingPayablesModel.fromJson(responseData);
    if(model.statusCode == 200)
    {
      outStandingPayableList = model.data ?? [];
      update();
    }
  }


  void genarateRecivePDFApi() async {
    String url = "Reports/OutstandingReceivablesPDFurl?AsPer_Date=$dateValue";
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    // var responseData = data is String ? jsonDecode(data) : data;

    Get.toNamed(Routes.PDF_VIEW,    arguments: {
      "html": data,
      "fileName": "OutStanding_Receivable"
    },);

    // QuotationModel model = QuotationModel.fromJson(responseData);
    // if (model.statusCode == 200) {
    //
    //   downloadFile(model.data!.downloadurl!.split("/").last, model.data!.downloadurl);
    //   update();
    // }
  }

  void genaratePDFApi() async {
    String url = "Reports/OutstandingPayablesPDFurl?AsPerDate=$dateValue";
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    Get.toNamed(Routes.PDF_VIEW,    arguments: {
      "html": data,
      "fileName": "OutStanding_Payable"
    },);
    // var responseData = data is String ? jsonDecode(data) : data;
    //
    // QuotationModel model = QuotationModel.fromJson(responseData);
    // if (model.statusCode == 200) {
    //   downloadFile(model.data!.downloadurl!.split("/").last, model.data!.downloadurl);
    //   update();
    // }
  }

  downloadFile(var filePath, var documentUrl) async {
    try {
      print("downloadFile --- 1");
      /// setting filename
      final filename = filePath;
      String dir = "/storage/emulated/0/Download";
      print("downloadFile --- 2");
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      String url = documentUrl;

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      print("file path --- ${file.path}");
    }
    catch (err) {
      print("=-=-=-=-=-= 12=-=-=-=-${err}");
    }
  }
}
