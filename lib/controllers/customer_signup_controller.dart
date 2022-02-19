import 'package:get/get.dart';

import '../models/customer.dart';

class CustomerSignupController extends GetxController with StateMixin {
  var currentAddCustomer = Customer().obs;
  var loading = false.obs;
  setCurrentAddCustomer(Customer customer) {
    currentAddCustomer.value = customer;
  }
}
