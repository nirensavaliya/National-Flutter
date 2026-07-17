import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/api_common/loading.dart';
import 'package:http/http.dart' as http;

import '../../../commons/all.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_bar/model/get_item_list.dart';
import '../../customer/model/brand_list_model.dart';
import '../../customer/model/get_catefory_brand_list_model.dart';
import '../../pdf_view/model/pdf_model.dart';
import '../../quotation/controllers/quotation_controller.dart';
import '../../quotation/model/quotation_pdf_model.dart';
import '../model/get_item_list_model.dart';

class ItemListController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  var isLoading = false.obs;
  var isItemListLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMorePages = true.obs;
  var filteredCategoryBrands = <CategoryBrandData>[].obs;
  var filteredBrands = <BranddData>[].obs;
  List<BranddData> categoryWiseBrandList = [];
  TextEditingController itemSearchController = TextEditingController();
  var itemSearchQuery = ''.obs;
  Rx<CategoryBrandData> selectedCategoryBrandData = Rx<CategoryBrandData>(CategoryBrandData());
  Rx<BranddData> selectedBrandData = Rx<BranddData>(BranddData());
  final ScrollController scrollController = ScrollController();
  final int pageSize = 15;
  int pageNumber = 1;
  int selected = 0;
  int itemId = 0;
  int brandId = 0;
  int categoryId = 0;
  RxList<ItemListData> selectedItems = <ItemListData>[].obs;
  bool showAppBarSearch = false;

  bool get _usesPagingApi => selectedBrandData.value.brandID == null && selectedCategoryBrandData.value.categoryID == null;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onReady() {
    super.onReady();
    itemListApi();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    itemSearchController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (!_usesPagingApi || !hasMorePages.value || isLoadingMore.value) return;
    if (!scrollController.hasClients) return;
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      itemListApi(loadMore: true);
    }
  }

  void selectCategory(CategoryBrandData category) {
    selectedCategoryBrandData.value = category;
  }

  void selectBrand(BranddData category) {
    selectedBrandData.value = category;
  }

  bool isSelected(ItemListData item) {
    return selectedItems.contains(item);
  }

  void toggleSelection(ItemListData item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
      // itemQuantities.remove(item);
    } else {
      selectedItems.add(item);
      // itemQuantities[item] = -1;
    }
  }

  void toggleAppBarSearch() {
    showAppBarSearch = !showAppBarSearch;
    if (!showAppBarSearch) {
      clearItemSearch();
    }
    update();
  }

  void onItemSearch(String query) {
    itemSearchQuery.value = query.trim();
  }

  List<ItemListData> get displayedItems {
    final q = itemSearchQuery.value.toLowerCase();
    if (q.isEmpty) return itemList;
    return itemList
        .where((item) =>
    (item.itemName ?? '').toLowerCase().contains(q) ||
        (item.unitCode ?? '').toLowerCase().contains(q))
        .toList();
  }

  void clearItemSearch() {
    itemSearchController.clear();
    itemSearchQuery.value = '';
  }

  void filterItems(String query) {
    filteredItems = Constants.itemList;
    if (query.isEmpty) {
      filteredItems = Constants.itemList;
    } else {
      filteredItems = Constants.itemList
          .where((item) =>
              item.itemName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectItemName() {
    filteredItems = Constants.itemList;
    searchFieldController.clear();
    // final controller = Get.put(ItemListController());
    Get.bottomSheet(
      GetBuilder<ItemListController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  CommonTextField(
                    controller: searchFieldController,
                    borderRadius: 12,
                    prefix: Icon(Icons.search),
                    onChanged: (p0) {
                      filterItems(p0);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            onTap: ()async {
                              itemNameController.text =
                                  filteredItems[index].itemName ?? "";
                              itemId = filteredItems[index].itemid ?? 0;

                              Get.back();

                              Future.delayed(Duration(milliseconds: 100), () async {
                                await controller.itemListApi();
                                controller.update();
                              });
                              // update();
                              // Get.back();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(7)),
                              child: commonTableText(
                                  title: filteredItems[index].itemName ?? ""),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void categoryFilter(String query) {
    if (query.isEmpty) {
      filteredCategoryBrands.value = Constants.categoryBrandList;
    } else {
      filteredCategoryBrands.value = Constants.categoryBrandList
          .where((category) => category.categoryName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void brandFilter(String query) {
    final source = _activeBrandSource;
    if (query.isEmpty) {
      filteredBrands.value = Constants.brandList;
    } else {
      filteredBrands.value = Constants.brandList
          .where((brand) => brand.brandName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> onCategorySelected(
      BuildContext context,
      CategoryBrandData category,
      ) async {
    selectCategory(category);
    selectedBrandData.value = BranddData();
    brandController.clear();
    if (category.categoryID != null) {
      await getBrandListByCategoryApi(context, category.categoryID!);
    }
    await itemListApi();
  }



  Future<void> clearCategorySelection() async {
    selectedCategoryBrandData.value = CategoryBrandData();
    selectedBrandData.value = BranddData();
    brandController.clear();
    categoryWiseBrandList.clear();
    filteredBrands.value = Constants.brandList;
    clearItemSearch();
    await itemListApi();
  }

  // void selectBrand() {
  //   filteredItems = Constants.itemList;
  //   searchFieldController.clear();
  //   Get.bottomSheet(
  //     GetBuilder<ItemListController>(
  //       builder: (controller) {
  //         return DecoratedBox(
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
  //           child: Padding(
  //             padding: EdgeInsetsGeometry.symmetric(horizontal: 20,vertical: 12),
  //             // padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
  //             child: ListView.builder(
  //               itemCount: brandList.length,
  //               shrinkWrap: true,
  //               padding: EdgeInsets.zero,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: EdgeInsets.only(top: 15),
  //                   child: GestureDetector(
  //                     onTap: () async{
  //                       brandController.text = brandList[index].brandName ?? "";
  //                       brandId = brandList[index].brandID ?? 0;
  //                       Get.back();
  //
  //                       Future.delayed(Duration(milliseconds: 100), () async {
  //                         await controller.itemListApi();
  //                         controller.update();
  //                       });
  //                       // Get.back();
  //                       // await itemListApi();
  //                       // controller.update();
  //                     },
  //                     child: DecoratedBox(
  //                       decoration: BoxDecoration(
  //                           border: Border.all(),
  //                           borderRadius: BorderRadius.circular(7)),
  //                       child: commonTableText(
  //                           title: brandList[index].brandName ?? ""),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void selectCategory() {
  //   Get.bottomSheet(
  //     GetBuilder<ItemListController>(
  //       builder: (controller) {
  //         return DecoratedBox(
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
  //           child: Padding(
  //             padding: EdgeInsetsGeometry.symmetric(horizontal: 20,vertical: 12),
  //             child: ListView.builder(
  //               itemCount: categoryList.length,
  //               shrinkWrap: true,
  //               padding: EdgeInsets.zero,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: EdgeInsets.only(top: 15),
  //                   child: GestureDetector(
  //                     onTap: ()async {
  //                       categoryController.text =
  //                           categoryList[index].categoryName ?? "";
  //                       categoryId = categoryList[index].categoryID ?? 0;
  //                       Get.back();
  //
  //                       Future.delayed(Duration(milliseconds: 100), () async {
  //                         await controller.itemListApi();
  //                         controller.update();
  //                       });
  //                     },
  //                     child: DecoratedBox(
  //                       decoration: BoxDecoration(
  //                           border: Border.all(),
  //                           borderRadius: BorderRadius.circular(7)),
  //                       child: commonTableText(
  //                           title: categoryList[index].categoryName ?? ""),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Future<void> ensureFilterListsLoaded() async {
    final context = Get.context;
    if (context == null) return;

    final futures = <Future<void>>[];
    if (Constants.categoryBrandList.isEmpty) {
      futures.add(getCategoryListApi(context));
    }
    if (Constants.brandList.isEmpty) {
      futures.add(getBrandListApi(context));
    }
    if (futures.isNotEmpty) {
      await Future.wait(futures);
    }
  }

  Future<void> getBrandListApi(BuildContext context) async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getBrandList,
      context: context,

    );
    var responseData = data is String ? jsonDecode(data) : data;

    GetBranddListModel model = GetBranddListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.brandList = model.data ?? [];
    }
  }

  Future<void> getBrandListByCategoryApi(
      BuildContext context,
      int categoryId,
      ) async {
    final data = await GetAPIFunction().apiCall(
      apiName: '${Constants.getBrandList}?CategoryId=$categoryId',
      context: context,
    );
    var responseData = data is String ? jsonDecode(data) : data;
    GetBranddListModel model = GetBranddListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      categoryWiseBrandList = model.data ?? [];
      filteredBrands.value = categoryWiseBrandList;
    }
  }

  List<BranddData> get _activeBrandSource {
    if (selectedCategoryBrandData.value.categoryID != null) {
      return categoryWiseBrandList;
    }
    return Constants.brandList;
  }

  Future<void> getCategoryListApi(BuildContext context) async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getCategoryList,
      context: context,

    );
    var responseData = data is String ? jsonDecode(data) : data;

    GetCategoryBrandListModel model =
        GetCategoryBrandListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.categoryBrandList = model.data ?? [];
    }
  }

  // List<ItemListData> itemList = [];
  var itemList = <ItemListData>[].obs;


  // Future<void> itemListApi() async {
  //   String url = "${Constants.itemListApi}?";
  //
  //   if (itemId != 0) {
  //     url = url + "&" + "itemid=${itemId}";
  //   }
  //   if (brandId != 0) {
  //     url = url + "&" + "Brandid=${brandId}";
  //   }
  //   if (categoryId != 0) {
  //     url = url + "&" + "Categoryid=${categoryId}";
  //   }
  //   final data = await GetAPIFunction().apiCall(
  //     apiName: url,
  //     context: Get.context!,
  //   );
  //
  //   GetReportItemListModel model = GetReportItemListModel.fromJson(data);
  //   if (model.statusCode == 200) {
  //     itemList = model.data ?? [];
  //     update();
  //   }
  // }

  // Future<void> itemListApi() async {
  //   try {
  //     // isLoading.value = true;
  //
  //     // String url = "${Constants.itemListApi}?";
  //     //
  //     // if (itemId != 0) {
  //     //   url += "&itemid=$itemId";
  //     // }
  //     // if (brandId != 0) {
  //     //   url += "&Brandid=$brandId";
  //     // }
  //     // if (categoryId != 0) {
  //     //   url += "&Categoryid=$categoryId";
  //     // }
  //
  //     String url;
  //
  //     // if (selectedBrandData.value.brandID == null && selectedCategoryBrandData.value.categoryID == null) {
  //     //   url = "${Constants.itemListApi}";
  //     // } else
  //     if (selectedBrandData.value.brandID == null && selectedCategoryBrandData.value.categoryID == null)
  //       {
  //         itemList.clear();
  //         Get.snackbar("Error", "Please select a Brand ID or Category ID");
  //         return;
  //       }else if (selectedBrandData.value.brandID != null && selectedCategoryBrandData.value.categoryID == null) {
  //       url =
  //       "${Constants.itemListApi}?Brandid=${selectedBrandData.value.brandID}";
  //     } else if (selectedBrandData.value.brandID != null && selectedCategoryBrandData.value.categoryID != null) {
  //       url =
  //       "${Constants.itemListApi}?Brandid=${selectedBrandData.value.brandID}&Categoryid=${selectedCategoryBrandData.value.categoryID}";
  //     } else if (selectedBrandData.value.brandID == null && selectedCategoryBrandData.value.categoryID != null) {
  //       url =
  //       "${Constants.itemListApi}?Categoryid=${selectedCategoryBrandData.value.categoryID}";
  //     } else {
  //       url =
  //       "${Constants.itemListApi}?Brandid=${selectedBrandData.value.brandID}&Categoryid=${selectedCategoryBrandData.value.categoryID}";
  //     }
  //
  //     Loading.show();
  //     print('-----Okay--0---');
  //
  //     final data = await GetAPIFunction().apiCall(
  //       apiName: url,
  //       context: Get.context!,
  //     );
  //     var responseData = data is String ? jsonDecode(data) : data;
  //
  //     GetReportItemListModel model = GetReportItemListModel.fromJson(responseData);
  //     if (model.statusCode == 200) {
  //       // itemList = model.data ?? [];
  //       //
  //       // itemList.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
  //       print('-----Okay--1---');
  //       Loading.dismiss();
  //
  //         itemList.value = model.data ?? [];
  //
  //         // Optional sort
  //         itemList.sort((a, b) => a.itemName!.toLowerCase().compareTo(b.itemName!.toLowerCase()));
  //
  //     } else {
  //       log('ERROR-Failed to load data}');
  //       Loading.dismiss();
  //       print('-----Okay--2---');
  //
  //
  //     }
  //   } catch (e) {
  //     log('ERROR-Something went wrong${e}');
  //     Loading.dismiss();
  //     print('-----Okay--3---');
  //
  //
  //   }
  //   // finally {
  //   //   isLoading.value = false;
  //   // }
  // }

  Future<void> itemListApi({bool loadMore = false}) async {
    if (_usesPagingApi) {
      if (loadMore) {
        if (!hasMorePages.value || isLoadingMore.value || isItemListLoading.value) {
          return;
        }
      } else if (isItemListLoading.value) {
        return;
      }
    } else if (isItemListLoading.value) {
      return;
    }

    final context = Get.context;
    if (context == null) return;

    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isItemListLoading.value = true;
        pageNumber = 1;
        hasMorePages.value = true;
        clearItemSearch();
        if (_usesPagingApi) {
          itemList.clear();
        }
      }

      String url;
      final bool noBrand = selectedBrandData.value.brandID == null;
      final bool noCategory = selectedCategoryBrandData.value.categoryID == null;

      if (noBrand && noCategory) {
        url =
            '${Constants.GetItemListByBrandandCategoryPaging}?PageNumber=$pageNumber&PageSize=$pageSize';
      } else if (!noBrand && noCategory) {
        url = "${Constants.itemListApi}?Brandid=${selectedBrandData.value.brandID}";
      } else if (!noBrand && !noCategory) {
        url =
        "${Constants.itemListApi}?Brandid=${selectedBrandData.value.brandID}&Categoryid=${selectedCategoryBrandData.value.categoryID}";
      } else {
        url =
        "${Constants.itemListApi}?Categoryid=${selectedCategoryBrandData.value.categoryID}";
      }

      final data = await GetAPIFunction().apiCall(
        apiName: url,
        context: context,
        // isLoading: false,
      );
      var responseData = data is String ? jsonDecode(data) : data;

      if (noBrand && noCategory) {
        final model =
            GetItemListModel.fromJson(_normalizePagingResponse(responseData));
        if (model.statusCode == 200) {
          final mapped = (model.data ?? []).map((e) {
            return ItemListData(
              itemid: e.itemid,
              itemName: e.itemName,
              unitCode: e.unitCode,
              price: e.price,
              itemImage: e.imageUrl,
            );
          }).toList();

          if (loadMore) {
            itemList.addAll(mapped);
          } else {
            itemList.value = mapped;
            clearItemSearch();
          }

          _updateHasMorePages(responseData, mapped.length);
        }
      } else {
        GetReportItemListModel model = GetReportItemListModel.fromJson(responseData);
        if (model.statusCode == 200) {
          itemList.value = model.data ?? [];
          itemList.sort((a, b) =>
              (a.itemName ?? '').toLowerCase().compareTo((b.itemName ?? '').toLowerCase()));
          clearItemSearch();
        }
        hasMorePages.value = false;
      }
    } catch (e) {
      log('ERROR-Something went wrong $e');
    } finally {
      isItemListLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Map<String, dynamic> _normalizePagingResponse(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      return {};
    }
    if (responseData['data'] is List) {
      return responseData;
    }
    if (responseData['data'] is Map<String, dynamic>) {
      final nested = responseData['data'] as Map<String, dynamic>;
      final list = nested['items'] ?? nested['list'] ?? nested['data'];
      if (list is List) {
        return {...responseData, 'data': list};
      }
    }
    return responseData;
  }

  void _updateHasMorePages(Map<String, dynamic> responseData, int fetchedCount) {
    final totalPages = _readPagingInt(responseData['totalPages']);
    final totalCount = _readPagingInt(responseData['totalCount']) ??
        _readPagingInt(responseData['totalRecords']) ??
        _readPagingInt(responseData['totalItems']);

    if (responseData['data'] is Map<String, dynamic>) {
      final nested = responseData['data'] as Map<String, dynamic>;
      final nestedTotalPages = _readPagingInt(nested['totalPages']);
      final nestedTotalCount = _readPagingInt(nested['totalCount']) ??
          _readPagingInt(nested['totalRecords']) ??
          _readPagingInt(nested['totalItems']);
      if (nestedTotalPages != null) {
        hasMorePages.value = pageNumber < nestedTotalPages;
      } else if (nestedTotalCount != null) {
        hasMorePages.value = itemList.length < nestedTotalCount;
      } else {
        hasMorePages.value = fetchedCount >= pageSize;
      }
    } else if (totalPages != null) {
      hasMorePages.value = pageNumber < totalPages;
    } else if (totalCount != null) {
      hasMorePages.value = itemList.length < totalCount;
    } else {
      hasMorePages.value = fetchedCount >= pageSize;
    }

    if (hasMorePages.value) {
      pageNumber++;
    }
  }

  int? _readPagingInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }


  void genaratePDFApi() async {
    try {
      String url;

      if (selectedBrandData.value.brandID == null &&
          selectedCategoryBrandData.value.categoryID == null) {
        Get.snackbar("Error", "Please select a Brand or Category");
        return;
      } else if (selectedBrandData.value.brandID != null &&
          selectedCategoryBrandData.value.categoryID == null) {
        url = "Reports/ItemListPDFurl?Brandid=${selectedBrandData.value.brandID}";
      } else if (selectedBrandData.value.brandID != null &&
          selectedCategoryBrandData.value.categoryID != null) {
        url =
        "Reports/ItemListPDFurl?Brandid=${selectedBrandData.value.brandID}&Categoryid=${selectedCategoryBrandData.value.categoryID}";
      } else {
        url =
        "Reports/ItemListPDFurl?Categoryid=${selectedCategoryBrandData.value.categoryID}";
      }

      print('PDF URL ---- $url');

      final data = await GetAPIFunction().apiCall(
        apiName: url,
        context: Get.context!,
      );

      Get.toNamed(Routes.PDF_VIEW, arguments: {
        "html": data,
        "fileName": "Item_List"
      });

      // var responseData = data is String ? jsonDecode(data) : data;
      // PdfModel model = PdfModel.fromJson(responseData);
      //
      // if (model.statusCode == 200) {
      //
      // } else {
      //   Get.snackbar("Error", model.responseMsg ?? "PDF generate failed");
      // }
    } catch (e) {
      log('PDF ERROR: $e');
      Get.snackbar("Error", "Something went wrong");
    }
  }

  // void genaratePDFApi() async {
  //   String url = "Reports/ItemListPDFurl?";
  //
  //   if (itemId != 0) {
  //     url = url + "&" + "itemid=${itemId}";
  //   }
  //   if (brandId != 0) {
  //     url = url + "&" + "Brandid=${brandId}";
  //   }
  //   if (categoryId != 0) {
  //     url = url + "&" + "Categoryid=${categoryId}";
  //   }
  //   print('data ---- ${url}');
  //
  //   final data = await GetAPIFunction().apiCall(
  //     apiName: url,
  //     context: Get.context!,
  //   );
  //
  //   print('data ---- ${data}');
  //   PdfModel model = PdfModel.fromJson(data);
  //   Loading.show();
  //   Future.delayed(
  //     Duration(seconds: 2),
  //     () {
  //       Loading.dismiss();
  //       Get.toNamed(Routes.PDF_VIEW, arguments: {
  //         "html": model.data,
  //         "fileName": "Item_List"
  //       });
  //     },
  //   );
  //   if (data.statusCode == 200) {
  //     update();
  //   }
  // }
}

Widget commonTableText({String? title, bool? isLight, bool? isEnd}) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(
      title ?? "",
      textAlign: isEnd == true ? TextAlign.end : TextAlign.start,
      style: TextStyle(
        fontSize: FontSize.s16,
        color: isLight == true ? Colors.black45 : Colors.black,
        fontFamily: FontFamily.medium,
      ),
    ),
  );
}
