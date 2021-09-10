import 'dart:typed_data';

List<int> fromBaseBytes(List<int> input, int base) {
  int baseBit = (base - 1).bitLength;
  final outLenInBits = input.length * baseBit;
  int shift = (8 - (outLenInBits % 8)) % 8;
  BigInt v = BigInt.zero;
  for (int i = 0; i < input.length; i++) {
    v <<= baseBit;
    v |= BigInt.from(input[i] & 0xff);
  }
  v <<= shift;
  final outLenInBytes = (outLenInBits / 8).ceil();
  final ret = Uint8List(outLenInBytes);
  for (int i = 0; i < outLenInBytes; i++) {
    final byte = (v & BigInt.from(0xFF)).toInt();
    ret[ret.length - i - 1] = byte;
    v >>= 8;
  }
  return ret;
}

List<int> fromBase(String input, String alphabet, {int padding = 61}) {
  final ret = input.codeUnits
      .map((e) => e == padding ? -2 : alphabet.indexOf(String.fromCharCode(e)))
      .where((e) => e != -2)
      .toList();
  if (ret.contains(-1)) {
    throw Exception('invalid input');
  }
  return fromBaseBytes(ret, alphabet.codeUnits.length);
}
