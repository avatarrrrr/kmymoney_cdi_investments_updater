// Hello! This script will help you to update your investments on Kmymoney (https://kmymoney.org/) acconding of CDI (Certificado de Depósito Interbancário)
// This script only work on kmymoney files saved in XML (Extensible Markup Language).
import 'package:get_it/get_it.dart';

import '../constants/dependencys.dart';
import '../controllers/startup_controller.dart';

void main(List<String> arguments) async {
  Dependencys.instance.init();

  GetIt.I<StartupController>().init();
}
