# HSI Renk Uzayı Tabanlı Düşük Işık Görüntü İyileştirme Algoritması

Bu proje, düşük ışık seviyeli görüntülerin kalitesini artırmak amacıyla yeni bir HSI tabanlı iyileştirme algoritması geliştirmeyi hedeflemektedir. Bu algoritma, düşük ışık seviyeli görüntülerin parlaklığını artırırken görüntü kontrastını ve detaylarını korumaktadır.

## Proje Özeti

Geliştirilen algoritma, RGB görüntülerini HSI renk uzayına dönüştürerek yoğunluk (intensity) ve doygunluk (saturation) bileşenlerini farklı iyileştirme yöntemleriyle işlerken renk (hue) bileşenini değiştirmez. 

- **S Bileşeni (Doygunluk)**: Segmentasyonlu üstel iyileştirme algoritması uygulanır.
- **I Bileşeni (Yoğunluk)**: Histogram eşitlemesi uygulanır ve ardından Wavelet dönüşümü ile yüksek ve düşük frekanslı alt bantlara ayrılır. Düşük frekanslı alt banda Retinex algoritması, yüksek frekanslı alt banda ise bulanık iyileştirme uygulanır.
- Son olarak, bileşen I ters Wavelet dönüşümü ile yeniden yapılandırılır ve geliştirilmiş S bileşenleri ile sentezlenerek net bir RGB görüntü elde edilir.

## Algoritmanın İş Akışı

1. **RGB'den HSI'a Dönüşüm**: RGB görüntüsü HSI renk uzayına dönüştürülür.
2. **Doygunluk İyileştirmesi**: S bileşenine segmentasyonlu üstel iyileştirme uygulanır.
3. **Yoğunluk İyileştirmesi**:
   - Histogram eşitlemesi uygulanır.
   - Wavelet dönüşümü ile alt bantlara ayrılır.
   - Düşük frekanslı alt banda Retinex algoritması, yüksek frekanslı alt banda bulanık iyileştirme uygulanır.
4. **Ters Wavelet Dönüşümü**: I bileşeni yeniden yapılandırılır.
5. **HSI'dan RGB'ye Dönüşüm**: İyileştirilmiş HSI bileşenleri RGB uzayına dönüştürülerek net görüntü elde edilir.


## Proje Sonuçları

Proje kapsamında geliştirilen algoritmanın başarısını göstermek amacıyla bazı test görüntüleri üzerinde iyileştirme işlemleri yapılmış ve başarılı sonuçlar elde edilmiştir.
