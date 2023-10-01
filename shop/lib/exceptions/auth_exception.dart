class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail Já Cadastrado!',
    'EMAIL_NOT_FOUND': 'E-mail Não Encontrado!',
    'INVALID_PASSWORD': 'Senha Informada Está Inválida!',
    'USER_DISABLED': 'Usuário / Conta está desabilitado!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Muitas Tentativas Executadas, Tente Mais Tarde!',
    'OPERATION_NOT_ALLOWED': 'Operação Executada Não Permitida!',
    'INVALID_LOGIN_CREDENTIALS': 'Usuário/Senha Inválido!',
    'INVALID_EMAIL': 'E-mail Não Válido Informado!',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação!';
  }
}