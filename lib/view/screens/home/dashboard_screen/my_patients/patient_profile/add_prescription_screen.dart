import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/home/dashboard/my_patients/patient_profile/patient_profile_controller.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/custom_text_form_field.dart';
import 'package:teleprac/view/widgets/home/account_settings/screens/profile_settings/drop_down.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_patients/add_prescription/medicine_times.dart';
import 'package:teleprac/view/widgets/global/upper_part.dart';
import 'package:teleprac/view/widgets/home/dashboard/my_patients/add_prescription/select_medicine.dart';

class AddPrescriptionScreen extends StatelessWidget {
  const AddPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientProfileController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.greyDesign,
      body: WillPopScope(
        onWillPop: controller.addPrescriptionScreenWillPop,
        child: SafeArea(
          child: Column(
            children: [
              UpperPart(
                text: AppTexts.addPrescription,
                customBackFunction: controller.addPrescriptionScreenWillPop,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      CustomTextFormField(
                        textEditingController: controller.chiefComplaintsCon,
                        focusNode: controller.chiefComplaintsFocus,
                        nextFocusNode: controller.heightFocus,
                        label: 'Chief Complaints',
                        oldDesign: false,
                        startingHeight: 0.1,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      CustomTextFormField(
                        textEditingController: controller.heightCon,
                        focusNode: controller.heightFocus,
                        nextFocusNode: controller.weightFocus,
                        label: 'Height',
                        oldDesign: false,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      CustomTextFormField(
                        textEditingController: controller.weightCon,
                        focusNode: controller.weightFocus,
                        nextFocusNode: controller.lmpFocus,
                        oldDesign: false,
                        label: 'Weight',
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      CustomTextFormField(
                        textEditingController: controller.lmpCon,
                        focusNode: controller.lmpFocus,
                        nextFocusNode: controller.ageFocus,
                        label: 'LMP',
                        oldDesign: false,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      CustomTextFormField(
                        textEditingController: controller.ageCon,
                        focusNode: controller.ageFocus,
                        label: 'Age',
                        oldDesign: false,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      const SelectMedicine(),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.02,
                      ),
                      GetBuilder<PatientProfileController>(
                        builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add Medicine",
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            AppDecoration().screenWidth * 0.055,
                                        fontFamily: AppDecoration.cairo,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.medicines.add({
                                          'qty': '1',
                                          'days': '1',
                                          'time': '',
                                          'type': '',
                                          'drug_name': '',
                                        });
                                        controller.update();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ...List.generate(
                                controller.medicines.length,
                                (index) {
                                  TextEditingController drugNameCon =
                                      TextEditingController(
                                    text: controller.medicines[index]
                                        ['drug_name'],
                                  );
                                  TextEditingController typeCon =
                                      TextEditingController();

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.medicines.remove(
                                            controller.medicines[index],
                                          );
                                          controller.update();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ),
                                      CustomTextFormField(
                                        textEditingController: drugNameCon,
                                        label: 'Drug Name',
                                        oldDesign: false,
                                        onChanged: (val) {
                                          controller.medicines[index]
                                              ['drug_name'] = drugNameCon.text;
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      CustomDropDown(
                                        dropdownList: controller.medicineTypes,
                                        value: controller.medicines[index]
                                            ['type'],
                                        onChanged: (val) {
                                          controller.medicines[index]['type'] =
                                              val;
                                          controller.update();
                                        },
                                        oldDesign: false,
                                        label: 'Type',
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      if (controller
                                          .medicines[index]['time'].isNotEmpty)
                                        MedicineTimes(index: index),
                                      CustomTextFormField(
                                        oldDesign: false,
                                        textEditingController: typeCon,
                                        label:
                                            'Time (morning , noon , evening , night)',
                                        onEditingComplete: () {
                                          if (typeCon.text.isNotEmpty) {
                                            if (typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('morning') ||
                                                typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('noon') ||
                                                typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('evening') ||
                                                typeCon.text.removeAllWhitespace
                                                    .toLowerCase()
                                                    .contains('night')) {
                                              if (controller.medicines[index]
                                                      ['time']
                                                  .toString()
                                                  .isNotEmpty) {
                                                if (!controller.medicines[index]
                                                        ['time']
                                                    .toString()
                                                    .contains(typeCon
                                                        .text.capitalizeFirst!
                                                        .trim())) {
                                                  controller.medicines[index]
                                                      ['time'] = controller
                                                              .medicines[index]
                                                          ['time'] +
                                                      ',' +
                                                      typeCon
                                                          .text.capitalizeFirst!
                                                          .trim();
                                                } else {
                                                  Get.defaultDialog(
                                                      middleText:
                                                          'Already Added');
                                                }
                                              } else {
                                                controller.medicines[index]
                                                        ['time'] =
                                                    typeCon
                                                        .text.capitalizeFirst!
                                                        .trim();
                                              }
                                              typeCon.clear();
                                              controller.update();
                                            } else {
                                              Get.defaultDialog(
                                                  middleText:
                                                      'You can only add \n "morning , noon , evening , night"');
                                            }
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Quantity :',
                                                style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppDecoration.cairo,
                                                  fontSize: AppDecoration()
                                                          .screenWidth *
                                                      0.045,
                                                ),
                                              ),
                                            ),
                                            Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    int qty = int.parse(
                                                        controller.medicines[
                                                            index]['qty']);
                                                    if (qty != 1) {
                                                      qty--;
                                                      controller.medicines[
                                                              index]['qty'] =
                                                          qty.toString();
                                                      controller.update();
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  controller.medicines[index]
                                                      ['qty'],
                                                  style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        AppDecoration.cairo,
                                                    fontSize: AppDecoration()
                                                            .screenWidth *
                                                        0.045,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    int qty = int.parse(
                                                        controller.medicines[
                                                            index]['qty']);
                                                    qty++;
                                                    controller.medicines[index]
                                                            ['qty'] =
                                                        qty.toString();
                                                    controller.update();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Days :',
                                                style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppDecoration.cairo,
                                                  fontSize: AppDecoration()
                                                          .screenWidth *
                                                      0.045,
                                                ),
                                              ),
                                            ),
                                            Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    int days = int.parse(
                                                        controller.medicines[
                                                            index]['days']);
                                                    if (days != 1) {
                                                      days--;
                                                      controller.medicines[
                                                              index]['days'] =
                                                          days.toString();
                                                      controller.update();
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  controller.medicines[index]
                                                      ['days'],
                                                  style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        AppDecoration.cairo,
                                                    fontSize: AppDecoration()
                                                            .screenWidth *
                                                        0.045,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    int days = int.parse(
                                                        controller.medicines[
                                                            index]['days']);

                                                    days++;
                                                    controller.medicines[index]
                                                            ['days'] =
                                                        days.toString();
                                                    controller.update();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 0.5,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(
                                        height:
                                            AppDecoration().screenHeight * .02,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.03,
                      ),
                      CustomButton(
                        function: controller.addPrescription,
                        text: AppTexts.addPrescription,
                        buttonColor: AppColors.primaryColor,
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        circularRadius: 10,
                      ),
                      SizedBox(
                        height: AppDecoration().screenHeight * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
