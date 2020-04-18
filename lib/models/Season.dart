class Season {
  
  String season;

  Season({this.season});
  static List<Season> getSeason(){
    return<Season>[
       Season(season: 'Kharif'),
       Season(season: 'Rabi'),
       Season(season: 'Zaid'),
       
    ];
  }
}