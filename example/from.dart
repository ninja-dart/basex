import 'package:ninja_basex/ninja_basex.dart';

void main() {
  final bytes = fromBase(
      'RVIHETOST35MQXOPH66OL2WX6IJQQM54FIQMNKTKZOLCFS72OMBK6762BW6U74VB3RCZTE5J6533BE2FZRLJ3M3ZK37ZFW7VVDDBEDPVQICZ4OS3CAWACOTFX6GPTCCR2DOCQ6PET2KQNFNEZGMTQPJVNA',
      base32Alphabet);
  print(bytes);
  print(bytes.map((e) => e.toRadixString(16)).toList());
}
