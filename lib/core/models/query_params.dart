class QueryParams {
  final List<QueryCondition> conditions;
  final List<QueryOrder> orders;

  QueryParams({required this.conditions, required this.orders});
}

class QueryCondition {
  final String field;
  final dynamic isEqualTo;
  final dynamic arrayContains;
  final List<dynamic>? whereIn;

  QueryCondition({
    required this.field,
    this.isEqualTo,
    this.arrayContains,
    this.whereIn,
  });
}

class QueryOrder {
  final String field;
  final bool descending;

  QueryOrder({required this.field, this.descending = false});
}
