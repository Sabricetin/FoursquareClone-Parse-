# FoursquareClone Uygulaması

Bu Swift kodları, FoursquareClone uygulamasının çeşitli bölümlerini oluşturan bileşenlerdir. Uygulama, kullanıcıların yer eklemelerini, harita üzerinde yer işaretlemelerini ve bu bilgileri Parse veritabanına kaydetmelerini sağlar. Her bir kod bloğu, belirli bir işlevi yerine getirir ve birlikte çalışarak tam bir yer keşfetme uygulaması oluşturur.

## 1. Giriş ve Kayıt Ekranı (SignUpVC.swift)

Bu kod, kullanıcıların Parse kullanarak giriş yapmalarını ve yeni hesap oluşturmalarını sağlar.

### Özellikler

- **Arayüz Elemanları:**
  - `usernameText`: Kullanıcının kullanıcı adını girdiği metin alanı.
  - `passwordText`: Kullanıcının şifresini girdiği metin alanı.

### Kullanıcı Girişi

- `signİnClicked`: Kullanıcı giriş yapmak için bu butona tıkladığında, Parse Authentication ile giriş yapılır. Hata durumunda uyarı gösterilir.

### Yeni Hesap Oluşturma

- `signUpClicked`: Kullanıcı yeni hesap oluşturmak için bu butona tıkladığında, Parse Authentication kullanılarak hesap oluşturulur. Hata durumunda uyarı gösterilir.

### Uyarı Mesajları

- `makeAlert`: Hata veya bilgi mesajları göstermek için kullanılır.

## 2. Detay Ekranı (detailsVC.swift)

Bu kod, kullanıcının seçtiği yerin detaylarını görüntüler ve harita üzerinde yer işaretlemesi yapar.

### Özellikler

- **Arayüz Elemanları:**
  - `detailsImageView`: Yer resmini gösterir.
  - `detailsNameLabel`: Yer adını gösterir.
  - `detailsTypeLabel`: Yer türünü gösterir.
  - `detailsAtmosphereLabel`: Yer atmosferini gösterir.
  - `detailsMapView`: Harita görünümünü gösterir.

### Parse'dan Veri Çekme

- `getDataFromParse`: Parse veritabanından seçilen yerin detaylarını çeker ve ilgili arayüz elemanlarına atar.

### Harita İşlevleri

- `mapView(_:viewFor:)`: Harita üzerinde yer işaretlemesi (annotation) yapar.
- `mapView(_:annotationView:calloutAccessoryControlTapped:)`: Harita üzerindeki işaretlemeye tıklanıldığında, seçilen yerin konumunu haritada açar.

## 3. Harita Ekranı (mapVC.swift)

Bu kod, kullanıcıların harita üzerinde yer işaretlemelerini ve bu bilgileri Parse veritabanına kaydetmelerini sağlar.

### Özellikler

- **Arayüz Elemanları:**
  - `mapView`: Harita görünümünü gösterir.

### Kullanıcı Konumunu Alma ve İşaretleme

- `viewDidLoad`: Kullanıcının konumunu almak için gerekli ayarları yapar.
- `chooseLocation(gesturRecognizer:)`: Uzun basma hareketiyle harita üzerinde yer işaretlemesi yapar.
- `locationManager(_:didUpdateLocations:)`: Kullanıcının konumunu günceller ve harita üzerinde gösterir.

### Veriyi Parse'a Kaydetme

- `saveButtonClicked`: Harita üzerinde işaretlenen yer bilgilerini Parse veritabanına kaydeder.
- `backButtonClicked`: Geri butonuna basıldığında önceki ekrana döner.

## 4. Yer Ekleme Ekranı (AddPlacesVC.swift)

Bu kod, kullanıcıların yeni yer eklemelerini ve bu yerlerin bilgilerini girmelerini sağlar.

### Özellikler

- **Arayüz Elemanları:**
  - `placeNameText`: Yer adını girdiği metin alanı.
  - `placeTypeText`: Yer türünü girdiği metin alanı.
  - `placeAtmospherText`: Yer atmosferini girdiği metin alanı.
  - `placeİmageView`: Yer resmini gösterir ve kullanıcıya fotoğraf seçme imkanı sunar.

### Fotoğraf Seçme

- `pickImage`: Kullanıcıya fotoğraf seçme imkanı sunar.
- `picker(_:didFinishPicking:)`: Seçilen fotoğrafı `placeİmageView`'a atar.

### Yer Bilgilerini Kaydetme

- `nextButtonClicked`: Yer bilgilerini kaydeder ve harita ekranına yönlendirir.

## 5. Yerler Ekranı (PlacesVC.swift)

Bu kod, kullanıcıların eklediği yerlerin listesini gösterir ve seçilen yerin detaylarına gitmeyi sağlar.

### Özellikler

- **Arayüz Elemanları:**
  - `tableView`: Yerlerin listesini gösterir.

### Parse'dan Veri Çekme ve Tabloya Aktarma

- `getDataFromParse`: Parse veritabanından yer bilgilerini çeker ve tabloyu günceller.
- `tableView(_:cellForRowAt:)`: Her bir hücreyi yer bilgileriyle doldurur.
- `tableView(_:numberOfRowsInSection:)`: Tablo satır sayısını döner.

### Yer Seçme ve Detaylarına Gitme

- `tableView(_:didSelectRowAt:)`: Bir yer seçildiğinde, detay ekranına yönlendirir.
- `prepare(for:sender:)`: Geçiş sırasında seçilen yerin ID'sini detay ekranına aktarır.

### Navigasyon ve Çıkış İşlevleri

- `addButtonClicked`: Yeni yer ekleme ekranına geçiş yapar.
- `logoutButtonClicked`: Kullanıcı çıkış yapar ve giriş ekranına döner.

### Uyarı Mesajları

- `makeAlert`: Hata veya bilgi mesajları göstermek için kullanılır.

  
- ![FoursquareClone](https://github.com/user-attachments/assets/f73fd0f6-7723-40a6-af46-f2d2dfd11874)


