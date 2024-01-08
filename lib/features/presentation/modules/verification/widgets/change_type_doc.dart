import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/enums/type_indetification_document.dart';
import '../verification_controller.dart';

class ChangeTypeDoc extends StatelessWidget {
  final VerificationController verifyController;
  const ChangeTypeDoc(this.verifyController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // icon
          Row(
            children: [
              Image.asset(
                Assets.idCard,
                height: 25,
                color: AppColors.green,
              ),
              const SizedBox(width: 10),
              Obx(
                () => Text(
                  verifyController.typeIndetificationDocument.value.toString(),
                  style: AppTextStyles.regular14,
                ),
              ),
            ],
          ),

          // text
          TextButton(
            onPressed: () {
              //_controller.changeTypeIdentityDocuments();
              showChossTypeDialog(context);
            },
            child: Text(
              "Thay đổi",
              style: AppTextStyles.regular14.copyWith(color: AppColors.green),
            ),
          )
          // text
        ],
      ),
    );
  }

  showChossTypeDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        void changeType(int ind) {
          verifyController.selectedRadio = ind;
          if (ind == 0) {
            verifyController.changeTypeIdentityDocuments(
                TypeIndetificationDocument.chungMinhNhanDan);
          } else if (ind == 1) {
            verifyController.changeTypeIdentityDocuments(
                TypeIndetificationDocument.canCuocCongDan);
          } else {
            verifyController.changeTypeIdentityDocuments(
                TypeIndetificationDocument.hoChieu);
          }
          Navigator.pop(context);
        }

        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loại giấy tờ",
                    style: AppTextStyles.bold20,
                  ),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                        value: 0,
                        groupValue: verifyController.selectedRadio,
                        contentPadding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                        title: Text(
                          "Chứng minh nhân dân",
                          style: AppTextStyles.regular14,
                        ),
                        onChanged: (ind) {
                          changeType(ind!);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                        value: 1,
                        groupValue: verifyController.selectedRadio,
                        contentPadding: const EdgeInsets.only(left: 0),
                        title: Text(
                          "Căn cước công dân",
                          style: AppTextStyles.regular14,
                        ),
                        onChanged: (ind) {
                          changeType(ind!);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                        value: 2,
                        groupValue: verifyController.selectedRadio,
                        contentPadding: const EdgeInsets.only(left: 0),
                        title: Text(
                          "Hộ chiếu",
                          style: AppTextStyles.regular14,
                        ),
                        onChanged: (ind) {
                          changeType(ind!);
                          setState(() {});
                        },
                      ),
                    ),
                  ]),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
