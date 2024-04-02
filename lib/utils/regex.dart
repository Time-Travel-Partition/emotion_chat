String? validatePassword(String password) {
  String pattern =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$';
  RegExp regExp = RegExp(pattern);

  if (password.length < 8 || password.length > 16) {
    return '비밀번호는 8자리 이상 16자리 이하입니다.';
  } else if (!regExp.hasMatch(password)) {
    return '비밀번호는 영어, 숫자, 특수문자를 포함해야 합니다.';
  } else {
    return null;
  }
}

String? validatePasswordConfirm(String password, String passwordConfirm) {
  if (password.isEmpty) {
    return '비밀번호를 입력해주세요!';
  } else if (password != passwordConfirm) {
    return '입력한 비밀번호가 서로 다릅니다.';
  } else {
    return null;
  }
}
