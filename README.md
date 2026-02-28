# 🎬 SineYorum - Film Yorumlama Uygulaması

![Flutter](https://img.shields.io/badge/Flutter-3.19-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![TMDB API](https://img.shields.io/badge/TMDB_API-01D277?logo=themoviedatabase&logoColor=white)
![AdMob](https://img.shields.io/badge/AdMob-Integrated-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)

**Profesyonel film yorumlama uygulaması - TMDB API, Firebase ve AdMob entegrasyonlu**

## ✨ Özellikler

### 🎥 Film Keşfi
- TMDB API ile güncel film verileri
- Netflix tarzı yatay kaydırma
- Kategori bazlı film listeleri
- Arama ve filtreleme

### 💬 Akıllı Yorum Sistemi
- **Spoiler Filtresi** - Spoiler içeren yorumlar gizlenir
- **Detaylı Puanlama** - Senaryo, oyunculuk, müzik için ayrı puan
- **Sosyal Etkileşim** - Beğen/Katılmıyorum butonları
- **Kullanıcı Profilleri** - Google/Apple ile giriş

### 📱 Kullanıcı Deneyimi
- **Koyu Mod** - Sinematik koyu tema
- **İzleme Listesi** - Sonra izlenecekler
- **Kişiselleştirme** - Favori türler
- **Hızlı Arayüz** - Smooth animations

### 💰 Monetizasyon
- **AdMob Banner Reklamlar** - Alt kısımda
- **Geçiş Reklamları** - Film detay girişinde
- **Premium Üyelik** - Reklamsız deneyim
- **Özel Rozetler** - Premium kullanıcılar için

## 🚀 Teknik Stack

### Frontend
- **Flutter 3.19** - Cross-platform mobil geliştirme
- **Dart 3.3** - Modern programlama dili
- **Provider** - State management
- **GetX** - Navigation & dependencies

### Backend & Veritabanı
- **Firebase Authentication** - Google/Apple giriş
- **Firestore** - Yorumlar ve kullanıcı verileri
- **Firebase Storage** - Profil fotoğrafları
- **Firebase Hosting** - Gizlilik politikası

### API'ler
- **TMDB API** - Film verileri, afişler, özetler
- **YouTube API** - Film fragmanları
- **AdMob API** - Reklam entegrasyonu

## 📁 Proje Yapısı

```
SineYorum/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── constants/
│   │   ├── themes/
│   │   └── utils/
│   ├── data/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── datasources/
│   ├── domain/
│   │   ├── entities/
│   │   └── usecases/
│   └── presentation/
│       ├── pages/
│       ├── widgets/
│       └── providers/
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── android/
│   └── app/
│       └── google-services.json
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist
└── web/
    └── index.html
```

## 🔧 Kurulum

### 1. Gereksinimler
```bash
# Flutter kurulumu
flutter doctor

# Firebase CLI
npm install -g firebase-tools

# AdMob hesabı (https://admob.google.com)
```

### 2. Projeyi Klonla
```bash
git clone https://github.com/withazar/SineYorum.git
cd SineYorum
flutter pub get
```

### 3. Firebase Kurulumu
```bash
# Firebase projesi oluştur
firebase init

# Authentication, Firestore, Storage ekle
# google-services.json ve GoogleService-Info.plist dosyalarını ilgili klasörlere kopyala
```

### 4. API Anahtarları
`.env` dosyası oluştur:
```env
TMDB_API_KEY=your_tmdb_api_key
YOUTUBE_API_KEY=your_youtube_api_key
ADMOB_APP_ID=ca-app-pub-3940256099942544~3347511713
ADMOB_BANNER_ID=ca-app-pub-3940256099942544/6300978111
ADMOB_INTERSTITIAL_ID=ca-app-pub-3940256099942544/1033173712
```

### 5. Build & Run
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

## 🎨 Tasarım

### Renk Paleti
```dart
const ColorScheme darkColorScheme = ColorScheme.dark(
  primary: Color(0xFFFFD700),    // Popcorn Sarısı
  secondary: Color(0xFFE50914),  // Netflix Kırmızısı
  surface: Color(0xFF121212),    // Koyu arkaplan
  background: Color(0xFF000000), // Siyah
  onPrimary: Colors.black,
  onSecondary: Colors.white,
);
```

### UI/UX Prensipleri
- **Minimalist tasarım** - Sinematik hava
- **Smooth animations** - 60 FPS performans
- **Gesture controls** - Swipe to dismiss
- **Accessibility** - WCAG 2.1 uyumlu

## 📊 Monetizasyon Stratejisi

### 1. AdMob Entegrasyonu
```dart
// Banner reklamlar - Ana ekran altı
AdWidget(ad: bannerAd)

// Geçiş reklamları - Film detay girişi
InterstitialAd.load()

// Ödüllü reklamlar - Premium özellikler için
RewardedAd.load()
```

### 2. Premium Üyelik
- **Aylık:** $1.99 - Reklamsız + özel rozet
- **Yıllık:** $19.99 - %15 indirim
- **Ömür boyu:** $49.99 - Tüm özellikler

### 3. In-App Purchases
- **Google Play Billing** (Android)
- **App Store Connect** (iOS)
- **RevenueCat** - Abonelik yönetimi

## 🛡️ Gizlilik ve Güvenlik

### Gizlilik Politikası
- Firebase Hosting'de yayınlanacak
- GDPR ve CCPA uyumlu
- Veri şifreleme (AES-256)
- Kullanıcı verileri silme talebi

### Güvenlik Önlemleri
- Firebase Security Rules
- API rate limiting
- Input validation
- XSS/CSRF koruması

## 🚀 Deployment

### Google Play Console
1. **APK/AAB hazırlama**
   ```bash
   flutter build appbundle --release
   flutter build apk --split-per-abi --release
   ```

2. **Store listing hazırlama**
   - Ekran görüntüleri (5 farklı boyut)
   - Feature graphic (1024x500)
   - Açıklama ve keywords (ASO)

3. **Content rating** - 12+ (Film yorumları)

4. **Pricing & distribution** - Ücretsiz + IAP

### App Store Connect
1. **IPA hazırlama**
   ```bash
   flutter build ios --release
   ```

2. **App Store metadata**
   - Screenshots (6.5" ve 5.5" iPhone)
   - App preview videos
   - Description ve keywords

3. **App Review guidelines** - Uyumluluk kontrolü

## 📈 Analytics & Monitoring

### Firebase Analytics
- Kullanıcı davranışları
- Retention rates
- Conversion tracking
- Crash reporting

### Performance Monitoring
- App startup time
- UI rendering performance
- Network latency
- Memory usage

## 🤝 Katkıda Bulunma

1. Fork the project
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 Lisans

MIT License - Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 👤 Yazar

**Mehmet** - [GitHub](https://github.com/withazar)

## 🙏 Teşekkürler

- **TMDB** - Film verileri için
- **Flutter Team** - Harika framework için
- **Firebase Team** - Backend altyapısı için
- **Google AdMob** - Monetizasyon için

---

**SineYorum** - Film tutkunları için en iyi yorum platformu 🎬