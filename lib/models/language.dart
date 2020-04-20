class Language {
  bool Selected;
  int LanguageId;
  String Name;
  String TranslatedName;  
  String code;
  Language({this.Selected,this.LanguageId,this.Name,this.TranslatedName,this.code});

  static List<Language> getLanguages(){
    return<Language>[
        Language(Selected:false,LanguageId: 1,Name: 'English',TranslatedName: '',code: 'en'),
        Language(Selected:false,LanguageId: 2,Name: 'Hindi',TranslatedName: 'हिन्दी',code: 'hi'),
        Language(Selected:false,LanguageId: 3,Name: 'Punjabi',TranslatedName: 'ਪੰਜਾਬੀ',code: 'pa'),
        Language(Selected:false,LanguageId: 4,Name: 'Telugu',TranslatedName: 'తెలుగు',code: 'te'),
        Language(Selected:false,LanguageId: 5,Name: 'Tamil',TranslatedName: 'தமிழ்',code: 'ta'),
        Language(Selected:false,LanguageId: 6,Name: 'kannada',TranslatedName: 'ಕನ್ನಡ',code: 'kn'),
        Language(Selected:false,LanguageId: 7,Name: 'Marathi',TranslatedName: 'मराठी',code: 'mr'),
        Language(Selected:false,LanguageId: 8,Name: 'Gujarati',TranslatedName: 'ગુજરાતી',code: 'gu'),
        Language(Selected:false,LanguageId: 8,Name: 'Malyalam',TranslatedName: 'മലയാളം',code: 'ml'),
    ];
  }
}