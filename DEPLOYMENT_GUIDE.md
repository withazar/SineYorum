# 🚀 SineYorum Deployment Guide

Bu rehber, SineYorum uygulamasını Google Play Console ve App Store'da yayınlamak için gereken tüm adımları içerir.

## 📋 Ön Hazırlıklar

### 1. Gereksinimler
- [x] **Google Play Console** hesabı ($25 one-time fee)
- [x] **Apple Developer Program** hesabı ($99/year)
- [x] **Firebase** projesi (ücretsiz)
- [x] **AdMob** hesabı (ücretsiz)
- [x] **TMDB API** anahtarı (ücretsiz)
- [x] **YouTube API** anahtarı (ücretsiz)

### 2. Ortam Değişkenleri
`.env` dosyasını güncelleyin:
```env
# Production AdMob IDs (Firebase'den alın)
ADMOB_APP_ID=ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy
ADMOB_BANNER_ID=ca-app-pub-xxxxxxxxxxxxxxxx/zzzzzzzzzz
ADMOB_INTERSTITIAL_ID=ca-app-pub-xxxxxxxxxxxxxxxx/aaaaaaaaaa

# Production API Keys
TMDB_API_KEY=your_production_tmdb_key
YOUTUBE_API_KEY=your_production_youtube_key

# Firebase Config
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_PROJECT_ID=your_project_id
# ... diğer Firebase config'ler

# Feature Flags
DEBUG_MODE=false
SHOW_TEST_ADS=false
```

## 📱 Google Play Console Deployment

### 1. APK/AAB Hazırlama
```bash
# Release APK (split by ABI)
flutter build apk --release --split-per-abi

# App Bundle (Google Play için)
flutter build appbundle --release
```

### 2. Keystore Oluşturma
```bash
# Yeni keystore oluştur
keytool -genkey -v -keystore sineyorum.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias sineyorum

# key.properties dosyası oluştur
echo "storePassword=your_password
keyPassword=your_password
keyAlias=sineyorum
storeFile=sineyorum.keystore" > android/key.properties
```

