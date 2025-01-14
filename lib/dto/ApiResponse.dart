class ApiResponse {
  List<DataItem> data;

  ApiResponse({required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      data: (json['data'] as List)
          .map((item) => DataItem.fromJson(item))
          .toList(),
    );
  }
  List<UsersPermissionsUser> getUsersPermissionsUsers() {
    return data.map((item) => item.usersPermissionsUser).toList();
  }
}

class DataItem {
  UsersPermissionsUser usersPermissionsUser;

  DataItem({required this.usersPermissionsUser});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      usersPermissionsUser: UsersPermissionsUser.fromJson(json['users_permissions_user']),
    );
  }
}

class UsersPermissionsUser {
  String companyName;
  String placemarkId = "";

  UsersPermissionsUser({required this.companyName});

  factory UsersPermissionsUser.fromJson(Map<String, dynamic> json) {
    return UsersPermissionsUser(
      companyName: json['companyName'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'placemarkId': placemarkId,
    };
  }
}

