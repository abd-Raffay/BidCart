class Exceptions {
  final String message;

  const Exceptions([this.message="An Unknown error occured"]);

  factory Exceptions.code(String code){
    switch(code){
      case 'weak-password':
        return const Exceptions('Please enter a stronger password');
      case 'invalid-email':
        return const Exceptions('Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const Exceptions('An account already exists for that email');
      case 'operation-not-allowed':
        return const Exceptions('Operation is not allowed. Please contact support');
      case 'user-disabled':
        return const Exceptions('This user has been disabled. Please contact support for help');
      case 'invalid-password':
        return const Exceptions('Please enter a stronger password');
      case 'wrong-password':
        return const Exceptions('Incorrect password, please try again.');
      case 'too-many-requests':
        return const Exceptions('Too many requests, Service Temporarily blocked');
      case 'invalid-argument':
        return const Exceptions('An invalid argument was provided to an Authentication method');
      case 'session-cookie-expired':
        return const Exceptions('The provided session cookie is expired.');
      case 'uid-already-exists':
        return const Exceptions('The provided uid is already in use by an existing user');

      default:
        return const Exceptions();
    }


  }

  @override
  String toString() {
    return message;
  }
}