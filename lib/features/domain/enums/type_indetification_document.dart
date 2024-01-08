enum TypeIndetificationDocument {
  chungMinhNhanDan,
  canCuocCongDan,
  hoChieu;

  @override
  String toString() {
    switch (this) {
      case TypeIndetificationDocument.chungMinhNhanDan:
        return "Chứng minh nhân dân";
      case TypeIndetificationDocument.canCuocCongDan:
        return "Căn cước công dân";
      case TypeIndetificationDocument.hoChieu:
        return "Hộ chiếu";
    }
  }
}
