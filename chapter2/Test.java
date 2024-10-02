class Test {
  
  public static void main(String argv[]) {
    String[] s = argv;
    try {
      System.out.format("Hello %d\n", 123);
    } catch (Exception e) {
      e.printStackTrace();
    }

    for (int i = 0; i < 5; i++) {
      Test t = new Test();
      t.method(10.0f);
    }
  }

  float method(float x) {
    return (float)otherMethod((int)x);
  }

  int otherMethod(int x) {
    return x;
  }
}
