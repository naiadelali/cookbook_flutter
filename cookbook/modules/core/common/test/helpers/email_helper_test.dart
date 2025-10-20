import 'package:core_common/helpers/email_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("EmailHelper", () {
    test("validates an valid e-mail", () {
      String email = "test@example.com";

      final isValid = EmailHelper.validate(email);

      expect(isValid, true);
    });

    test("validate an invalid e-mail", () {
      String email = "test_@_invalid@example.com";

      final isValid = EmailHelper.validate(email);

      expect(isValid, false);
    });
  });
}
