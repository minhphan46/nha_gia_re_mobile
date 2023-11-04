import 'package:equatable/equatable.dart';

class MembershipPackageEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int pricePerMonth;
  final int monthlyPostLimit;
  final int displayPriorityPoint;
  final int postApprovalPriorityPoint;
  final DateTime createdAt;
  final bool isActive;

  const MembershipPackageEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerMonth,
    required this.monthlyPostLimit,
    required this.displayPriorityPoint,
    required this.postApprovalPriorityPoint,
    required this.createdAt,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pricePerMonth,
    monthlyPostLimit,
        displayPriorityPoint,
        postApprovalPriorityPoint,
        createdAt,
        isActive,
      ];

  // Dummy Data
  static List<MembershipPackageEntity> dummyData = [
    MembershipPackageEntity(
      id: "1",
      name: "Gói 1",
      description: "Gói 1",
      pricePerMonth: 100000,
      monthlyPostLimit: 10,
      displayPriorityPoint: 1,
      postApprovalPriorityPoint: 1,
      createdAt: DateTime.now(),
      isActive: true,
    ),
    MembershipPackageEntity(
      id: "2",
      name: "Gói 2",
      description: "Gói 2",
      pricePerMonth: 200000,
      monthlyPostLimit: 20,
      displayPriorityPoint: 2,
      postApprovalPriorityPoint: 2,
      createdAt: DateTime.now(),
      isActive: true,
    ),
    MembershipPackageEntity(
      id: "3",
      name: "Gói 3",
      description: "Gói 3",
      pricePerMonth: 300000,
      monthlyPostLimit: 30,
      displayPriorityPoint: 3,
      postApprovalPriorityPoint: 3,
      createdAt: DateTime.now(),
      isActive: true,
    ),
    MembershipPackageEntity(
      id: "4",
      name: "Gói 4",
      description: "Gói 4",
      pricePerMonth: 400000,
      monthlyPostLimit: 40,
      displayPriorityPoint: 4,
      postApprovalPriorityPoint: 4,
      createdAt: DateTime.now(),
      isActive: true,
    ),
    MembershipPackageEntity(
      id: "5",
      name: "Gói 5",
      description: "Gói 5",
      pricePerMonth: 500000,
      monthlyPostLimit: 50,
      displayPriorityPoint: 5,
      postApprovalPriorityPoint: 5,
      createdAt: DateTime.now(),
      isActive: true,
    ),
  ];
}
