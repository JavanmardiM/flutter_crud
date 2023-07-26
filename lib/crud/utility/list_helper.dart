import 'base_model.dart';

class ListHelper {

  List<BaseModel> list;

  ListHelper(List<BaseModel> list) {
    this.list = list;
  }

  void edit(BaseModel item) {
    var element = this.list
        .where((element) => element.id == item.id)
        .toList()[0];
    var index = this.list.indexOf(element);
    this.list.removeAt(index);
    this.list.insert(index, item);
  }

  void addAtFirst(BaseModel item) {
    this.list.insert(0, item);
  }

  void addAtLast(BaseModel item) {
    this.list.insert(this.list.length, item);
  }

  void delete(int id) {
    var element = this.list
        .where((element) => element.id == id)
        .toList()[0];
    var index = this.list.indexOf(element);
    this.list.removeAt(index);
  }
}