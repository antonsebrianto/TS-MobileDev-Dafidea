# test_case_dafidea

## Cara Instalasi
- Jalankan flutter pub get
- Nonaktifkan SystemChrome.setEnabledSystemUIOverlays([]) pada package intro_slider
  ![intro_slider.png](https://drive.google.com/uc?export=view&id=1U2QosJdASdJL3uG3GsyJYX7sSwtbd5D0)
  
## Deskripsi Fitur
### Fitur Splash Page
- Pada Splash Page saya menggunakan package intro_slider dengan menampilkan 3 buah slider.

## Fitur Login
- Pada Fitur Login saya menggunakan Firebase dan terdapat fitur login menggunakan Google dengan mengklik icon google.
- Apabila melakukan login dengan mengisikan email dan password dapat menggunakan akun berikut ini:
  email : 'test@gmail.com' dan password : '1234567'
  Akun tersebut saya buat pada firebase.
- Validasi email dengan format @gmail.com dan email harus minimal 6 karakter

## Fitur GetPost Pada Halaman Homepage
- Pada halaman homepage saya melakukan fetchAPI getPost sesuai dengan API dari gorest.co.in
- Disini saya juga memberikan pagination dari getPost, apabila dilakukan scroll maka data post akan otomatis bertambah
- Apabila salah satu post di klik maka akan berpindah halaman ke halaman detail post, yang dimana menampilkan data dari post yang sebelumnya di klik secara lebih rinci


