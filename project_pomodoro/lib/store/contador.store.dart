import 'package:mobx/mobx.dart';
part 'contador.store.g.dart';

class ContadorStore = _ContadorStore with _$ContadorStore;

abstract class _ContadorStore with Store {
  
  @observable // anotation / decoration
  int contador = 0;

  @action  // anotation / decoration
  int incrementar() {
    return contador++;
  }

}