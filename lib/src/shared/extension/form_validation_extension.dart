//this extension works on sign Up and logIn pages for forms validation

extension FormValidationExtension on String {
  //------------for password-------------
  String? validPassword() {
    if (this.isNotEmpty) {
      if (this.length < 8) return 'Please password must be 8';
    }
    return null;
  }

  //------------for username-------------
  String? validUsername() {
    if (this.isNotEmpty) {
      if (this.length < 4) return 'Please Username must be at least 4';
      if (this.contains(' '))
        return 'Please Username does not contain a space.';
    }
    return null;
  }

  //----------for submitting--------
  bool validSubmitUsername() {
    return (this.isNotEmpty && this.length >= 4 && !this.contains(' '));
  }

  bool validSubmitPassword() {
    return (this.isNotEmpty && this.length == 8);
  }
}
