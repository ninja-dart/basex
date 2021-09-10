import 'package:ninja_basex/ninja_basex.dart';
import 'package:ninja/ninja.dart';
import 'package:ninja_basex/src/to.dart';

void main() {
  {
    final out = List.filled(4, 0);
    pack('Man'.codeUnits, 64, 63, out, 0);
    print(out);
    // => [46, 0, 0, 0]
  }

  {
    final out = toBaseBytes('Man'.codeUnits, 64);
    print(out);
    // => [19, 22, 5, 46]
  }

  {
    final out = toBaseBytes('Ma'.codeUnits, 64);
    print(out);
    // => [19, 22, 4]
  }

  {
    final out = toBaseBytes('Ma'.codeUnits, 64, padding: 61);
    print(out);
    // => [19, 22, 4, 61]
  }

  {
    final out = toBase('Man'.codeUnits, base64Alphabet);
    print(out);
    // => TWFu
  }

  {
    final out = toBase('Ma'.codeUnits, base64Alphabet);
    print(out);
    // => TWE=
  }

  {
    final bint =
        BigInt.parse('751e76e8199196d454941c45d1b3a323f1433b', radix: 16);
    final input = bigIntToBytes(bint);
    final out = toBaseBytes(input, 32);
    print(out);
    // => [14, 20, 15, 7, 13, 26, 0, 25, 18, 6, 11, 13, 8, 21, 4, 20, 3, 17, 2, 29, 3, 12, 29, 3, 4, 15, 24, 20, 6, 14, 24]
    print(toBase(input, base32Alphabet));
    // => OUPHN2AZSGLNIVEUDRC5DM5DEPYUGOY=
    print(fromBase('OUPHN2AZSGLNIVEUDRC5DM5DEPYUGOY=', base32Alphabet)
        .map((e) => e.toRadixString(16))
        .join());
  }
}
