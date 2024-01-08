import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/account_verification_requests.dart';
import 'package:nhagiare_mobile/features/domain/enums/type_indetification_document.dart';
import 'package:nhagiare_mobile/features/domain/usecases/user/send_verification.dart';
import 'package:nhagiare_mobile/injection_container.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/resources/data_state.dart';
import '../../../domain/usecases/authentication/get_user_id.dart';
import '../../../domain/usecases/post/remote/upload_images.dart';

class VerificationController extends GetxController {
  RxBool isCanClickCard = false.obs;
  RxBool isCanClickPortrait = false.obs;
  RxBool isCanClickInfo = false.obs;
  RxInt activeStep = 0.obs;
  int selectedRadio = 0;

  String urlImageCardFront = "";
  String urlImageCardBack = "";
  RxBool isUploadCardFront = false.obs;
  RxBool isUploadCardBack = false.obs;

  String urlImagePortrait = "";

  // form infomations
  List<String> issuedByList = [
    "CỤC TRƯỞNG CỤC CẢNH SÁT DKQL CƯ TRÚ VÀ DLQG VỀ DÂN CƯ",
    "CỤC TRƯỞNG CỤC CẢNH SÁT QUẢN LÝ HÀNH CHÍNH VỀ TRẬT TỰ XÃ HỘI",
  ];

  GlobalKey<FormState> userInfoFormKey = GlobalKey<FormState>();
  var fullNameTextController = TextEditingController();
  var identityCardNoTextController = TextEditingController();
  var identityCardIssuedDateTextController = TextEditingController();
  RxString issuedBy = "".obs;
  var countryTextController = TextEditingController();
  RxBool isMale = true.obs;
  var birthDayTextController = TextEditingController();
  var identityCardIssuedDate = DateTime.now();
  var birthday = DateTime.now();
  RxBool isApprove = false.obs;

  final typeIndetificationDocument =
      TypeIndetificationDocument.chungMinhNhanDan.obs;

  void changeStep(int step) {
    activeStep.value = step;
  }

  void changeIssueBy(String by) {
    issuedBy.value = by;
  }

  void changeTypeIdentityDocuments(TypeIndetificationDocument type) {
    typeIndetificationDocument.value = type;
    update();
  }

  Future<void> handelUploadIdCard(File file, bool isFront) async {
    if (isFront) {
      urlImageCardFront = await uploadImages(file);
      isUploadCardFront.value = true;
    } else {
      urlImageCardBack = await uploadImages(file);
      isUploadCardBack.value = true;
    }
    checkCanClickContinueCard();
  }

  Future<void> handelUploadPortrait(File file) async {
    urlImagePortrait = await uploadImages(file);
    isCanClickPortrait.value = true;
  }

  UploadImagessUseCase uploadImagessUseCase = sl<UploadImagessUseCase>();
  Future<String> uploadImages(File image) async {
    final dataState = await uploadImagessUseCase(params: [image]);

    if (dataState is DataSuccess) {
      return dataState.data![0];
    } else {
      return "";
    }
  }

  void checkCanClickContinueCard() {
    if (isUploadCardFront.value && isUploadCardBack.value) {
      isCanClickCard.value = true;
    } else {
      isCanClickCard.value = false;
    }
  }

  void navToPortraitSceen() {
    if (isCanClickCard.value) {
      Get.toNamed(AppRoutes.verificationPortrait);
      isCanClickPortrait.value = false;
      changeStep(1);
    }
  }

  void navToInforScreen() {
    if (isCanClickPortrait.value) {
      Get.toNamed(AppRoutes.verificationInfo);
      isCanClickInfo.value = false;
      changeStep(2);
    }
  }

  void navToVerification() {
    Get.toNamed(AppRoutes.verificationCard);
  }

  String? validateTextField(String? value) {
    if (value!.trim().isEmpty) {
      return 'Required field must not be blank';
    }
    return null;
  }

  String? validateIdCardTextField(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required field must not be blank';
    }
    // Loại bỏ khoảng trắng và ký tự dư thừa trong chuỗi đầu vào
    input = input.replaceAll(RegExp(r'\s+'), '');

    // Kiểm tra độ dài chuỗi
    if (input.length != 12) {
      return "Căn cước phải đủ 12 số";
    }

    // Kiểm tra chuỗi có chứa ký tự không phải số hay không
    if (!RegExp(r'^[0-9]+$').hasMatch(input)) {
      return "Căn cước công dân phải là số";
    }

    return null;
  }

  Future<void> handleDatePicker(
      TextEditingController controler, DateTime date) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Theme.of(context).primaryColor,
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      date = picked;
      controler.text = DateFormat('dd/MM/yyyy').format(picked);
      checkCanfinish();
    }
  }

  bool checkCanfinish() {
    bool check = true;
    if (fullNameTextController.text.trim().isEmpty) check = check & false;
    if (identityCardNoTextController.text.trim().isEmpty) check = check & false;
    if (identityCardIssuedDateTextController.text.trim().isEmpty) {
      check = check & false;
    }
    if (birthDayTextController.text.trim().isEmpty) {
      check = check & false;
    }
    if (!isApprove.value) check = check & false;
    isCanClickInfo.value = check;
    return check;
  }

  GetUserIdUseCase getUserIdUseCase = sl<GetUserIdUseCase>();
  SendVerificationUseCase sendVerificationUseCase =
      sl<SendVerificationUseCase>();

  Future finishVerification() async {
    if (userInfoFormKey.currentState!.validate()) {
      final userId = await getUserIdUseCase();
      AccountVerificationRequestEntity requests =
          AccountVerificationRequestEntity(
        userId: userId!,
        requestDate: DateTime.now(),
        frontIdentityCardImageLink: urlImageCardFront,
        backIdentityCardImageLink: urlImageCardBack,
        portraitImageLink: urlImagePortrait,
        fullName: fullNameTextController.text,
        sex: isMale.value,
        dob: birthday.toIso8601String(),
        identityCardNo: identityCardNoTextController.text,
        identityCardIssuedDate: identityCardIssuedDate,
        issuedBy: issuedBy.value,
      );

      await sendVerificationUseCase(params: requests);

      Get.back(result: "1");
      Get.back(result: "1");
      Get.back(result: "1");

      //accountRepo.checkResult == "1";
    } else {
      Get.snackbar("Thông tin không hợp lệ", "Vui lòng kiểm tra thông tin");
    }
  }
}
