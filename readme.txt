Go-Eat

Deskripsi soal : https://docs.google.com/document/d/1C5EUZJjNoWGRfgnFb1zD78eWQciSqRs-woFG1vYNT04/edit

Deskripsi Desain 

berikut adalah kelas kelas yang digunakan pada program ini 

----------------------------
Map
----------------------------
@height
@width
@taken_coordinate 
@blocked_coordinate
@map_image

:initialize
:in_area?
:generate_new_coordinate
:add_to_taken_coordinate
:remove_to_taken_coordinate
:add_to_map_image
:remove_from_map_image
:number_of_untaken_coordinate
:add_to_blocked_coordinate
----------------------------
Kelas Map ini nantinya adalah instansi peta yang digunakan pada sepanjang program dijalankan. - - - atribut height : akan menjadi tinggi dari peta 
- atribut width : akan menjadi lebar dari peta 
Pada soal , case nya peta akan berbentuk square dimana lebar dan tinggi akan memiliki nilai yang sama, Alasan membuat height dan width adalah karena pada dasarnya peta yang dibuat adalah 2D dimana memiliki lebar dan tinggi. Juga ketika case tidak lagi menyamakan tinggi dan dan lebar , kita tidak perlu repot mengubah keseluruhan method yang terkait dengan ini.
- taken_coordinate : akan menyimpan titik kordinat yang sudah digunakan user , driver maupun store
- blocked_coordinate : akan menyimpan titik yang digunakan store.
alasan adanya atribut ini karena asumsi bahwa driver dapat melewati (melalui) titik kosong ,user maupun driver lain. sehingga titik yang digunakan store akan ditambahkan pada blocked_coordinate dan berguna untuk pencarian rute nantinya. sedangkan taken coordinate menyimpan semua titik yang ditempati user ,driver , maupun store , karena asumsi tidak ada 2 objek yang berada pada satu titik
- map_image  : akan menyimpan gambar representasi dari peta , yaitu menyimpan "." ketika tidak ada objek yang menempati koordinat tersebut. menyimpan "d" ketika driver menempati titik tersebut , menyimpan "u" untuk user dan "s" untuk store.
Method :
:initialize : untuk pembuatan instansi peta sesuai parameter size
:in_area?	: mengecek suatu koordinat apakah termasuk dalam lingkup peta (true/false)
:generate_new_coordinate : menghasilkan koordinat baru yang belum diambil objek apapun
:add_to_taken_coordinate : menambahkan suatu koordinat ke atribut taken_coordinate
:remove_to_taken_coordinate : menghilangkan suatu koordinat dari atribut taken_coordinate
:add_to_map_image : menambahkan suatu objek ke atribut map_image sesuai cara representasinya
:remove_from_map_image : mengurangi suatu objek ke atribut map_image sesuai cara representasinya
:number_of_untaken_coordinate : menghitung jumlah koordinat yang belum ditempati , membantu pada  saat pembuatan driver yang random , agar tidak infinity loop ,  karna pada saat pembuatan driver random , akan dicek apakah bisa  ke semua store dan ketika titik yang dicoba tidak bisa membuat  driver menjalani semua store maka akan dicoba koordinat baru dan  koordinat yang dicoba akan dicatatat agar tidak dicoba lagi dan  ketika koordinat yang dicoba sudah habis maka program akan  menampilkan bahwa tidak dapat membuat driver dan exit dengan status 1 
:add_to_blocked_coordinate : menambahkan suatu koordinat ke atribut blocked_coordinate


----------------------------
Order
----------------------------
@total_price
@store
@driver
@items
@amounts
@route
@distance
@unit_cost
@fee
@total_price

:initialize
:add_item
:add_route
:select_driver
:set_unit_cost
:calculate_fee
:calculate_total
----------------------------

kelas Order ini nantinya akan menjadi instansi yang menyimpan informasi sebuah order dari 

