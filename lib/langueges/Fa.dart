import 'package:bus_information/abstracts/Languages.dart';
import 'package:flutter/cupertino.dart';

class Fa extends Languages {
  @override
  TextDirection get direction => TextDirection.rtl;

  @override
  String get name => 'نام';

  @override
  String get appName => 'سامانه اتوبوسرانی';

  @override
  String get drivers => 'راننده ها';

  @override
  String get buses => 'اتوبوس ها';

  @override
  String get eveningShift => 'شیفت عصر';

  @override
  String get firstOverTime => 'اضافه کار اول';

  @override
  String get morningShift => 'شیفت صبح';

  @override
  String get secondOverTime => 'اضافه کار دوم';

  @override
  String get shiftSwitching => 'تعویض شیفت';

  @override
  String get active => 'فعال';

  @override
  String get coordination => 'هماهنگی';

  @override
  String get inActive => 'غیر فعال';

  @override
  String get vacation => 'مرخصی';

  @override
  String get submit => 'تایید';

  @override
  String get operationDone => 'عملیات با موفقیت انجام شد';

  @override
  String get repeatedName => 'نام تکراری';

  @override
  String get shouldNotEmpty => 'نباید خالی باشد';
}
