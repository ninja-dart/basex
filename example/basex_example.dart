import 'package:ninja_basex/ninja_basex.dart';
import 'package:ninja/ninja.dart';

void main() {
  {
    final out = List.filled(4, 0);
    pack('Man'.codeUnits, 64, 63, out, 0);
    print(out);
  }

  {
    final out = toBaseBytes('Man'.codeUnits, 64);
    print(out);
  }

  {
    final out = toBaseBytes('Ma'.codeUnits, 64);
    print(out);
  }

  {
    final out = toBaseBytes('Ma'.codeUnits, 64, padding: 61);
    print(out);
  }

  {
    final out = toBase('Man'.codeUnits, base64Alphabet);
    print(out);
  }

  {
    final out = toBase('Ma'.codeUnits, base64Alphabet);
    print(out);
  }
  
  {
    final bint = BigInt.parse('751e76e8199196d454941c45d1b3a323f1433bd6', radix: 16);
    final input = bigIntToBytes(bint);
    final out = toBaseBytes(input, 32);
    print(out);
  }
}
