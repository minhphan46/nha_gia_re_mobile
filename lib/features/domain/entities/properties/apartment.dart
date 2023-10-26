import '../../enums/enums.dart';
import '../address.dart';
import 'post.dart';

class ApartmentEntity extends PostEntity {
  final bool isCorner;
  final bool isHandOver;
  final int? numOfBedRooms;
  final Direction? balconyDirection;
  final Direction? mainDoorDirection;
  final int? numOfToilets;
  final String? block;
  final int floor;
  final ApartmentType? apartmentType;
  final LegalDocumentStatus? legalDocumentStatus;
  final FurnitureStatus? furnitureStatus;

  ApartmentEntity({
    required String id,
    required this.furnitureStatus,
    required double area,
    required String? projectName,
    required this.apartmentType,
    required this.isCorner,
    required this.isHandOver,
    required this.numOfBedRooms,
    required this.balconyDirection,
    required this.mainDoorDirection,
    required this.numOfToilets,
    required this.block,
    required this.legalDocumentStatus,
    required this.floor,
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
  })  : assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(block == null || block.trim().isNotEmpty),
        assert(floor >= 0),
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

  factory ApartmentEntity.fromJson(Map<String, dynamic> json) {
    return ApartmentEntity(
        id: json['id'],
        area: json['area'],
        projectName: json['project_name'],
        type: PropertyType.parse(json['property_type']),
        address: AddressEntity.fromJson(json['address']),
        userID: json['user_id'],
        price: json['price'],
        deposit: json['deposit'],
        isLease: json['is_lease'],
        title: json['title'],
        description: json['description'],
        postedDate: DateTime.parse(json['posted_date']),
        expiryDate: DateTime.parse(json['expiry_date']),
        isProSeller: json['is_pro_seller'],
        numOfLikes: json['num_of_likes'],
        furnitureStatus: FurnitureStatus.parse(json['furniture_status']),
        imagesUrl: List<String>.from(json['images_url']),
        apartmentType: json['apartment_type'] != null
            ? ApartmentType.parse(json['apartment_type'])
            : null,
        isCorner: json['is_corner'],
        isHandOver: json['is_hand_over'],
        numOfBedRooms: json['num_of_bedrooms'],
        numOfToilets: json['num_of_toilets'],
        balconyDirection: json['balcony_direction'] != null
            ? Direction.parse(json['balcony_direction'])
            : null,
        mainDoorDirection: json['main_door_direction'] != null
            ? Direction.parse(json['main_door_direction'])
            : null,
        block: json['block'],
        floor: json['floor'],
        legalDocumentStatus: json['legal_document_status'] != null
            ? LegalDocumentStatus.parse(json['legal_document_status'])
            : null,
        status: PostStatus.parse(json['status']),
        rejectedInfo: json['rejected_info'],
        isHide: json['is_hide'],
        isPriority: json['is_priority']);
  }

  @override
  String toString() {
    return 'Apartment{'
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
        'apartmentType: $apartmentType, '
        'isCorner: $isCorner, '
        'isHandOver: $isHandOver, '
        'numOfBedRooms" $numOfBedRooms, '
        'balconyDirection: $balconyDirection, '
        'mainDoorDirection: $mainDoorDirection, '
        'numOfToilets: $numOfToilets, '
        'block: $block, '
        'floor: $floor, '
        'legalDocumentStatus: $legalDocumentStatus'
        'status: $status'
        'rejectedInfo: $rejectedInfo'
        'isHide: $isHide';
  }
}