### 3. Google Play Console Setup
1. **Hesap oluşturma** ($25 öde)
2. **Uygulama oluşturma**:
   - Paket adı: `com.withazar.sineyorum`
   - Başlık: `SineYorum`
   - Kısa açıklama: `Film yorumlama platformu`
   - Tam açıklama: [README.md'den al]

3. **Store listing hazırlama**:
   - **Ekran görüntüleri** (5 farklı boyut):
     - 7 inç tablet (432 x 270)
     - 10 inç tablet (480 x 320)
     - Telefon (1080 x 1920)
     - 7 inç tablet (1024 x 600)
     - 10 inç tablet (1280 x 800)
   
   - **Feature graphic** (1024 x 500)
   - **Icon** (512 x 512)
   - **Video** (30 saniye, MP4)

4. **Content rating**:
   - Kategori: Sosyal
   - Yaş sınırı: 12+
   - İçerik: Film yorumları

5. **Pricing & distribution**:
   - Ücretsiz
   - Tüm ülkeler
   - Contains ads (Evet)
   - In-app purchases (Evet)

### 4. Privacy Policy
Firebase Hosting'de yayınlayın:
```bash
# Privacy policy oluştur
echo "<html>...</html>" > web/privacy.html

# Deploy to Firebase
firebase deploy --only hosting
```

URL: `https://sineyorum.web.app/privacy`

### 5. App Signing
1. **Play App Signing** etkinleştir
2. **Upload certificate** yükle
3. **App bundle** yükle (.aab dosyası)
4. **Release tracks** ayarla:
   - Internal testing
   - Closed testing
   - Open testing
   - Production

## 🍎 App Store Connect Deployment

### 1. iOS Setup
```bash
# iOS build hazırlama
flutter build ios --release --no-codesign

# Xcode'da aç
open ios/Runner.xcworkspace
```

### 2. App Store Connect Setup
1. **Yeni uygulama oluştur**:
   - Platform: iOS
   - Ad: `SineYorum`
   - Primary language: Turkish
   - Bundle ID: `com.withazar.sineyorum`
   - SKU: `sineyorum-ios`

2. **App Information**:
   - Category: Entertainment
   - Subcategory: Social Networking
   - Age Rating: 12+
   - Copyright: © 2024 Mehmet

3. **Pricing and Availability**:
   - Price: Free
   - Available Date: Today
   - Territories: All

4. **In-App Purchases**:
   - Premium Monthly: $1.99
   - Premium Yearly: $19.99
   - Lifetime: $49.99

### 3. Screenshots (iOS)
- **6.5" iPhone** (1242 x 2688)
- **5.5" iPhone** (1242 x 2208)
- **iPad Pro** (2048 x 2732)
- **App Preview videos** (15-30 saniye)

### 4. App Review
1. **TestFlight** ile test et
2. **App Store Review** gönder
3. **Guidelines** kontrolü:
   - 1.1: Objectionable Content
   - 1.2: User Generated Content
   - 5.1: Privacy

## 🔐 Production Security

### 1. Firebase Security Rules
```rules
// Production rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Stricter rules for production
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        request.auth.uid == userId;
    }
    
    match /reviews/{reviewId} {
      allow read: if true;
      allow create: if request.auth != null && 
        request.auth.token.email_verified == true;
      allow update, delete: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
  }
}
```

### 2. AdMob Production Setup
1. **Test IDs'yi kaldır**:
   - `AndroidManifest.xml`
   - `.env` file
   - `AppConstants.dart`

2. **Production IDs ekle**:
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
   ```

3. **Ad units oluştur**:
   - Banner: Ana ekran altı
   - Interstitial: Film detay girişi
   - Rewarded: Premium özellikler

### 3. API Rate Limiting
```dart
// TMDB API rate limiting
const rateLimit = RateLimiter(
  maxRequests: 40,
  per: Duration(seconds: 10),
);

// YouTube API caching
const cacheDuration = Duration(hours: 1);
```

## 📊 Analytics & Monitoring

### 1. Firebase Analytics Events
```dart
// Track important events
await FirebaseAnalytics.instance.logEvent(
  name: 'movie_viewed',
  parameters: {
    'movie_id': movieId,
    'category': 'action',
    'duration': watchTime,
  },
);
```

### 2. Crashlytics Setup
```dart
// Error reporting
FirebaseCrashlytics.instance.recordError(
  error,
  stackTrace,
  reason: 'Movie loading failed',
);
```

### 3. Performance Monitoring
- App startup time
- Screen rendering
- Network latency
- Ad loading time

## 💰 Monetization Strategy

### 1. Ad Placement Strategy
- **Banner ads**: Ana ekran altı (non-intrusive)
- **Interstitial ads**: Film detay girişi (%30 probability)
- **Rewarded ads**: Premium özellikler için

### 2. Premium Features
- **Reklamsız deneyim**
- **Özel profil rozetleri**
- **Gelişmiş filtreler**
- **Özel tema seçenekleri**

### 3. Pricing Tiers
```dart
const pricing = {
  'monthly': 1.99,    // $1.99/ay
  'yearly': 19.99,    // $19.99/yıl (%15 indirim)
  'lifetime': 49.99,  // $49.99 (ömür boyu)
};
```

## 🚨 Launch Checklist

### Pre-Launch
- [ ] AdMob production IDs ekle
- [ ] Firebase security rules güncelle
- [ ] API rate limiting etkinleştir
- [ ] Error reporting ayarla
- [ ] Analytics events ekle
- [ ] Privacy policy deploy et
- [ ] Test cihazları kaldır
- [ ] Debug mode kapat

### Store Submission
- [ ] Screenshots hazırla (5 boyut)
- [ ] App description optimize et (ASO)
- [ ] Keywords ekle: film, yorum, sinema, review
- [ ] Age rating ayarla (12+)
- [ ] Content rating tamamla
- [ ] In-app purchases ekle
- [ ] App signing tamamla

### Post-Launch
- [ ] App store link'lerini paylaş
- [ ] Social media duyurusu yap
- [ ] Kullanıcı feedback topla
- [ ] Analytics verilerini izle
- [ ] Crash reports kontrol et
- [ ] App store reviews yanıtla

## 📈 ASO (App Store Optimization)

### Title & Description
```
SineYorum - Film Yorumlama Platformu

Film tutkunları için en iyi yorum platformu! 
Binlerce film hakkında yorum yap, puan ver, izleme listesi oluştur.

🎬 Özellikler:
- TMDB ile güncel film verileri
- Spoiler filtresi ile güvenli yorum
- Detaylı puanlama sistemi
- Kişiselleştirilmiş öneriler
- Sosyal etkileşim

📱 Keywords:
film, sinema, yorum, review, movie, rating, puan, izleme listesi
```

### Screenshot Strategy
1. **Ana ekran** - Film keşfi
2. **Film detay** - Yorumlar ve puan
3. **Profil** - Kişiselleştirme
4. **İzleme listesi** - Organizasyon
5. **Premium** - Reklamsız deneyim

## 🔧 Maintenance

### Regular Updates
- **Her 2 haftada**: Minor bug fixes
- **Her ayda**: Feature updates
- **Her 3 ayda**: Major updates

### Monitoring
- **Daily**: Crash reports, revenue
- **Weekly**: User engagement, retention
- **Monthly**: Feature usage, feedback

### Backup Strategy
- **Firestore**: Weekly exports
- **User data**: GDPR compliance
- **Media files**: Cloud Storage backup

## 🆘 Support & Contact

### User Support
- **Email**: support@sineyorum.com
- **In-app**: Feedback form
- **Social**: Twitter, Instagram

### Technical Support
- **GitHub Issues**: Bug reports
- **Firebase**: Performance issues
- **AdMob**: Ad revenue issues

### Legal
- **Privacy Policy**: https://sineyorum.web.app/privacy
- **Terms of Service**: https://sineyorum.web.app/terms
- **GDPR Compliance**: User data deletion

---

**SineYorum** başarılı bir şekilde yayınlandıktan sonra, kullanıcı feedback'lerine göre güncellemeler yapmayı unutmayın. İyi şanslar! 🎬