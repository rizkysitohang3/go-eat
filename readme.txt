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

seperti kita ketahui bahwa store ,driver ,user akan ditempatkan maka kita membuat 1 kelas untuk di implementasi nantinya oleh kelas kelas yang bisa dialokasikan 


----------------------------
Placeable
----------------------------
@x
@y

:initialize
:locate
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


kemudian kita butuk kelas Item juga

----------------------------
Item
----------------------------
@name
@price

:initialize
----------------------------

kita juga butuh kelas Router untuk mengarahkan jalan dari satu koordinat ke yang satu 
