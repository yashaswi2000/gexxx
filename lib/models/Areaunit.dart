class Areaunit {
  
  String areaunit;

  Areaunit({this.areaunit});
  static List<Areaunit> getAreaunit(){
    return<Areaunit>[
       Areaunit(areaunit: 'Acre'),
       Areaunit(areaunit: 'Bigha'),
       Areaunit(areaunit: 'Hectarer'),
       
    ];
  }
}