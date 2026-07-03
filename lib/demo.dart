import 'package:gap/gap.dart';

import 'app/commons/all.dart';
import 'app/data/common_widget/common_button.dart';
import 'app/data/common_widget/common_textfeild.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController addDateController = TextEditingController();
  TextEditingController addSerialController = TextEditingController();
  TextEditingController addInvoiceTypeController = TextEditingController(text: "Bill of Supply");
  TextEditingController addCustomerNameController = TextEditingController();
  TextEditingController addGstController = TextEditingController(text: "5%");
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  TextEditingController addCreditDaysController = TextEditingController(text: "0");
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemDiscountPerController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();
  TextEditingController itemTotalDiscountController = TextEditingController();
  TextEditingController itemNetPriceController = TextEditingController();
  TextEditingController itemCGstPerController = TextEditingController();
  TextEditingController itemCGstAmtController = TextEditingController();
  TextEditingController itemSGstPerController = TextEditingController();
  TextEditingController itemSGstAmtController = TextEditingController();
  TextEditingController itemIGstPerController = TextEditingController();
  TextEditingController itemIGstAmtController = TextEditingController();
  TextEditingController itemTaxablePriceController = TextEditingController();
  TextEditingController itemNetAmountController = TextEditingController();
  TextEditingController itemGrossAmountController = TextEditingController();
  List gstList = [
    '1%',
    '5%',
    '12%',
    '18%',
    '28%',
    'Exempted',
    '3%',
  ];

  void calculateDiscount() {
    double originalPrice = double.tryParse(itemPriceController.text) ?? 0;
    double discountPercent = double.tryParse(itemDiscountPerController.text) ?? 0;

    itemGrossAmountController.text = (int.parse(itemQtyController.text) * double.parse(itemPriceController.text)).toStringAsFixed(3).toString();
    // double discountAmount = originalPrice * (discountPercent / 100);
    double discountAmount = discountPercent / 100 * originalPrice;
    itemTaxablePriceController.text = (double.parse(itemGrossAmountController.text) - discountAmount).toStringAsFixed(3).toString();
    print("(originalPrice - itemTotalDiscountController) -- ${discountAmount}");
    itemDiscountController.text = (discountAmount.toStringAsFixed(3)).toString();
    itemTotalDiscountController.text = (int.parse(itemQtyController.text) * discountAmount).toStringAsFixed(3).toString();

    setState(() {});
  }

  void calculateGST() {
    double itemPrice = double.tryParse(itemPriceController.text) ?? 0;
    double discountPrice = double.tryParse(itemDiscountController.text) ?? 0;
    double originalPrice = double.tryParse(itemTaxablePriceController.text) ?? 0;
    double totalGstPercent = double.tryParse(addGstController.text.replaceAll("%", "")) ?? 0;

    double cgstPercent = (totalGstPercent / 2);
    print("cgstPercent -- $totalGstPercent");
    double cgstAmount = itemPrice * (cgstPercent / 100);
    double sgstAmount = itemPrice * (cgstPercent / 100);
    double igstAmount = itemPrice * (totalGstPercent / 100);
    double temp = itemPrice / 100 * totalGstPercent;
    itemNetPriceController.text = (itemPrice + temp).toString();
    print('itemNetPriceController.text ---- ${itemNetPriceController.text} --- ${itemPrice}');

    itemCGstPerController.text = cgstPercent.toStringAsFixed(2).toString();

    itemSGstPerController.text = cgstPercent.toStringAsFixed(2).toString();

    itemIGstPerController.text = igstAmount.toStringAsFixed(2).toString();

    itemCGstAmtController.text = (int.parse(itemQtyController.text) * cgstAmount).toStringAsFixed(3).toString();

    itemSGstAmtController.text = (int.parse(itemQtyController.text) * sgstAmount).toStringAsFixed(3).toString();

    itemIGstAmtController.text = (int.parse(itemQtyController.text) * igstAmount).toStringAsFixed(3).toString();
    itemNetAmountController.text = (originalPrice + double.parse(itemCGstAmtController.text) + double.parse(itemSGstAmtController.text)).toStringAsFixed(2).toString();
    setState(() {});
  }

  calculateGstAndDiscount() {
    double itemPrice = double.tryParse(itemNetPriceController.text) ?? 0;
    double discountPercent = double.tryParse(itemDiscountPerController.text) ?? 0;
    double totalGstPercent = double.parse(addGstController.text.replaceAll("%", "")) ?? 0;
    double discountAmount = discountPercent / 100 * double.parse(itemPriceController.text);
    double temp = itemPrice * totalGstPercent / 100;
    itemDiscountController.text = (discountAmount.toStringAsFixed(3)).toString();
    itemTotalDiscountController.text = (int.parse(itemQtyController.text) * discountAmount).toStringAsFixed(3).toString();
    itemNetPriceController.text = (double.parse(itemPriceController.text) - discountAmount).toString();


    double cgstPercent = (totalGstPercent / 2);
    double cgstAmount = double.parse(itemNetPriceController.text) * cgstPercent / 100;
    double sgstAmount = double.parse(itemNetPriceController.text) * cgstPercent / 100;
    double igstAmount = double.parse(itemNetPriceController.text) * totalGstPercent / 100;

    itemCGstPerController.text = cgstPercent.toStringAsFixed(2).toString();

    itemSGstPerController.text = cgstPercent.toStringAsFixed(2).toString();

    itemIGstPerController.text = igstAmount.toStringAsFixed(2).toString();

    itemCGstAmtController.text = (int.parse(itemQtyController.text) * cgstAmount).toStringAsFixed(2).toString();

    itemSGstAmtController.text = (int.parse(itemQtyController.text) * sgstAmount).toStringAsFixed(2).toString();

    itemIGstAmtController.text = (int.parse(itemQtyController.text) * igstAmount).toStringAsFixed(2).toString();
    itemNetAmountController.text = (double.parse(itemTaxablePriceController.text) + double.parse(itemCGstAmtController.text) + double.parse(itemSGstAmtController.text)).toStringAsFixed(2).toString();
    itemGrossAmountController.text = (int.parse(itemQtyController.text) * double.parse(itemPriceController.text)).toStringAsFixed(3).toString();
    double discountPerItem = double.parse(itemNetPriceController.text) * cgstPercent / 100;
    itemNetPriceController.text = (double.parse(itemNetPriceController.text) + discountPerItem + discountPerItem).toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(12),
            Text(
              "dzxfs",
              style: TextStyle(
                fontSize: FontSize.s20,
                color: Colors.black,
                fontFamily: FontFamily.medium,
              ),
            ),
            Gap(10),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: itemDesController,
                    title: AppString.itemDec,
                    isTitle: true,
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: itemUnitController,
                    title: AppString.unit,
                    isTitle: true,
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: itemQtyController,
                    title: AppString.qty,
                    isTitle: true,
                    onChanged: (p0) {
                      calculateGstAndDiscount();
                    },
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: itemPriceController,
                    title: AppString.price,
                    isTitle: true,
                    onChanged: (p0) {
                      itemNetPriceController.text = itemPriceController.text;
                      calculateGstAndDiscount();
                    },
                  ),
                  Gap(10),
                  Text(
                    AppString.gstTax,
                    style: TextStyle(
                      fontFamily: FontFamily.medium,
                      fontSize: FontSize.s16,
                      color: Colors.black38,
                    ),
                  ),
                  Gap(8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        dense: true,
                        // key: Key(key.toString()),
                        onExpansionChanged: (value) {
                          print("value -- $value");
                        },
                        title: Text(
                          addGstController.text,
                        ),
                        children: List.generate(
                          gstList.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                addGstController.text = gstList[index] ?? "";

                                calculateGstAndDiscount();
                                // calculateDiscount();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  gstList[index] ?? "",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemDiscountPerController,
                          title: AppString.discountPer,
                          isTitle: true,
                          onChanged: (p0) {
                            calculateGstAndDiscount();
                            // calculateGST();
                          },
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemDiscountController,
                          title: AppString.discount,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemTotalDiscountController,
                          title: AppString.totalDiscount,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemNetPriceController,
                          title: AppString.netPrice,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemCGstPerController,
                          title: AppString.CGSTPer,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemCGstAmtController,
                          title: AppString.CGSTAmt,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                    ],
                  ),Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            borderRadius: 12,
                            controller: itemSGstPerController,
                            title: AppString.SGSTPer,
                            isTitle: true,
                            readOnly: true,
                            showCursor: false,
                          ),
                        ),
                        Gap(12),
                        Expanded(
                          child: CommonTextField(
                            borderRadius: 12,
                            controller: itemSGstAmtController,
                            title: AppString.SGSTAmt,
                            isTitle: true,
                            readOnly: true,
                            showCursor: false,
                          ),
                        ),
                      ],
                    ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemIGstPerController,
                          title: AppString.IGSTPer,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemIGstAmtController,
                          title: AppString.IGSTAmt,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: itemTaxablePriceController,
                    title: AppString.taxableAmount,
                    isTitle: true,
                    readOnly: true,
                    showCursor: false,
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemNetAmountController,
                          title: AppString.netAmount,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: CommonTextField(
                          borderRadius: 12,
                          controller: itemGrossAmountController,
                          title: AppString.grossAmount,
                          isTitle: true,
                          readOnly: true,
                          showCursor: false,
                        ),
                      ),
                    ],
                  ),
                  Gap(25),
                  CommonButton(
                    btnName: AppString.save,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Gap(30),
          ],
        ),
      ),
    );
  }
}
