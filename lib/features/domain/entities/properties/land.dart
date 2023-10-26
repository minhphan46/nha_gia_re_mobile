import '../../enums/enums.dart';
import 'post.dart';
import '../address.dart';

class Land extends Post {
  String? landLotCode;
  String? subdivisionName;
  LandType? landType;
  double width;
  double length;
  Direction? landDirection;
  LegalDocumentStatus? legalDocumentStatus;
  bool isFacade;
  bool isWidensTowardsTheBack;
  bool hasWideAlley;

  Land({
    required String id,
    required double area,
    required String? projectName,
    required this.landLotCode,
    required this.subdivisionName,
    required this.landType,
    required this.width,
    required this.length,
    required this.landDirection,
    required this.legalDocumentStatus,
    required this.isFacade,
    required this.isWidensTowardsTheBack,
    required this.hasWideAlley,
    required bool isPriority,
    required AddressEntity address,
    required PropertyType type,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedDate,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
    required int numOfLikes,
    required PostStatus status,
    required String? rejectedInfo,
    required bool isHide,
  })  : assert(landLotCode?.trim().isNotEmpty ?? true),
        assert(width * length > 0),
        assert(subdivisionName?.trim().isNotEmpty ?? true),
        super(
          id: id,
          area: area,
          type: type,
          address: address,
          userID: userID,
          isLease: isLease,
          price: price,
          title: title,
          description: description,
          postedDate: postedDate,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName: projectName,
          deposit: deposit,
          numOfLikes: numOfLikes,
          status: status,
          rejectedInfo: rejectedInfo,
          isHide: isHide,
          isPriority: isPriority,
        );

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
        id: json['id'],
        area: json['area'],
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
        hasWideAlley: json['has_wide_alley'],
        isFacade: json['is_facade'],
        landType: json['land_type'] != null
            ? LandType.parse(json['land_type'])
            : null,
        landDirection: json['land_direction'] != null
            ? Direction.parse(json['land_direction'])
            : null,
        legalDocumentStatus: json['legal_document_status'] != null
            ? LegalDocumentStatus.parse(json['legal_document_status'])
            : null,
        width: json['width'].toDouble(),
        length: json['length'].toDouble(),
        landLotCode: json['land_lot_code'],
        subdivisionName: json['subdivision_name'],
        isWidensTowardsTheBack: json['is_widens_towards_the_back'],
        status: PostStatus.parse(json['status']),
        rejectedInfo: json['rejected_info'],
        isHide: json['is_hide'],
        isPriority: json['is_priority']);
  }
  @override
  String toString() {
    return 'Land{'
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
        'isProSeller: $isProSeller, '
        'landLotCode: $landLotCode, '
        'subdivisionName: $subdivisionName, '
        'landType: $landType, '
        'width: $width, '
        'length: $length, '
        'landDirection: $landDirection, '
        'legalDocumentStatus: $legalDocumentStatus, '
        'isFacade: $isFacade, '
        'isWidensTowardsTheBack: $isWidensTowardsTheBack, '
        'hasWideAlley: $hasWideAlley'
        'status: $status'
        'rejectedInfo: $rejectedInfo'
        'isHide: $isHide'
        '}';
  }
}
