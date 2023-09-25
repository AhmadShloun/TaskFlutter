import 'package:task_flutter/core/class/crud.dart';
import 'package:task_flutter/linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);

  getFetchDataApi(int page,int limit) async {
    var response = await crud.fetchData(linkUrl: AppLink.homepage,page: page,limit: limit);
    return response.fold((l) => l, (r) => r);
  }

}
