# 📊 Dhan Saarthi

A Flutter application built as an interview task that showcases user authentication using Supabase, mutual fund analysis, interactive chart visualization, and personalized user watchlists.


---

## ✨ Core Features

- **🔐 User Authentication (Supabase):**
    *   User enters phone number.
    *   App tries to sign them in using Supabase OTP.
    *   If the user doesn't exist, the app automatically signs them up and sends OTP.
    *   No separate sign-up screen needed — one flow for both!
    *   Fast, frictionless authentication experience.

- **📈 Mutual Fund Discovery & Analysis:**
    - Explore mutual funds *(data source: Mock API)*
    - Detailed fund info (NAV, Bar and Line Charts)

- **📊 Interactive Charts:**
    - Line charts visualizing fund performance over time
    - Built using [`fl_chart`](https://pub.dev/packages/fl_chart) or your preferred library

- **⭐ Personalized Watchlist:**
    - Dyanamic Watchlists
    - Mocked Mutual Fund data

- **⚙️ State Management:**
    - Powered by  `GetX`

- **📱 Responsive UI:**
    - Adapts well across different screen sizes

---

## 🚀 Getting Started

### 🔧 Prerequisites

- **Flutter SDK:** `>=3.29.x` (or latest stable)
- **Dart SDK:** (included with Flutter)
- **IDE:** Android Studio / VS Code (Flutter plugin enabled)
- **Supabase Project:** Set up at [https://supabase.com](https://supabase.com)

---

### 📥 Installation & Setup

1. **Clone the Repo:**

```bash
git clone [https://github.com/your-username/your-repo.git](https://github.com/imukulgehlot/dhan_saarthi_flutter)
cd your-repo
```

1. **Install Dependencies:**

```bash
flutter pub get
```

1. **Supabase Configuration:**

- Create `root_directory/.env`:

```env
  SUPABASE_URL = 'https://your-project.supabase.co';
  SUPABASE_ANON_KEY = 'your-anon-key';

```

> ⚠️ Don't forget to `.gitignore` this file!

1. **Initialize Supabase:**

```dart
// main.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(MyApp());
}
```


---

### ▶️ Run the App

Choose a device/emulator & hit:

```bash
flutter run
```

---

## 🧰 Technologies & Packages Used

- **Flutter & Dart**
- [`supabase_flutter`](https://pub.dev/packages/supabase_flutter)
- State Management: `GetX` / `Riverpod` / `Provider` *(your pick)*
- Charts: `fl_chart` / `syncfusion_flutter_charts`
- HTTP: `dio` / `http`
- [Add any extras: like `shared_preferences`, `intl`, etc.]


---

## 💡 Development Decisions

- **Why Supabase?**
    - Fast setup for auth + Postgres + RLS = perfect combo for interviews 🔥

- **State Management:**
    - [`GetX`] chosen for lightweight reactive state, navigation, and DI in one

- **Mutual Fund Data Handling:**
    - Stored in Supabase table `mutual_funds`, displayed after filtering/sorting
    - Watchlist linked by user ID in `user_watchlists`

- **UI/UX:**
    - Prioritized clarity over complexity; focus on intuitive UX

- **Error Handling:**
    - Basic snackbars + try-catch. (Could improve with custom `Failure` classes)

---

## 📝 Notes for Reviewer
- Limited error handling and UX polish due to time constraints
- Data is seeded manually; in a real app, consider live APIs

---

💼 _Made with Flutter, Supabase & a lot of ☕ by Mukul Gehlot_  
📧 _For questions: your.email@example.com_
