class AccountVerificationRequestEntity {
  String userId;
  DateTime requestDate;
  String frontIdentityCardImageLink;
  String backIdentityCardImageLink;
  String portraitImageLink; // anh mat
  String fullName;
  bool sex;
  String dob;
  String identityCardNo;
  DateTime identityCardIssuedDate;
  String issuedBy;

  AccountVerificationRequestEntity({
    required this.userId,
    required this.requestDate,
    required this.frontIdentityCardImageLink,
    required this.backIdentityCardImageLink,
    required this.portraitImageLink,
    required this.fullName,
    required this.sex,
    required this.dob,
    required this.identityCardNo,
    required this.identityCardIssuedDate,
    required this.issuedBy,
  });

  factory AccountVerificationRequestEntity.fromJson(Map<String, dynamic> json) {
    return AccountVerificationRequestEntity(
      userId: json['user_id'] as String,
      requestDate: DateTime.parse(json['request_date']),
      frontIdentityCardImageLink:
          json['front_identity_card_image_link'] as String,
      backIdentityCardImageLink:
          json['back_identity_card_image_link'] as String,
      portraitImageLink: json['portrait_image_link'] as String,
      fullName: json['full_name'] as String,
      sex: json['sex'] as bool,
      dob: json['dob'] as String,
      identityCardNo: json['identity_card_no'] as String,
      identityCardIssuedDate: DateTime.parse(json['identity_card_issued_date']),
      issuedBy: json['issued_by'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_identity_card_image_link': frontIdentityCardImageLink,
      'back_identity_card_image_link': backIdentityCardImageLink,
      'portrait_image_link': portraitImageLink,
      'full_name': fullName,
      'sex': sex,
      'dob': dob,
      'identity_card_no': identityCardNo,
      'identity_card_issued_date': identityCardIssuedDate.toIso8601String(),
      'issued_by': issuedBy,
    };
  }
}
