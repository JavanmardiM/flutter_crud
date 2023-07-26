enum RegisterType { Add, Edit, Display }

class ArgumentModel<T> {
  RegisterType _mode;
  T _object;

  RegisterType get mode {
    return _mode;
  }

  T get object {
    return _object;
  }

  addType() {
    _mode = RegisterType.Add;
    return this;
  }

  editType(T object) {
    _mode = RegisterType.Edit;
    this._object = object;
    return this;
  }

  displayType(T object) {
    _mode = RegisterType.Display;
    this._object = object;
    return this;
  }
}