@total_price : menyimpan total harga order yang sudah ditambahkan fee driver
@store : menyimpan instansi store yang terlibat dalam order
@driver : menyimpan driver store yang terlibat dalam order
@items : menyimpan instansi item yang terlibat dalam order , dalam array 
@amounts : menyimpan jumlah item yang terlibat dalam order , dalam array dan index yang sama  dengan @items , misal item "a" berada pada items[0] , jumlahnya juga pada amounts[0]
@route : menyimpan rute dari tempat driver semua -> store -> tempat user  
@distance : menyimpan jarak yang ditempuh driver sesuai rute  
@unit_cost : menyimpan ketentuan unit_cost
@fee	: menyimpan fee driver , tidak terlalu penting untuk case pada soal , tapi penting ketika  ada tambahan case pengurangan/diskon fee driver 
@total_price : menyimpan total harga semua item yang dibeli dan fee driver

:initialize	: membuat instansi order baru , dengan menetapkan store dahulu
:add_item	: menambah item yang dibeli dan jumlahnya 
:add_route	: menambah/menyimpan rute yang di dapat dengan bantuan class Router nantinya
:select_driver	: menambah driver yang menangani order
:set_unit_cost	: men set unit_cost untuk sebuah order 
:calculate_fee	: menghitung fee driver (unit cost * distance)
:calculate_total: menghitung total harga semua (fee + semua harga barang )



seperti kita ketahui bahwa store ,driver ,user akan ditempatkan maka kita membuat 1 kelas untuk di implementasi nantinya oleh kelas kelas (objek - objek ) yang bisa dialokasikan , seperti store , driver dan user 


----------------------------
Placeable
----------------------------
@x
@y
@coordinate

:initialize
:locate
:coordinate
----------------------------

@x : menyimpan titik x dimana ini ketinggian dan (ketetapan yg saya buat dari atas kebawah)
@y : menyimpan titik y dimana ini lebar dan (ketetapan yg saya buat dari kiri ke kanan)
@coordinate : menyimpan sebuah array yang menyimpan x,y => misal [2,3] , dengan ini lebih mudah
 dengan adanya ini , x dan y tidak terlalu penting tapi kembali lagi diperlukan  karena ketika case bertambah 

:initialize	: membuat instansi
:locate		: mengalokasikan ke koordinat 
:coordinate	: mengembalikan koordinat 



dan sebuah kelas yang lebih advance yang mewarisi kelas Placeable, nantinya ini akan mempermudah dalam proses menentukan rute perjalanan dari satu koordinat ke koordinat lain , juga di kelas ini dapat kita tentukan pergerakan dari suatu koordinat yang boleh di lakukan, maka hanya ada up left right dan down , juga menyimpan instansi map yang yang digunakan


----------------------------
CoordinateInterface < Placeable
----------------------------
@map
@coordinate

:initialize
:up
:have_up?
:down
:have_down?
:left
:have_left?
:right
:have_right?
----------------------------

@map	: menyimpan map yang digunakan / di eksplorasi
@coordinate	: menyimpan koordinat 

:initialize : membuat instansi
:up		: mengembalikan koordinat atas dari suatu koordinat
:have_up?	: mengecek apakah suatu koordinat memiliki koordinat atas
:down		: mengembalikan koordinat bawah dari suatu koordinat
:have_down?	: mengecek apakah suatu koordinat memiliki koordinat bawah
:left		: mengembalikan koordinat kiri dari suatu koordinat
:have_left?	: mengecek apakah suatu koordinat memiliki koordinat kiri
:right		: mengembalikan koordinat kanan dari suatu koordinat
:have_right?	: mengecek apakah suatu koordinat memiliki koordinat kanan


kemudian ketiga kelas yang memiliki koordinat dan bisa dialokasikan yaitu driver , user dan store yang menwarisi kelas placeable tadi , mengapa harus mewarisi placeable ? karena ketika bagaimana objek objek ini dialokasikan berubah (dari yang 2 dimensi jadi 3 dimensi misalnya) maka kita hanya perlu mengganti kode pada bagian placeable  , tak perlu mengubah ketiga kelas (user , driver dan store)ini


----------------------------
Driver < Placeable
----------------------------
@name	: 
@rating 

:initialize
:rate
:rating_counter
----------------------------

@name	: menyimpan nama driver
@rating : menyimpan rating dari driver 

:initialize : membuat instansi driver , sesuai nama dan membuat default rating = 0.0 ketika driver  baru
:rate 	: melakukan rate pada driver , yaitu menambah suatu rating baru ke array koleksi semua  rating , dan sekaligus memanggil method rating_counter untuk memperbarui rating driver  dengan cara menghitung rata rata semua rating pada array koleksi semua rating
:rating_counter : menghitung rating (rata rata semua rating yang ditambahkan ke driver)

