import 'dart:async';
import 'package:nhagiare_mobile/core/utils/query_builder.dart';

Future<void> main() async {
  final queryBuilder = QueryBuilder();
  queryBuilder
      // .addQuery('name', Operation.equals, 'John')
      // .addQuery('age', Operation.greaterThan, 18)
      // .addOrderBy('name', OrderBy.asc)
      // .addPage(2)
      .addQuery('post_address->>province_code', Operation.equals, '\'1\'')
      .addQuery('post_is_active', Operation.equals, true);
  //print(queryBuilder.build());
}
