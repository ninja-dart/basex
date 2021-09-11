# basex

Convert data to any base (base32, base64, base58, etc) using an alphabet set. Supports disabling padding.
The advantage of this package is that it allows converting data bytes to base encoded bytes. 

# To base

```dart
import 'package:ninja_basex/ninja_basex.dart';
import 'package:ninja/ninja.dart';

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
    final bint = BigInt.parse('751e76e8199196d454941c45d1b3a323f1433bd6', radix: 16);
    final input = bigIntToBytes(bint);
    final out = toBaseBytes(input, 32);
    print(out);
    // => [14, 20, 15, 7, 13, 26, 0, 25, 18, 6, 11, 13, 8, 21, 4, 20, 3, 17, 2, 29, 3, 12, 29, 3, 4, 15, 24, 20, 6, 14, 30, 22]
  }
}
```

# From bytes

```dart
import 'package:ninja_basex/ninja_basex.dart';

void main() {
  final bytes = fromBase(
      'RVIHETOST35MQXOPH66OL2WX6IJQQM54FIQMNKTKZOLCFS72OMBK6762BW6U74VB3RCZTE5J6533BE2FZRLJ3M3ZK37ZFW7VVDDBEDPVQICZ4OS3CAWACOTFX6GPTCCR2DOCQ6PET2KQNFNEZGMTQPJVNA',
      base32Alphabet);
  print(bytes);
  print(bytes.map((e) => e.toRadixString(16)).toList());
}
```