----------------------------
User < Placeable
----------------------------
@name

:initialize
----------------------------

@name : menyimpan name user , tidak diperlukan pada case di soal tapi saya tambahkan saja supaya  user memiliki nama (nanti saya asumsikan di set default oleh program)


----------------------------
Store < Placeable
----------------------------
@name
@items

:initialize
:add_item
:select_item_by_id
----------------------------

@name : menyimpan nama toko
@items	: menyimpan semua item yang tersedia di toko dalam bentuk array/koleksi

:initialize	: menciptakan instansi baru toko dengan ketentuan nama yg diberikan pada toko
:add_item	: menambahkan suatu item yang tersedia pada toko pada koleksi items
:select_item_by_id	: mengambil item berdasarkan id yang sebenarnya adalah index+1 , nantinya pada proses order , item akan ditampilkan dengan id yang terurut dari 1 sampai n (jumlah item) , saya buat select by id daripada select by index  karna untuk lebih mudah dipahami apalagi untuk yang tidak familiar dengan  index dari 0




kemudian kita butuh kelas Item juga

----------------------------
Item
----------------------------
@name
@price

:initialize
----------------------------

@name : menyimpan info nama dari item 
@price : menyimpan info harga dari item

:initialize : membuat instansi item baru dengan nama dan harga yang di set pada saat instansiasi



kita juga butuh kelas Router untuk mengarahkan/mencari rute jalan dari satu koordinat ke yang satu 

----------------------------
Router
----------------------------
@start_position
@end_position
@current_position
@paths
@distances

:initialize
:find_path
:has_path?

private
:has_possible_step?
:possible_step
:best_step
----------------------------

disinilah kegunaan kelas CoordinateInterface dalam mempermudah pencarian rute , yang mendefenisikan langkah yang dapat diambil sesuai ketetapan di soal yaitu atas bawah kiri dan kanan, tidak perlu banyak penambahan kode pada kelas Router karena sudah ada CoordinateInterface, juga kalau ketentuan berubah hanya perlu menambahkan pada CoordinateInterface  dan menyelaraskan nya sedikir

@start_position : menyimpan suatu instansi CoordinateInterface dengan koordinat awal
@end_position	: menyimpan suatu instansi CoordinateInterface dengan koordinat akhir
@current_position : menyimpan suatu instansi CoordinateInterface dengan koordinat yang akan 			dipindah pindahkan / bergerak menelusuri
@paths		: menyimpan jalan dari awal ke akhir dalam bentuk array/koleksi koordinat
@distances	: menyimpan jarak dari titik awal ke titik akhir

@last_visited 	: atribut tanpa reader untuk membantu mundur ketika menemukan jalan buntu pada 			saat pencarian rute, karna menyimpan langkah terakhir yang diambil
@visited	: atribut tanpa reader untuk membantu pencarian rute , karena menyimpan titik yang 			sudah pernah dijalani , tak perlu dijalani lagi , bukan berarti tidak bisa mundur 			karena titik mundur di simpan pada atribut last_visited.

:initialize	: menginstansiasi instansi yaitu menetapkan titik awal dan akhir dan titik current
:find_path	: mencari jalan pertama yang terdekat , tidak terlalu sempurna pada case rumit 			seperti store dibariskan menghalangi jalan terdekat ( case langka) . tapi lebih 		baik dan lebih cepat daripada mencari semua rute yang mungkin dan mensort 			paling 	pendek ketika memilih rute.
:has_path?	: mengecek apakah ada rute yang bisa dilalui dari titik awal ke titik akhir

private
:has_possible_step?	: mengecek apakah ada langkah yang bisa di ambil dari langkah current
:possible_step		: mengembalikan langkah yang bisa diambil dalam bentuk array/koleksi
:best_step		: memilih langkah paling dekat dengan tujuan

ketiga method ini private karena tidak perlu diketahui oleh kelas luar dan digunakan hanya di kelas ini 

kemudian kita memerlukan banyak module untuk membantu program dalam mengolah semua case dan jalannya program
module module tersebut yaitu :

