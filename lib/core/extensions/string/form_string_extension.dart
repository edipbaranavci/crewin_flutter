extension FormStringExtension on String? {
  String? get defaultEmptyValidator {
    final value = this ?? '';
    if (this == null || value.isEmpty) {
      return 'Lütfen boş alan bırakmayın.';
    }
    return null;
  }
}
