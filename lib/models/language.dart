class Language {
  bool Selected;
  int LanguageId;
  String Name;
  String TranslatedName;  

  Language({this.Selected,this.LanguageId,this.Name,this.TranslatedName});

  static List<Language> getLanguages(){
    return<Language>[
        Language(Selected:false,LanguageId: 1,Name: 'English',TranslatedName: ''),
        Language(Selected:false,LanguageId: 2,Name: 'Hindi',TranslatedName: 'हिन्दी'),
        Language(Selected:false,LanguageId: 3,Name: 'Punjabi',TranslatedName: 'ਪੰਜਾਬੀ'),
        Language(Selected:false,LanguageId: 4,Name: 'Telugu',TranslatedName: 'తెలుగు'),
        Language(Selected:false,LanguageId: 5,Name: 'Tamil',TranslatedName: 'தமிழ்'),
        Language(Selected:false,LanguageId: 6,Name: 'kannada',TranslatedName: 'ಕನ್ನಡ'),
        Language(Selected:false,LanguageId: 7,Name: 'Marathi',TranslatedName: 'मराठी'),
        Language(Selected:false,LanguageId: 8,Name: 'Gujarati',TranslatedName: 'ગુજરાતી'),
        Language(Selected:false,LanguageId: 8,Name: 'Malyalam',TranslatedName: 'മലയാളം'),
    ];
  }
}