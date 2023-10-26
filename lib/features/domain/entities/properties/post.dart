import '../../enums/enums.dart';
import '../address.dart';

class Post {
  String id;
  double area;
  String? projectName;
  PropertyType type;
  AddressEntity address;
  String userID;
  int price;
  int? deposit;
  bool isLease;
  String title;
  String description;
  DateTime postedDate;
  DateTime expiryDate;
  int numOfLikes;
  List<String> imagesUrl;
  bool isProSeller;
  PostStatus status;
  String? rejectedInfo;
  bool isHide;
  bool isPriority;

  Post({
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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
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
}
