import 'package:memory_game/models/image.dart';

class MemoryBrain {
  List<ImageData> _imageBank = [
    ImageData('images/image1.jpg', 1),
    ImageData('images/image2.jpg', 2),
    ImageData('images/image3.jpg', 3),
    ImageData('images/image4.jpg', 4),
    ImageData('images/image5.png', 5),
    ImageData('images/image6.jpg', 6),
    ImageData('images/image7.jpg', 7),
    ImageData('images/image8.jpg', 8),
    ImageData('images/image1 - Copy.jpg', 1),
    ImageData('images/image2 - Copy.jpg', 2),
    ImageData('images/image3 - Copy.jpg', 3),
    ImageData('images/image4 - Copy.jpg', 4),
    ImageData('images/image5 - Copy.png', 5),
    ImageData('images/image6 - Copy.jpg', 6),
    ImageData('images/image7 - Copy.jpg', 7),
    ImageData('images/image8 - Copy.jpg', 8),
  ];

  List getListElements() {
    _imageBank.shuffle();
    return _imageBank;
  }
}
