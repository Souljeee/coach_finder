enum ConfirmCodeStatus { CONFIRMED, WRONG_CODE, NONEXISTENT_USER }

ConfirmCodeStatus getConfirmationStatusFromString({
  required confirmationStatusString,
}) =>
    switch (confirmationStatusString) {
      'CONFIRMED' => ConfirmCodeStatus.CONFIRMED,
      'WRONG_CODE' => ConfirmCodeStatus.WRONG_CODE,
      _ => ConfirmCodeStatus.NONEXISTENT_USER,
    };
