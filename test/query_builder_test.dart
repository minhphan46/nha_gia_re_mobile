import 'package:nhagiare_mobile/core/utils/query_builder.dart';
import 'package:test/test.dart';

void main() {
  test('addQuery should add query parameter correctly', () {
    final queryBuilder = QueryBuilder();
    queryBuilder.addQuery('name', Operation.equals, 'John');
    expect(queryBuilder.build(), '?name[eq]=John&page=1');
  });

  test('addOrderBy should add order by parameter correctly', () {
    final queryBuilder = QueryBuilder();
    queryBuilder.addOrderBy('name', OrderBy.asc);
    queryBuilder.addOrderBy('age', OrderBy.desc);
    expect(queryBuilder.build(), '?page=1&orderBy=+name,-age');
  });

  test('addPage should set the page correctly', () {
    final queryBuilder = QueryBuilder();
    queryBuilder.addPage(2);
    expect(queryBuilder.build(), '?page=2');
  });

  test('addSearch should add search parameter correctly', () {
    final queryBuilder = QueryBuilder();
    queryBuilder.addSearch('keyword');
    expect(queryBuilder.build(), '?page=1&search=keyword');
  });

  test('build should return the correct query string', () {
    final queryBuilder = QueryBuilder();
    queryBuilder
        .addQuery('name', Operation.equals, 'John')
        .addQuery('age', Operation.greaterThan, 18)
        .addOrderBy('name', OrderBy.asc)
        .addPage(2)
        .addSearch('keyword');
    expect(queryBuilder.build(),
        '?name[eq]=John&age[gt]=18&page=2&orders=+name&search=keyword');
  });
}
