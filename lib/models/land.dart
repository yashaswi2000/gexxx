class Landtype {
  
  String landtype;

  Landtype({this.landtype});
  static List<Landtype> getLandtype(){
    return<Landtype>[
       Landtype(landtype: 'irrigated'),
       Landtype(landtype: 'Rainfed'),
       Landtype(landtype: 'Unirrigated'),
       
    ];
  }
}

class Landtopography {
  
  String landtopography;

  Landtopography({this.landtopography});
  static List<Landtopography> getLandtopography(){
    return<Landtopography>[
       Landtopography(landtopography: 'leveled'),
       Landtopography(landtopography: 'Undulated'),
       
       
       
    ];
  }
}

class Soil{
  String soil;
  Soil({this.soil});
  static List<Soil> getsoil(){
    return <Soil>[
      Soil(soil: 'Alluvial Soil'),
      Soil(soil: 'Black Soil'),
      Soil(soil: 'Desert Soil'),
      Soil(soil: 'Laterite Soil'),
      Soil(soil: 'Mountain soil'),
      Soil(soil: 'Red soil'),
      Soil(soil: 'Saline/alkaline soil'),
    ];
  }
}