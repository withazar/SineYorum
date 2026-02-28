# Firebase Configuration Guide for SineYorum

## 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `SineYorum`
4. Enable Google Analytics (recommended)
5. Choose Analytics location
6. Click "Create project"

## 2. Add Apps to Firebase Project

### Android App
1. Click Android icon (🖥️)
2. Enter:
   - Android package name: `com.withazar.sineyorum`
   - App nickname: `SineYorum`
   - Debug signing certificate SHA-1 (optional)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### iOS App (Optional)
1. Click iOS icon (🍎)
2. Enter:
   - iOS bundle ID: `com.withazar.sineyorum`
   - App nickname: `SineYorum`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### Web App (for Privacy Policy)
1. Click Web icon (🌐)
2. Enter:
   - App nickname: `SineYorum Web`
3. Note the configuration

## 3. Enable Firebase Services

### Authentication
1. Go to Authentication → Sign-in method
2. Enable:
   - Google
   - Apple (for iOS)
   - Email/Password (optional)

### Firestore Database
1. Go to Firestore Database → Create database
2. Start in test mode (for development)
3. Choose location closest to your users
4. Create collections:
   - `users` (for user profiles)
   - `reviews` (for movie reviews)
   - `watchlist` (for user watchlists)
   - `reports` (for content reports)

### Storage
1. Go to Storage → Get started
2. Start in test mode (for development)
3. Rules will be updated for production

### Hosting (for Privacy Policy)
1. Go to Hosting → Get started
2. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```
3. Initialize hosting:
   ```bash
   firebase init hosting
   ```
4. Deploy privacy policy

## 4. Security Rules

### Firestore Rules
Update `firestore.rules`:

```rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own profile
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Anyone can read reviews, authenticated users can write
    match /reviews/{reviewId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
    
    // Users can manage their own watchlist
    match /watchlist/{userId}/{movieId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Admins can read reports
    match /reports/{reportId} {
      allow read: if request.auth != null && 
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isAdmin == true;
      allow create: if request.auth != null;
    }
  }
}
```

### Storage Rules
Update `storage.rules`:

```rules
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User profile images
    match /profile_images/{userId}/{imageName} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 5. Environment Variables

Create `.env` file in project root:

```env
# Firebase Config (from google-services.json)
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
FIREBASE_MEASUREMENT_ID=your_measurement_id

# TMDB API
TMDB_API_KEY=your_tmdb_api_key
TMDB_ACCESS_TOKEN=your_tmdb_access_token

# YouTube API
YOUTUBE_API_KEY=your_youtube_api_key

# AdMob IDs (Test IDs for development)
ADMOB_APP_ID=ca-app-pub-3940256099942544~3347511713
ADMOB_BANNER_ID=ca-app-pub-3940256099942544/6300978111
ADMOB_INTERSTITIAL_ID=ca-app-pub-3940256099942544/1033173712
ADMOB_REWARDED_ID=ca-app-pub-3940256099942544/5224354917
```

## 6. API Keys

### TMDB API
1. Go to [TMDB](https://www.themoviedb.org/settings/api)
2. Create account/Login
3. Request API key
4. Add to `.env` file

### YouTube API
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create new project: `SineYorum`
3. Enable YouTube Data API v3
4. Create API key
5. Add to `.env` file

### AdMob
1. Go to [AdMob](https://admob.google.com/)
2. Create app: `SineYorum`
3. Get App ID and Ad Unit IDs
4. Update in `.env` and `AndroidManifest.xml`

## 7. Testing

### Test Users
Create test users in Firebase Authentication:
- Regular user: `test@example.com`
- Premium user: `premium@example.com`
- Admin user: `admin@example.com`

### Test Ads
Use test Ad Unit IDs during development:
- Banner: `ca-app-pub-3940256099942544/6300978111`
- Interstitial: `ca-app-pub-3940256099942544/1033173712`
- Rewarded: `ca-app-pub-3940256099942544/5224354917`

### Test Devices
Add test device IDs to `ads_request_configuration.xml`:
1. Run app in debug mode
2. Check Logcat for: `Use RequestConfiguration.Builder.setTestDeviceIds`
3. Add device ID to XML file

## 8. Deployment Checklist

### Before Production
- [ ] Update AdMob IDs to production IDs
- [ ] Update Firebase rules to production mode
- [ ] Remove test device IDs
- [ ] Set `DEBUG_MODE=false` in `.env`
- [ ] Update privacy policy URL
- [ ] Test in-app purchases
- [ ] Test ad loading and display
- [ ] Verify Firebase Security Rules
- [ ] Backup database

### Production AdMob IDs
Replace test IDs with your production IDs:
- `AndroidManifest.xml`
- `.env` file
- `AppConstants.dart`
- `AdsProvider.dart`

### Production Firebase Rules
Update rules to restrict access:
- Remove public read access where not needed
- Add validation for data
- Set up indexes for queries
- Enable billing for increased limits

## 9. Monitoring

### Firebase Analytics
- Track user engagement
- Monitor crash reports
- Analyze user behavior
- Set up conversion tracking

### AdMob Analytics
- Monitor ad revenue
- Track ad performance
- Analyze user demographics
- Optimize ad placement

### Performance Monitoring
- App startup time
- Screen rendering
- Network requests
- Memory usage

## 10. Support

### Documentation
- [Firebase Docs](https://firebase.google.com/docs)
- [FlutterFire Docs](https://firebase.flutter.dev/)
- [AdMob Docs](https://developers.google.com/admob)
- [TMDB API Docs](https://developers.themoviedb.org/3)

### Community
- [Flutter Dev](https://flutter.dev/)
- [Firebase Community](https://firebase.community/)
- [GitHub Issues](https://github.com/withazar/SineYorum/issues)

### Contact
For issues with this configuration:
- Create issue on GitHub
- Check Firebase status: [status.firebase.google.com](https://status.firebase.google.com/)
- Contact Firebase support