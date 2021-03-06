import 'dart:math';

/// Converts given data bytes into base encoded string
String toBase(Iterable<int> input, String alphabet, {int? padding = 61}) {
  final bytes = toBaseBytes(input, alphabet.codeUnits.length, padding: padding);
  return baseBytesToString(bytes, alphabet, padding: padding);
}

/// Converts base encoded bytes into base encoded string
String baseBytesToString(List<int> bytes, String alphabet,
    {int? padding = 61}) {
  final sb = StringBuffer();
  for (int i = 0; i < bytes.length; i++) {
    final e = bytes[i];
    sb.write(String.fromCharCode(
        padding == null || e != padding ? alphabet.codeUnitAt(e) : padding));
  }
  return sb.toString();
}

/// Converts given data bytes into base bytes
List<int> toBaseBytes(Iterable<int> input, int base, {int? padding}) {
  int baseBit = (base - 1).bitLength;
  int mask = (pow(2, baseBit) - 1).toInt();
  int inpLength = input.length;
  int outputBlockLength = baseBit;
  while (outputBlockLength % 8 != 0) {
    outputBlockLength += baseBit;
  }
  int inputBlockLength = outputBlockLength ~/ 8;
  outputBlockLength ~/= baseBit;

  int count;
  if (padding == null) {
    int inputBitLength = inpLength * 8;
    count = (inputBitLength / baseBit).ceil();
  } else {
    count =
        (inpLength / inputBlockLength).ceil() * inputBlockLength * 8 ~/ baseBit;
  }

  int inputPointer = 0;
  int outputPointer = 0;

  final out = List<int>.filled(count, 0, growable: true);
  while (inpLength - inputPointer >= inputBlockLength) {
    pack(input.skip(inputPointer).take(inputBlockLength), baseBit, mask, out,
        outputPointer);
    inputPointer += inputBlockLength;
    outputPointer += outputBlockLength;
  }
  if (inpLength != inputPointer) {
    packPartial(input.skip(inputPointer), baseBit, mask, outputBlockLength, out,
        outputPointer,
        padding: padding);
  }
  return out;
}

void pack(
    Iterable<int> input, int base, int mask, List<int> out, int outStart) {
  int v = 0;
  for (int byte in input) {
    v <<= 8;
    v |= byte;
  }
  int count = ((input.length * 8) / base).ceil();
  for (int i = 0; i < count; i++) {
    int j = count - 1 - i;
    out[outStart++] = (v >> j * base) & mask;
  }
}

void packPartial(Iterable<int> input, int base, int mask, int outputBlockLength,
    List<int> out, int outStart,
    {int? padding}) {
  int v = 0;
  for (int byte in input) {
    v <<= 8;
    v |= byte;
  }

  int inputBitLength = input.length * 8;
  int dataCount = (inputBitLength / base).ceil();
  int outputBitCount = dataCount * base;
  int correction = outputBitCount - inputBitLength;
  v = v << correction;
  for (int i = 0; i < dataCount; i++) {
    int j = dataCount - 1 - i;
    out[outStart++] = (v >> j * base) & mask;
  }
  if (padding != null) {
    for (int i = dataCount; i < outputBlockLength; i++) {
      out[outStart++] = padding;
    }
  }
}