module OutputController yang menangani proses penampilan semua menu di layar
----------------------------
OutputController
----------------------------
:show_main_menu		: menampilkan main menu
:show_driver_information : menampilkan informasi semua driver
:show_store_information : menampilkan informasi semua toko
:show_item_store_information : menampilkan informasi semua item yang ada pada suatu toko
:show_map_information : menampilkan informasi map , representasi image_map 
:show_order_information : menampilkan informasi sebuat order , dengan format output tertentu
:print_to_file	: mencetak ke dalam file , disini casenya mencetak hasil order ke file
:clear_screen : membersihkan layar
:delay_output : melakukan delay output agar seperti real (hanya tambahan)
:show_order_history : menampilkan history order pada layar , (saya asumsikan diambil dari file order log) jadi pada saat aplikasi dibuka kalau order log pernah diisi pasti history order dapat selalu di tampilkan

----------------------------

module NameGenerator untuk membuat nama random sesuai dengan koleksi yang tersedia
----------------------------
NameGenerator
----------------------------
Name = [] : menyimpan koleksi nama yang tersedia

NameGenerator::generate  : untuk menghasilkan nama acak dari koleksi nama 
----------------------------

module NameController untuk menghandle penggunaan nama , agar tidak ada nama yang sama yang di generate 
----------------------------
NameGenerator
----------------------------
:is_name_used? : pengecekan apakah nama sudah ada dalam koleksi nama yang sudah digunakan
:unuse_name : menghapus nama dari koleksi nama yang sudah digunakan
:use_name : menambahkan nama ke dalam koleksi nama yang sudah digunakan
:generate_unused_name : men-generate nama yang belum digunakan , nama acak dari module NameGenerator::generate akan dipastikan belum digunakan sebelum di generate 
----------------------------





module InputController yang mengontrol semua input user 
----------------------------
InputController
----------------------------
:get_user_input	: menerima inputan sesuai dengan range yang ditentukan
:press_enter_to_continue : menerima inputan apapun dan membersihkan layar dengan OutputController:clear_screen

----------------------------

module MapController yang mengontrol create_map
----------------------------
MapController
----------------------------
create_map : membuat map sesuai size , default yaitu 20
----------------------------

module DriverController yang mengontrol semua peran driver di main kelas
----------------------------
DriverController
----------------------------
:delete_driver : menghapus driver dari atribut main kelas @drivers dan dari @map 
:driver_evaluator : mengevaluasi driver pada ketika order selesai , yaitu ketika kriteria rating tidak terpenuhi maka dihapus dan diganti dengan yang random baru
:create_random_driver : membuat driver random dengan banyak yang ditentukan
:create_driver : membuat driver spesifik dengan nama dan koordinat letaknya , tapi tetap mengecek apakah koordinat boleh dan bisa untuk driver menjalani semua store
:generate_new_driver : membuat sebuah driver baru , membantu methode create_random_driver , method inila yang sebenarnya melakukan pembuatan driver acak dan memenuhi persyaratan koordinat , create_random_driver hanya mengulangi methode ini 
----------------------------

module UserController mengontrol peletakan user dan disini di set default nama untuk user untuk sepanjang program
----------------------------
UserController
----------------------------
set_user : menempatkan dan menamakan serta membuat instansi user untuk main kelas
----------------------------



module StoreController untuk mengelola pembuatan toko untuk main kelas
----------------------------
StoreController
----------------------------
:create_default_store : pembuatan toko default yaitu 3 toko dan item default dari attribut @default_items di main kelas ditambahkan ke semua toko
:create_store : pembuatan toko spesifik dengan nama ,item(s) , dan lokasi (default di buat acak)

----------------------------


module ItemController yang mengelola semua pembuatan item pada/untuk main kelas
----------------------------
ItemController
----------------------------
set_default_item : untuk pembuatan item default , dengan bantuan create_item
create_item	: membuat item spesific dengan nama dan harga yang ditentukan
----------------------------



module OrderController yang mengelola semua pembuatan order , pemprosesan order , pengalokasian driver ke order 
----------------------------
OrderController
----------------------------
:create_order_handler : melakukan proses pembuatan order baru dari mulai store hingga semua item yang dibeli
:set_order_driver_handler : menangani pemilihan driver pada order setelah order berhasil di create
:process_order	: menangani proses order ketika sebuah order sudah berhasil di create dan ketika driver dan order sudah complete dibuat , juga mencetak proses perjalanan driver 

----------------------------

