enum LottieName { noContent }

extension LottieNameExtension on LottieName {
  String get name {
    switch(this){
      case LottieName.noContent:
        return 'no_content';
    }
  }
}
