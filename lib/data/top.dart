import 'package:management/data/one.dart';

List<Money> getertop() {
  Money snap_food = Money();
  snap_food.time = 'jan 30,2022';
  snap_food.image = 'mac.jpg';
  snap_food.buy = true;
  snap_food.fee = '- \$ 100';
  snap_food.name = 'macdonald';
  Money snap = Money();
  snap.image = 'cre.png';
  snap.time = 'today';
  snap.buy = true;
  snap.name = 'Transfer';
  snap.fee = '- \$ 60';

  return [snap_food, snap];
}