module MainHandler
----------------------------
MainHandler
----------------------------
:print_usage : menampilkan penggunaan program ketika argumen tidak sesuai , digunakan di method start_program_handler
:start_program_handler : menangani proses awal program dijalankan , pengecekan argumen dan pemilihan case sesuai jumlah argumen
:main_menu_handler : menangani main menu dan alur program sesuai input yang dimasukan user, misalkan ketika 1 yakni proses menampilkan informasi map , 2 untuk proses order 
:normal_exit_program : melakukan exit dengan exit status code = 0 
:error_exit_program : melakukan exit dengan exit status code = 1
:map_size_checker : melakukan pengecekan map , ketika size map yang di input pada argumen atau file terlalu kecil , tidak valid (0 dan 1 ) atau terlalu besar . saya mengasumsikan dan menetapkan map pada program ini maksimal 50x50
:default_case : proses create semua instansi driver dan store serta user sesuai dengan default case (program dijalankan tanpa argument)
:with_argument_case :proses create semua instansi driver dan store serta user sesuai dengan Argument (program dijalankan dengan 3 argument)
:with_filename_case : proses create semua instansi driver dan store serta user sesuai dengan konfigurasi pada file (program dijalankan dengan 1 argumen yaitu nama file) , saya menggunakan format JSON untuk mempermudah antara program dan user dalam membuat dan menerjemahkan konfigurasi.

----------------------------




Atribut pada Main kelas

@default_number_of_driver : menyimpan banyak driver untuk case default , mengubah ini akan mengubah jumlah driver yang di generate ketika default case (program dijalankan tanpa argumen)
@default_number_of_store : menyimpan banyak store untuk case default , mengubah ini tidak akan mengubah jumlah store yang di generate ketika default case (program dijalankan tanpa argumen) karena pada soal , sudah ditetapkan 3 store default untuk sepanjang program berjalan, ini hanya menyimpan informasi saja
@used_name : menyimpan nama nama driver yang sudah digunakan dalam bentuk koleksi
@map : instansi map sepanjang jalannya program
@drivers : menyimpan instansi semua driver yang tersedia dalam bentuk koleksi
@user : instansi user 
@default_items : menyimpan semua instansi item default (yang di set untuk default case ) dalam bentuk koleksi
@stores : menyimpan semua instansi store yang tersedia dalam bentuk koleksi
@user_input : sebagai penampung yang menyimpan input user 
@order : menyimpan instansi order pada saat pembuatan order hingga proses order  selesai
@order_history_filename : menyimpan informasi nama file yang digunakan untuk menyimpan history order , juga sebagai tempat dimana order dicetak ke file sesuai di soal + asumsi tambahan. ini lebih baik daripada menyimpan instansi order pada koleksi karena pada saat program dibuka kembali history akan ulang dari nol.



Semua Asumsi tambahan :
- File konfigurasi input menggunakan format json , ada example ketentuan yang digunakan
- File konfigurasi input di asumsikan sesuai dengan format yang ditentukan , tak ada penambahan pengecekan pada file json sebelum di proses

- OrderHistory diambil dari file Order_log (nama file ditentukan pada program) , maka semua orderHistory dapat ditampilkan sepanjang order pernah dibuat bukan sepanjang program berjalan saja
- File hasil output order menggunakan format yang sama dengan cara menampilkan order di layar setelah order selesai, gunanya agar tampilan pada order history akan sama dengan tampilan order pada saat order selesai dibuat.


- untuk default case , sesuai ketentuan soal , store dan driver dahulu diproses baru kemudian user, 
- untuk case dengan 3 argumen , user di proses duluan sebelum store dan driver , karena store dan driver akan diletakan random , dan tidak bisa ditebak , kalau driver dan store sebelum user , maka akan ada case koordinat user yang diberikan pada argument ditolak. dan akan lebih baik user yang koordinatnya sudah jelas duluan di proses
- untuk case dengan 1 argumen filename , sesuai dengan ketentuan soal , store dan driver dahulu di proses kemudian user. ukuran map , lokasi duplikat dan lokasi driver yang tidak bisa menjelajahi semua store akan ditolak

- driver dapat melewati titik user dan driver , tapi tidak boleh melewati titik store.
- menu cancel ditambahkan pada saat proses order 
- pengecekan input user dibuat 





