class Language {
  bool Selected;
  int LanguageId;
  String Name;
  String TranslatedName;
  String code;
  Language(
      {this.Selected,
      this.LanguageId,
      this.Name,
      this.TranslatedName,
      this.code});

  static List<Language> getLanguages() {
    return <Language>[
      Language(
          Selected: false,
          LanguageId: 1,
          Name: 'English',
          TranslatedName: '',
          code: 'en'),
      Language(
          Selected: false,
          LanguageId: 2,
          Name: 'Hindi',
          TranslatedName: 'हिन्दी',
          code: 'hi'),
    ];
  }
}
