import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotoko/controller/account_controller.dart';
import 'package:gotoko/controller/expense_controller.dart';
import 'package:gotoko/controller/income_controller.dart';
import 'package:gotoko/util/dimensions.dart';
import 'package:gotoko/util/images.dart';
import 'package:gotoko/util/styles.dart';
import 'package:gotoko/view/base/custom_app_bar.dart';
import 'package:gotoko/view/base/custom_date_picker.dart';
import 'package:gotoko/view/base/custom_drawer.dart';
import 'package:gotoko/view/base/custom_header.dart';
import 'package:gotoko/view/base/secondary_header_view.dart';
import 'package:gotoko/view/screens/account_management/widget/account_list_view.dart';
import 'package:gotoko/view/base/custom_search_field.dart';
import 'package:gotoko/view/screens/account_management/widget/expense_list_view.dart';
import 'package:gotoko/view/screens/account_management/widget/income_list_view.dart';

class AccountListScreen extends StatefulWidget {
  final bool fromAccount;
  final bool isIncome;
  const AccountListScreen(
      {Key? key, this.fromAccount = false, this.isIncome = false})
      : super(key: key);

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    if (widget.isIncome) {
      Get.find<IncomeController>().getIncomeList(1, reload: true);
    } else if (widget.fromAccount) {
      Get.find<AccountController>().getAccountList(1, reload: true);
    } else {
      Get.find<ExpenseController>().getExpenseList(1, reload: true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(isBackButtonExist: true),
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {},
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  CustomHeader(
                    title: widget.isIncome
                        ? 'income_list'.tr
                        : widget.fromAccount
                            ? 'account_list'.tr
                            : 'expense_List'.tr,
                    headerImage: widget.isIncome
                        ? Images.income
                        : widget.fromAccount
                            ? Images.account
                            : Images.expense,
                  ),
                  widget.fromAccount
                      ? GetBuilder<AccountController>(
                          builder: (accountController) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeDefault,
                                vertical: Dimensions.paddingSizeSmall),
                            child: CustomSearchField(
                              controller: searchController,
                              hint: 'search_account'.tr,
                              prefix: Icons.search,
                              iconPressed: () => () {},
                              onSubmit: (text) => () {},
                              onChanged: (value) {
                                accountController.searchAccount(value);
                              },
                              isFilter: false,
                            ),
                          );
                        })
                      : const SizedBox(),
                  widget.fromAccount
                      ? const SizedBox()
                      : GetBuilder<ExpenseController>(
                          builder: (expenseController) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: CustomDatePicker(
                                    title: 'from'.tr,
                                    text: expenseController.startDate != null
                                        ? expenseController.dateFormat
                                            .format(
                                                expenseController.startDate!)
                                            .toString()
                                        : 'select_date'.tr,
                                    image: Images.calender,
                                    requiredField: true,
                                    selectDate: () => expenseController
                                        .selectDate("start", context),
                                  ),
                                ),
                                Expanded(
                                  child: CustomDatePicker(
                                    title: 'to'.tr,
                                    text: expenseController.endDate != null
                                        ? expenseController.dateFormat
                                            .format(expenseController.endDate!)
                                            .toString()
                                        : 'select_date'.tr,
                                    image: Images.calender,
                                    requiredField: true,
                                    selectDate: () => expenseController
                                        .selectDate("end", context),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (widget.isIncome) {
                                      Get.find<IncomeController>()
                                          .getIncomeFilter(
                                              expenseController.dateFormat
                                                  .format(expenseController
                                                      .startDate!)
                                                  .toString(),
                                              expenseController.dateFormat
                                                  .format(expenseController
                                                      .endDate!)
                                                  .toString());
                                    } else {
                                      expenseController.getExpenseFilter(
                                          expenseController.dateFormat
                                              .format(
                                                  expenseController.startDate!)
                                              .toString(),
                                          expenseController.dateFormat
                                              .format(
                                                  expenseController.endDate!)
                                              .toString());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    child: Container(
                                      width: 80,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                          vertical:
                                              Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.paddingSizeBorder),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        'filter'.tr,
                                        style: fontSizeRegular.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  SecondaryHeaderView(
                    isSerial: true,
                    key: UniqueKey(),
                    showOwnTitle: true,
                    title: 'account_info'.tr,
                  ),
                  widget.isIncome
                      ? IncomeListView(scrollController: _scrollController)
                      : widget.fromAccount
                          ? AccountListView(scrollController: _scrollController)
                          : ExpenseListView(
                              isHome: false,
                              scrollController: _scrollController)
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
