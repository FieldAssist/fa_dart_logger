class UserInfo {
  UserInfo({
    required this.name,
    required this.id,
    required this.companyId,
  });

  final String name;
  final String id;
  final String companyId;

  @override
  String toString() => 'UserInfo{name: $name, id: $id, companyId: $companyId}';

  /// Short for user_id company_companyId
  String getUcid() => "${id}_${companyId}_";

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "companyId": companyId,
    };
  }
}
