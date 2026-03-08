enum Denomination {
  fiveNaira,
  tenNaira,
  twentyNaira,
  fiftyNaira,
  hundredNaira,
  twoHundredNaira,
  fiveHundredNaira,
  oneThousandNaira;

  int get value {
    return switch (this) {
      fiveNaira => 5,
      tenNaira => 10,
      twentyNaira => 20,
      fiftyNaira => 50,
      hundredNaira => 100,
      twoHundredNaira => 200,
      fiveHundredNaira => 500,
      oneThousandNaira => 1000
    };
  }
}
