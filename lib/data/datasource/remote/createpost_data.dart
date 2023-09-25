import 'package:task_flutter/core/class/crud.dart';
import 'package:task_flutter/linkapi.dart';

class CreatePostData {
  Crud crud;
  CreatePostData(this.crud);
  postData({
    required String body,
  }) async {
    var response = await crud.postData(linkUrl: AppLink.createPost, data:body
    );
    return response.fold((l) => l, (r) => r);
  }


}
