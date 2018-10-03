import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';
import 'package:flutter_paystack/src/model/card.dart';
import 'package:flutter_paystack/src/ui/input_formatters.dart';
import 'package:flutter_paystack/src/utils/card_utils.dart';

import 'package:flutter_paystack/src/ui/widgets/input/base_field.dart';

class NumberField extends BaseTextField {
  NumberField(
      {@required PaymentCard card,
      @required TextEditingController controller,
      @required FormFieldSetter<String> onSaved,
      @required Widget suffix})
      : super(
          labelText: 'CARD NUMBER',
          hintText: '0000 0000 0000 0000',
          controller: controller,
          onSaved: onSaved,
          suffix: suffix,
          validator: (String value) => validateCardNum(value, card),
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(19),
            new CardNumberInputFormatter()
          ],
        );

  static String validateCardNum(String input, PaymentCard card) {
    if (input.isEmpty) {
      return Strings.invalidNumber;
    }

    input = CardUtils.getCleanedNumber(input);

    return card.validNumber(input) ? null : Strings.invalidNumber;
  }

  @override
  createState() {
    return super.createState();
  }
}