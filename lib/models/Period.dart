class Period {
  
  String period;

  Period({this.period});
  static List<Period> getperiod(){
    return<Period>[
       Period(period: '2020-2021'),
       Period(period: '2021-2022'),
       Period(period: '2022-2023'),
       Period(period: '2023-2024'),
       Period(period: '2024-2025'),
       Period(period: '2025-2026'),
       Period(period: '2026-2027'),
       Period(period: '2027-2028'),
       Period(period: '2028-2029'),
    ];
  }
}