enum Denomination {
  twoHundredNaira,
  fiveHundredNaira,
  oneThousandNaira;

  int get value {
    return switch (this) {
      twoHundredNaira => 200,
      fiveHundredNaira => 500,
      oneThousandNaira => 1000
    };
  }
}
