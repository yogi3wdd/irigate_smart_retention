# IriGate Smart Retention

Aplikasi ini digunakan untuk **monitoring kolam retensi** dan **mengontrol gate (pintu air)** yang berfungsi sebagai sistem irigasi.  
Tujuan utama aplikasi ini adalah membantu pengelolaan air secara lebih efisien melalui pemantauan kondisi kolam secara real-time dan pengoperasian gate secara manual maupun otomatis.

Aplikasi dibangun dengan Flutter dan menggunakan **Liquid Glass UI Effect** untuk tampilan yang modern, interaktif, dan elegan.

Aplikasi mendukung platform:

- **Android**

File instalasi aplikasi tersedia pada halaman **Release** repository ini.

---

## 🔧 Fitur-Fitur Aplikasi

- **📊 Monitoring Water Level**  
  Menampilkan ketinggian air kolam retensi secara real-time dari sensor IoT.

- **🚪 Kontrol Gate (Pintu Air)**  
  Mengontrol buka/tutup gate secara langsung melalui aplikasi.

- **🔔 Notifikasi (Alert System)**  
  Mendapatkan pemberitahuan ketika:
  - Air mencapai batas atau kondisi tertentu  
  - Gate terbuka/tertutup  
  - Overflow / kondisi darurat    

- **📈 Riwayat Data (Log History)**  
  Menyimpan riwayat status level air kolam retensi dan sungai dalam bentuk bar chart.

- **🎨 Liquid Glass UI Effect**  
  Antarmuka menggunakan efek Liquid Glass yang memberikan visual lembut, modern, dan interaktif.

---

## 📦 APK Release Files

Berikut adalah APK hasil build Flutter untuk berbagai arsitektur CPU Android:

- **`app-armeabi-v7a-release.apk`**  
  Untuk perangkat Android dengan CPU **ARM 32-bit (ARMv7)**.  
  Cocok untuk HP lama.

- **`app-arm64-v8a-release.apk`**  
  Untuk perangkat Android dengan CPU **ARM 64-bit (ARMv8)**.  
  Digunakan oleh sebagian besar HP Android modern.

- **`app-x86_64-release.apk`**  
  Untuk perangkat dengan CPU **x86_64 (Intel/AMD)**.  
  Biasanya untuk **emulator** atau perangkat khusus.