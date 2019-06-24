Go-Eat

Deskripsi soal : https://docs.google.com/document/d/1C5EUZJjNoWGRfgnFb1zD78eWQciSqRs-woFG1vYNT04/edit

Deskripsi Desain 

untuk kelas, sesuai dengan permasalahan pada soal , pertama sekali kelas dasar yang kita perlukan yaitu : 
----------------------------
Map
----------------------------
@lenght
@width
@taken_coordinate 

:initialize
:in_area?
:generate_new_coordinate
:add_to_taken_coordinate

----------------------------

----------------------------
Order
----------------------------
@item
@total_price

:add_item
:calculate_fee
----------------------------

seperti kita ketahui bahwa store ,driver ,user akan ditempatkan maka kita membuat 1 kelas untuk di implementasi nantinya oleh kelas kelas yang bisa dialokasikan 


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

dan sebuah kelas yang lebih advance yang mewarisi kelas Placeable, nantinya ini akan mempermudah dalam proses menentukan rute perjalanan dari satu koordinat ke koordinat lain , juga di kelas ini dapat kita tentukan pergerakan dari suatu koordinat yang boleh di lakukan, maka hanya ada up left right dan down


----------------------------
CoordinateInterface < Placeable
----------------------------
@map

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




----------------------------
Driver < Placeable
----------------------------
@name
@rating 

:initialize
:rate
:rating_counter
----------------------------

----------------------------
User < Placeable
----------------------------
@name

:initialize
----------------------------


----------------------------
Store < Placeable
----------------------------
@name
@item

:initialize
:add_item
----------------------------


kemudian kita butuh kelas Item juga

----------------------------
Item
----------------------------
@name
@price

:initialize
----------------------------

kita juga butuh kelas Router untuk mengarahkan jalan dari satu koordinat ke yang satu 

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

private
:has_possible_step?
:possible_step
----------------------------

kemudian kelas untuk mengatur output in case order yang di simpan ke dalam file 

----------------------------
OutputController
----------------------------

----------------------------
kemudian kelas untuk input in case data map ,driver ,store,user di input melalui file


----------------------------
InputController
----------------------------

----------------------------
