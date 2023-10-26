import 'package:equatable/equatable.dart';
import '../../enums/enums.dart';
import '../address.dart';

class PostEntity extends Equatable {
  final String id;
  final double area;
  final String? projectName;
  final PropertyType type;
  final AddressEntity address;
  final String userID;
  final int price;
  final int? deposit;
  final bool isLease;
  final String title;
  final String description;
  final DateTime postedDate;
  final DateTime expiryDate;
  final int numOfLikes;
  final List<String> imagesUrl;
  final bool isProSeller;
  final PostStatus status;
  final String? rejectedInfo;
  final bool isHide;
  final bool isPriority;

  PostEntity({
    required this.id,
    required this.area,
    required this.type,
    required this.address,
    required this.userID,
    required this.isLease,
    required this.price,
    required this.title,
    required this.description,
    required this.postedDate,
    required this.expiryDate,
    required this.imagesUrl,
    required this.isProSeller,
    required this.projectName,
    required this.deposit,
    required this.numOfLikes,
    required this.status,
    required this.rejectedInfo,
    required this.isHide,
    required this.isPriority,
  })  : assert(id.trim().isNotEmpty),
        assert(area >= 0),
        assert(projectName?.trim().isNotEmpty ?? true),
        assert(userID.trim().isNotEmpty),
        assert(price > 0),
        assert(title.trim().isNotEmpty),
        assert(description.trim().isNotEmpty),
        assert(postedDate.isBefore(expiryDate)),
        assert(numOfLikes >= 0);

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
        id: json['id'],
        area: json['area'].toDouble(),
        type: PropertyType.parse(json['property_type']),
        address: AddressEntity.fromJson(json['address']),
        userID: json['user_id'],
        isLease: json['is_lease'],
        price: json['price'],
        title: json['title'],
        description: json['description'],
        postedDate: DateTime.parse(json['posted_date']),
        expiryDate: DateTime.parse(json['expiry_date']),
        imagesUrl: List<String>.from(json['images_url']),
        isProSeller: json['is_pro_seller'],
        projectName: json['project_name'],
        deposit: json['deposit'],
        numOfLikes: json['num_of_likes'],
        status: PostStatus.parse(json['status']),
        rejectedInfo: json['rejected_info'],
        isHide: json['is_hide'],
        isPriority: json['is_priority']);
  }

  @override
  String toString() {
    return 'Post{'
        'id: $id, '
        'area: $area, '
        'projectName: $projectName, '
        'type: $type, '
        'address: $address, '
        'userID: $userID, '
        'price: $price, '
        'deposit: $deposit, '
        'isLease: $isLease, '
        'title: $title, '
        'description: $description, '
        'postedDate: $postedDate, '
        'expiryDate: $expiryDate, '
        'numOfLikes: $numOfLikes, '
        'imagesUrl: $imagesUrl, '
        'isProSeller: $isProSeller'
        'status: $status'
        'rejectedInfo: $rejectedInfo'
        'isHide: $isHide'
        '}';
  }

  @override
  List<Object?> get props => [id];
}
