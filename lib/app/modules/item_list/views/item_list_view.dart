import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_textfeild.dart';
import '../../customer/model/brand_list_model.dart';
import '../../customer/model/get_catefory_brand_list_model.dart';
import '../../quotation/controllers/quotation_controller.dart';
import '../controllers/item_list_controller.dart';
import '../model/get_item_list_model.dart';

class ItemListView extends GetView<ItemListController> {
  const ItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    // final itemController = Get.put(ItemListController());
    return GetBuilder<ItemListController>(
      builder: (itemController) {
        return CommonScreen(
          title: controller.showAppBarSearch ? null : AppString.itemList,
            titleWidget: controller.showAppBarSearch
                ? TextField(
              controller: controller.itemSearchController,
              autofocus: true,
              onChanged: controller.onItemSearch,
              style: TextStyle(
                fontSize: FontSize.s16,
                fontFamily: FontFamily.medium,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Search item...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  // Rounded corners
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            )
                : null,
          actions: [
            IconButton(
              icon: Icon(
                controller.showAppBarSearch ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: controller.toggleAppBarSearch,
            ),
            controller.itemId != 0 ||
                    controller.brandId != 0 ||
                    controller.categoryId != 0
                ? GestureDetector(
                    onTap: () async {
                      controller.itemId = 0;
                      controller.itemNameController.clear();
                      controller.itemList.clear();
                      controller.brandId = 0;
                      controller.brandController.clear();
                      controller.categoryId = 0;
                      controller.categoryController.clear();
                      controller.update();

                      Future.delayed(Duration(milliseconds: 100), () {
                        controller.itemListApi();
                      });
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        color: Colors.redAccent,
                        fontFamily: FontFamily.medium,
                      ),
                    ),
                  )
                : SizedBox(),
            Gap(20),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                // CommonTextField(
              //   borderRadius: 12,
              //   controller: controller.itemNameController,
              //   title: AppString.itemList,
              //   isTitle: true,
              //   maxLength: 10,
              //   hintText: "Please Select...",
              //   showCursor: false,
              //   readOnly: true,
              //   onTap: () {
              //     controller.selectItemName();
              //   },
              //   suffix: RotatedBox(
              //       quarterTurns: 1,
              //       child: Icon(
              //         Icons.arrow_forward_ios,
              //         size: 20,
              //       )),
              // ),
              Gap(10),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: GestureDetector(
                  onTap: () {
                    // Open Category Selection Bottom Sheet
                    openCategorySelection(controller);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Use Obx to listen for changes in selectedCategoryBrandData
                          Obx(() {
                            final selectedCategory =
                                controller.selectedCategoryBrandData.value;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Display selected category name or the default text
                                    Text(
                                      selectedCategory.categoryName ??
                                          "Select Category",
                                      style: TextStyle(  fontFamily: FontFamily.semiBold,
                                          fontSize: FontSize.s16,color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),

                          // Show either dropdown or cancel button based on selection
                          Obx(() {
                            final hasCategory = controller
                                .selectedCategoryBrandData
                                .value
                                .categoryName !=
                                null;
                            return GestureDetector(
                              onTap: () async {
                                if (hasCategory) {
                                  await controller.clearCategorySelection();

                                  // // Reset category selection
                                  // controller.selectedCategoryBrandData.value =
                                  //     CategoryBrandData();
                                  // // controller.validationForApiCall();
                                  // Future.delayed(Duration(milliseconds: 100), () async {
                                  //   await controller.itemListApi();
                                  //   controller.update();
                                  // });
                                }
                              },
                              child: Icon(
                                hasCategory
                                    ? Icons.cancel
                                    : Icons
                                    .arrow_drop_down, // Change icon dynamically
                                color: Colors.black54,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Brand Selection TextField
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: GestureDetector(
                  onTap: () {
                    // Open Category Selection Bottom Sheet
                    openBrandSelection(controller);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Use Obx to listen for changes in selectedCategoryBrandData
                          Obx(() {
                            final selectedCategory =
                                controller.selectedBrandData.value;
                            return Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Display selected category name or the default text
                                  Text(
                                    selectedCategory.brandName ??
                                        "Select Brand",
                                    style: TextStyle(  fontFamily: FontFamily.semiBold,
                                        fontSize: FontSize.s16,color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }),
                          Obx(() {
                            final hasCategory =
                                controller.selectedBrandData.value.brandName !=
                                    null;
                            return GestureDetector(
                              onTap: () {
                                if (hasCategory) {
                                  // Reset category selection
                                  controller.selectedBrandData.value =
                                      BranddData();
                                  // controller.validationForApiCall();
                                  Future.delayed(Duration(milliseconds: 100), () async {
                                    await controller.itemListApi();
                                    controller.update();
                                  });
                                }
                              },
                              child: Icon(
                                hasCategory
                                    ? Icons.cancel
                                    : Icons
                                    .arrow_drop_down, // Change icon dynamically
                                color: Colors.black54,
                              ),
                            );
                          }),
                          // Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Obx(() {
                // if (controller.isItemListLoading.value &&
                //     controller.itemList.isEmpty) {
                //   return const Expanded(
                //     child: Center(child: CircularProgressIndicator()),
                //   );
                // }

                final items = controller.displayedItems;
                final hasItems = items.isNotEmpty;
                final isSearching = controller.itemSearchQuery.value.isNotEmpty;

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.itemList.isNotEmpty) Gap(20),
                      if (controller.itemList.isNotEmpty)
                        CommonButton(
                          btnName: AppString.downloadPdf,
                          onTap: () => controller.genaratePDFApi(),
                        ),
                      if (controller.itemList.isNotEmpty) Gap(20),
                      if (isSearching && items.isEmpty)
                        const Expanded(
                          child: Center(child: Text("No item found")),
                        ),
                      Expanded(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: items.length +
                              (!isSearching && controller.isLoadingMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            // if (index >= controller.itemList.length) {
                            //   return const Padding(
                            //     padding: EdgeInsets.all(16),
                            //     child: Center(
                            //       child: SizedBox()
                            //     ),
                            //   );
                            // }

                            final model = items[index];
                            final isSelected = controller.isSelected(model);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    useSafeArea: true,
                                    barrierDismissible: true,
                                    builder: (_) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Center(child: Text("Item Details")),
                                      content: SizedBox(
                                        width: double.maxFinite,
                                        child: selectedItemView(controller, model),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected ? Colors.blue : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: isSelected
                                        ? Colors.blue.withOpacity(0.2)
                                        : Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(7, 3, 5, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: _buildItemImage(
                                            model,
                                            width: 60,
                                            height: 60,
                                            placeholderWidth: 40,
                                            placeholderHeight: 40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.itemName ?? "",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: FontFamily.semiBold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Price: ₹${model.price ?? "0.00"}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: FontFamily.medium,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              })
              ],
            ),
          ),
        );
      },
    );
  }

  void openCategorySelection(ItemListController controller) async {
    await controller.ensureFilterListsLoaded();
    controller.filteredCategoryBrands.value =
        Constants.categoryBrandList; // Initialize observable list

    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "Select Category",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: Colors.black, height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  onChanged: (value) {
                    controller.categoryFilter(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Enter here to search",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10, right: 6),
                      child: Icon(Icons.search, size: 26, color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Gap(10),
              // Obx(() {
              //   return Expanded(
              //     child: ListView.builder(
              //       itemCount: controller.filteredCategoryBrands.length,
              //       // Use observable
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       itemBuilder: (context, index) {
              //         final category = controller.filteredCategoryBrands[index];
              //         return Padding(
              //           padding: EdgeInsets.only(bottom: 12),
              //           child: GestureDetector(
              //             onTap: () {
              //               controller.selectCategory(category);
              //               controller.validationForApiCall();
              //               Get.back();
              //             },
              //             child: DecoratedBox(
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Colors.grey),
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: Row(
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.all(3.0),
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(12),
              //                       child: Image.network(
              //                         category.imageUrl!,
              //                         width: 60,
              //                         height: 60,
              //                         fit: BoxFit.fill,
              //                         errorBuilder:
              //                             (context, error, stackTrace) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(5.0),
              //                             child: Image.asset(
              //                               AppImages.appIcon_g,
              //                               width: 40,
              //                               height: 40,
              //                               fit: BoxFit.fill,
              //                             ),
              //                           );
              //                         },
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(width: 12),
              //                   Expanded(
              //                     child: Text(
              //                       category.categoryName!,
              //                       style: TextStyle(
              //                         fontSize: 16,
              //                         color: Colors.black,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   );
              // }),

              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    itemCount: controller.filteredCategoryBrands.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final category = controller.filteredCategoryBrands[index];

                      return GestureDetector(
                        onTap: () {
                          controller.selectCategory(category);
                          // controller.validationForApiCall();
                          Future.delayed(Duration(milliseconds: 100), () async {
                            await controller.itemListApi();
                            controller.update();
                          });
                          Get.back();
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ✅ Image at top (no padding)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  category.imageUrl ?? '',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppImages.appIcon_g,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),

                              // Space between image & text
                              const SizedBox(height: 6),

                              // ✅ Text below image (no padding wrapper)
                              Text(
                                category.categoryName ?? '',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void openBrandSelection(ItemListController controller) async {
    await controller.ensureFilterListsLoaded();
    final categoryId =
        controller.selectedCategoryBrandData.value.categoryID;
    if (categoryId != null) {
      await controller.getBrandListByCategoryApi(
        Get.context!,
        categoryId,
      );
    } else {
      controller.filteredBrands.value = Constants.brandList;
    }

    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "Select Brand",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: Colors.black, height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  onChanged: (value) {
                    controller
                        .brandFilter(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Enter brand to search",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10, right: 6),
                      child: Icon(Icons.search, size: 26, color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Gap(10),

              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    itemCount: controller.filteredBrands.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final brand = controller.filteredBrands[index];

                      return GestureDetector(
                        onTap: () {
                          controller.selectBrand(brand);
                          // controller.validationForApiCall();
                          Future.delayed(Duration(milliseconds: 100), () async {
                            await controller.itemListApi();
                            controller.update();
                          });

                          Get.back();
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    brand.imageUrl ?? '',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                          AppImages.appIcon_g,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  brand.brandName ?? '',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              })


            ],
          ),
        ),
      ),
    );
  }

  Widget selectedItemView(ItemListController controller, ItemListData model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildItemImage(
                  model,
                  width: 120,
                  height: 120,
                  placeholderWidth: 100,
                  placeholderHeight: 100,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildDetailRow("Item Name", model.itemName ?? "-"),
            _buildDetailRow("Item Code", model.itemCode ?? "-"),
            _buildDetailRow("Unit Code", model.unitCode ?? "-"),
            _buildDetailRow("Basic Price", (model.finalCost?.toString() ?? "-") ),
            _buildDetailRow("Purchase Price", model.purchasePrice?.toString() ?? "-"),
            _buildDetailRow(
                "Purchase VAT AMT", model.purchaseVATamt?.toString() ?? "-"),
            _buildDetailRow("Discount", model.discount?.toString() ?? "-"),
            _buildDetailRow("Item Value", model.price?.toString() ?? "-"),
            _buildDetailRow("Stock Qty.", model.stockQty?.toString() ?? "-"),
            _buildDetailRow("Brand Name", model.brandName ?? "-"),
            _buildDetailRow("Category", model.name ?? "-"),
            _buildDetailRow("SubCategory Name", model.subCategory ?? "-"),
            _buildDetailRow("Barcode No.", model.defaultBarcodeNo ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage(
    ItemListData model, {
    required double width,
    required double height,
    required double placeholderWidth,
    required double placeholderHeight,
  }) {
    final url = model.displayImageUrl;
    if (url == null) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          AppImages.appIcon_g,
          width: placeholderWidth,
          height: placeholderHeight,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            AppImages.appIcon_g,
            width: placeholderWidth,
            height: placeholderHeight,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? "-",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget tableView() {
    return GetBuilder<ItemListController>(
      builder: (controller) {
        return ListView.builder(
          key: Key('builder ${controller.selected.toString()}'),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.itemList.length,
          itemBuilder: (context, index) {
            ItemListData model = controller.itemList[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    dense: true,
                    key: Key(index.toString()),
                    initiallyExpanded: index == controller.selected,
                    onExpansionChanged: (value) {
                      if (value) {
                        Duration(seconds: 20000);
                        controller.selected = index;
                      } else
                        controller.selected = -1;
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.itemName ?? "-",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s18,
                            fontFamily: FontFamily.medium,
                          ),
                        ),
                        Text(
                          model.finalCost?.toString() ?? "-",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: FontSize.s16,
                            fontFamily: FontFamily.medium,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Table(
                        border: TableBorder.all(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12))),
                        children: [
                          TableRow(
                            children: [
                              commonTableText(title: "Item Name"),
                              commonTableText(
                                  title: model.itemName, isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Item Code"),
                              commonTableText(
                                  title: model.itemCode ?? "-", isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Unit Code"),
                              commonTableText(
                                  title: model.unitCode ?? "-", isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Basic price"),
                              commonTableText(
                                  title: model.finalCost?.toString() ?? "-",
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Purchase Price"),
                              commonTableText(
                                  title: model.purchasePrice?.toString() ?? "-",
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Purchase Vat AMT"),
                              commonTableText(
                                  title: model.purchaseVATamt?.toString() ?? "-",
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Discount"),
                              commonTableText(
                                  title: model.discount?.toString() ?? "-",
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Item Value"),
                              commonTableText(
                                  title: model.price?.toString() ?? "-", isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Stock Qty."),
                              commonTableText(
                                  title: model.stockQty?.toString() ?? "-",
                                  isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Brand name"),
                              commonTableText(
                                  title: model.brandName ?? "-", isEnd: true),
                            ],
                          ),
                          // TableRow(
                          //   children: [
                          //     commonTableText(title: "Subbrand Name"),
                          //     commonTableText(
                          //         title: model.su, isEnd: true),
                          //   ],
                          // ),
                          TableRow(
                            children: [
                              commonTableText(title: "Category"),
                              commonTableText(title: model.name ?? "-", isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "SubCatgeory Name"),
                              commonTableText(
                                  title: model.subCategory ?? "-", isEnd: true),
                            ],
                          ),
                          TableRow(
                            children: [
                              commonTableText(title: "Barcode No."),
                              commonTableText(
                                  title: model.defaultBarcodeNo ?? "-", isEnd: true),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
