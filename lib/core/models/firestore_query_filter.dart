import 'package:real_time_chat_app/core/models/query_filter_model.dart';

class FirestoreQueryFilter extends QueryFilterModel {
  final String field;
  final dynamic value;
  final String operator;

  FirestoreQueryFilter({
    required this.field,
    required this.value,
    required this.operator,
  });
}
