import 'package:catering_service_app/src/common/common_export.dart';
import 'package:catering_service_app/src/features/auth/screens/widgets/build_dialogs.dart';
import 'package:catering_service_app/src/features/dashboard/screens/home_screen.dart';
import 'package:catering_service_app/src/features/menu/data/menu_data_provider.dart';
import 'package:catering_service_app/src/features/menu/data/menu_datasource.dart';
import 'package:catering_service_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_service_app/src/features/menu/screens/widgets/input_chip_field.dart';
import 'package:catering_service_app/src/shared/data/category_provider.dart';
import 'package:catering_service_app/src/shared/domain/category_model.dart';
import 'package:catering_service_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UpdateMenuScreen extends ConsumerStatefulWidget {
  final Menus myMenu;
  const UpdateMenuScreen({super.key, required this.myMenu});

  @override
  ConsumerState<UpdateMenuScreen> createState() => _UpdateMenuScreenState();
}

class _UpdateMenuScreenState extends ConsumerState<UpdateMenuScreen> {
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  late String selectedCategoryId;
  late String selectedCategory;
  late String price;
  late List<String> starterMenu;
  late List<String> mainCourseMenu;
  late List<String> dessertMenu;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.myMenu.categoryId;
    selectedCategory = widget.myMenu.categoryName;
    price = widget.myMenu.price.toString();
    starterMenu = List<String>.from(widget.myMenu.starterMenu);
    mainCourseMenu = List<String>.from(widget.myMenu.mainCourseMenu);
    dessertMenu = List<String>.from(widget.myMenu.dessertMenu);
    priceController.text = price;
    descriptionController.text = widget.myMenu.menuDescription;
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = ref.watch(categoryProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Update Menu'),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Consumer(
            builder: (context, ref, child) {
              return categoryData.when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Text(
                            'Update your menu',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColor.greyColor
                            )
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.w,
                              )
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            items: data.map((CategoryModel category) {
                              return DropdownMenuItem(
                                value: category.categoryId,
                                child: Text(category.categoryTitle),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategoryId = value!;
                                selectedCategory = data
                                    .firstWhere((category) => category.categoryId == value)
                                    .categoryTitle;
                              });
                            },
                            hint: Text(
                              selectedCategory,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        const Text('Starter'),
                        SizedBox(height: 5.h),
                        EditableChipField(
                          initialValues: starterMenu,
                          onChanged: (List<String> items) {
                            setState(() {
                              starterMenu = items;
                            });
                          },
                        ),
                        SizedBox(height: 20.h,),
                        const Text('Main Course'),
                        SizedBox(height: 5.h),
                        EditableChipField(
                          initialValues: mainCourseMenu,
                          onChanged: (List<String> items) {
                            setState(() {
                              mainCourseMenu = items;
                            });
                          },
                        ),
                        SizedBox(height: 20.h,),
                        const Text('Dessert'),
                        SizedBox(height: 5.h),
                        EditableChipField(
                          initialValues: dessertMenu,
                          onChanged: (List<String> items) {
                            setState(() {
                              dessertMenu = items;
                            });
                          },
                        ),
                        SizedBox(height: 20.h,),
                        BuildTextField(
                          controller: priceController,
                          textInputType: TextInputType.number,
                          labelText: 'Price',
                          hintText: 'price per plate',
                        ),
                        SizedBox(height: 20.h,),
                        BuildTextField(
                          maxLine: 4,
                          controller: descriptionController,
                          textInputType: TextInputType.text,
                          labelText: 'Menu Description',
                          hintText: 'Example: This menu is a combination of delicious meals that will make....',
                          alignLabelToTop: true,
                        ),
                        SizedBox(height: 40.h,),
                        BuildButton(
                          onPressed: () async{
                            final navigator = Navigator.of(context);
                            buildLoadingDialog(context, "Updating Menu....");
                            final response = await MenuDataSource().updateMenu(
                              menuId: widget.myMenu.menuId,
                              categoryId: selectedCategoryId,
                              price: priceController.text.trim(),
                              categoryName: selectedCategory,
                              starterMenu: starterMenu,
                              mainCourseMenu: mainCourseMenu,
                              dessertMenu: dessertMenu,
                            );
                            navigator.pop();
                            if(response != 'Menu Updated'){
                              if(!context.mounted) return;
                              buildErrorDialog(context, response);
                            }else{
                              if(!context.mounted) return;
                              buildSuccessDialog(
                                context, response,
                                    () {
                                  navigator.push(
                                    MaterialPageRoute(
                                      builder: (_) => const HomeScreen(),
                                    ),
                                  );
                                  ref.invalidate(menuProvider);
                                  ref.read(menuProvider);
                                },
                              );
                            }
                          },
                          buttonWidget: const Text('Update'),
                        )
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => Text("$error"),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          )
      ),
    );
  }
}
