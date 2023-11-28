class Veteriner {
  final String isim;
  final double enlem;
  final double boylam;
  final String mapsUrl;
  final String adres;

  Veteriner(this.isim, this.enlem, this.boylam, this.mapsUrl, this.adres);
}

List<Veteriner> yozgatVeterinerleri = [  
   //08// Artvin Veterinerleri
   Veteriner('Can Veteriner Kliniği', 41.1796532,41.8181286 , 'https://maps.app.goo.gl/zohgv2Y8jiKp2bpw5', 'Artvin/Merkez'),
   Veteriner('BARSVET Veteriner Kliniği', 41.4035982,41.4293396 , 'https://maps.app.goo.gl/3az81y8Q5Y4FUWyPA', 'Artvin/Hopa'),

   //18// Çankırı Veterinerleri
   Veteriner('Vet18 Veteriner Kliniği', 40.5989519,33.6296785 , 'https://maps.app.goo.gl/4Emr55uQYCtADgrv8', 'Çankırı/Merkez'),
   Veteriner('Çankırı Veteriner Kliniği', 40.5991913,33.6250995 , 'https://maps.app.goo.gl/xXwjKabwuRPkkoWs5', 'Çankırı/Merkez'),
   Veteriner('Gönder Veteriner Kliniği', 40.5982239,33.61964 , 'https://maps.app.goo.gl/HTujEeidnmsDUf1G6', 'Çankırı/Merkez'),
   Veteriner('Simus Veteriner Kliniği', 40.6019861,33.6118654 , 'https://maps.app.goo.gl/XKw9VkAgqB7pLRzK7', 'Çankırı/Merkez'),
   Veteriner('Çankırı Hayvan Hastanesi', 40.6010284,33.6312083 , 'https://maps.app.goo.gl/dF6u9m86EKqH9qSr5', 'Çankırı/Merkez'),
   Veteriner('Başar Veteriner Kliniği', 40.5977304,33.6199811 , 'https://maps.app.goo.gl/MqUaUV3UPkjXDrp77', 'Çankırı/Merkez'),

   //29// Gümüşhane Veterinerleri//
   Veteriner('Gümüş Veteriner Kliniği', 40.4590208,39.4823377 , 'https://maps.app.goo.gl/Q1pwb62FLhe5ARsp8', 'Gümüşhane/Merkez'),
   Veteriner('Hannan Veteriner Muayenehanesi', 40.4620344,39.469189 , 'https://maps.app.goo.gl/1W7AbYxGr8DDSbUBA', 'Gümüşhane/Merkez'),
   Veteriner('Merkez Veteriner Kliniği', 40.1283897,39.4354038 , 'https://maps.app.goo.gl/uYbx1hZkwx2LQiJt6', 'Gümüşhane/Kelkit'),  

   //60// Tokat Veterinerleri
   Veteriner('Sever Veteriner Kliniği', 40.3390225,36.5397448, 'https://maps.app.goo.gl/m44rU4VvXRS8g7xj7', 'Tokat/Merkez'),
   Veteriner('Orthopati Veteriner Kliniği', 40.3332272,36.5477237, 'https://maps.app.goo.gl/NHevVrPrqHxeFy6H6', 'Tokat/Merkez'),
   Veteriner('VETALYA Veteriner Kliniği', 40.3296793,36.5504486, 'https://maps.app.goo.gl/UEq21MaaYoroQZwe9', 'Tokat/Merkez'),
   Veteriner('Tokat Uzman Veteriner Kliniği', 40.3315387,36.5547083, 'https://maps.app.goo.gl/tFQw3cBeAHarFuHR7', 'Tokat/Merkez'),
   Veteriner('Anadolu Veteriner Kliniği', 40.3170418,36.5554535, 'https://maps.app.goo.gl/gV228BJ3EgXKHvjKA', 'Tokat/Merkez'),
   Veteriner('Ege Veteriner Kliniği', 40.3172887,36.5539812, 'https://maps.app.goo.gl/4RAuyhdkm4rJcPYM8', 'Tokat/Merkez'),
   Veteriner('Ares Veteriner Kliniği Tokat', 40.3317509,36.5539356, 'https://maps.app.goo.gl/vdHrnQvm6eFoJtra9', 'Tokat/Merkez'),
   Veteriner('TOK-VET Veteriner Sağlık ve Danışmanlık', 40.3469154,36.5440365, 'https://maps.app.goo.gl/fvSg1jY8YjMJjM127', 'Tokat/Merkez'),
   Veteriner('Merkez Veteriner Kliniği', 40.3167457,36.5549887, 'https://maps.app.goo.gl/5Nn6XfQwQ2niQywT9', 'Tokat/Merkez'),
   Veteriner('Tokat Çınar Veteriner Kliniği', 40.3167835,36.5549914, 'https://maps.app.goo.gl/AmugbykQfeJVLcYu8', 'Tokat/Merkez'),
   Veteriner('Hayat Veteriner Kliniği', 40.3188624,36.5541542, 'https://maps.app.goo.gl/kbZx3dCEzidenS3g6', 'Tokat/Merkez'),
   Veteriner('Öz Kardeşler Veteriner Kliniği', 40.3189818,36.5545416, 'https://maps.app.goo.gl/HnEpdRULXR5WF9oLA', 'Tokat/Merkez'),
   Veteriner('Er-vet Veteriner Kliniği', 40.3190943,36.5547074, 'https://maps.app.goo.gl/kXQbK2HQE51YRBwC7', 'Tokat/Merkez'),
   Veteriner('Tokat Tetrapati Veteriner Muayenehanesi', 40.339144,36.5396872, 'https://maps.app.goo.gl/b6gdb71y66esUtX76', 'Tokat/Merkez'),
   Veteriner('Zile Merkez Veteriner Kliniği', 40.3002363,35.8879414, 'https://maps.app.goo.gl/nux9zqkeHmx13B399', 'Tokat/Zile'),  
   Veteriner('Pati Veteriner Muayenehanesi', 40.5881332,36.9507106, 'https://maps.app.goo.gl/MYrXdjUdLCzDe8YZA', 'Tokat/Niksar' ),
   Veteriner('Niksar Veteriner Kliniği', 40.5898559,36.942695, 'https://maps.app.goo.gl/to25moU46vPketuV7', 'Tokat/Niksar'), 
   Veteriner('Yaylacı Pet Veteriner Kliniği', 40.6751709,36.5623334, 'https://maps.app.goo.gl/CobwNoL5qb9ipxig9', 'Tokat/Erbaa'),
   Veteriner('Sedat İçellioglu Veteriner Kliniği', 40.6742729,36.5691855, 'https://maps.app.goo.gl/nsiPeQBvjjvcgGxj9', 'Tokat/Erbaa'), 
   Veteriner('İhya Veteriner Kliniği', 40.3885373,36.0833637, 'https://maps.app.goo.gl/zdpGLWRqYhpJ4Z8k7', 'Tokat/Turhal'), 
 
   //62// Tunceli Veterinerleri//
   Veteriner('Deniz Veteriner Kliniği', 39.0804242,39.5337862 , 'https://maps.app.goo.gl/U6cX5faQzXRee3k97', 'Tunceli/Merkez'),
   Veteriner('Tunceli Veteriner Kliniği',39.1063213,39.5472358 , 'https://maps.app.goo.gl/LShwoPJGfvV1jbfdA', 'Tunceli/Merkez'),
   Veteriner('Güven Veteriner Kliniği', 39.104396,39.5487243, 'https://maps.app.goo.gl/j4aJ9FgifLxSADHv5', 'Tunceli/Merkez'),
   Veteriner('Deylem Veteriner Kliniği', 39.1053245,39.5480248 , 'https://maps.app.goo.gl/f8JiipEoDXqjaC3U9', 'Tunceli/Merkez'),

   //66// Yozgat Veterinerleri//
   Veteriner('ARKAÇ Veteriner Kliniği', 39.8298291,34.8324155, 'https://maps.app.goo.gl/GqH14VHrLTTQ3RBq8', 'Yozgat/Merkez'),
   Veteriner('Yozgat Eker Veteriner Kliniği', 39.8210563,34.8084563, 'https://maps.app.goo.gl/XNJfr1Dqya7BBise6', 'Yozgat/Merkez'),
   Veteriner('Ayyıldız Veteriner Kliniği', 39.8225192,34.8053912, 'https://maps.app.goo.gl/nYRS5NErwMYEAEZm9', 'Yozgat/Merkez'),
   Veteriner('Bozok Yaşam Veteriner Kliniği', 39.824695,34.8078884, 'https://maps.app.goo.gl/sV3CRCVSaW9ws4mG9', 'Yozgat/Merkez'),
   Veteriner('Can Dostu Veteriner Kliniği', 39.8229162,34.8048603 , 'https://maps.app.goo.gl/zV387MCHD7Sf9C4G8', 'Yozgat/Merkez'),
   Veteriner('Kafkas Veteriner Kliniğ', 39.8215159,34.804498, 'https://maps.app.goo.gl/T4YLX8QNXedgBeBT8', 'Yozgat/Merkez'),
   Veteriner('Altuğ Veteriner Kliniği', 39.8089893,35.187768 , 'https://maps.app.goo.gl/wFnt8pUYe484TAV3A', 'Yozgat/Sorgun'), 
   Veteriner('Hekimoğlu Veteriner Kliniği', 39.812272,35.1897387, 'https://maps.app.goo.gl/k2RPZBBwvN5huLiH8', 'Yozgat/Sorgun'), 
   Veteriner('Sağvet Veteriner Kliniği', 39.8083698,35.1866986, 'https://maps.app.goo.gl/u7X1BFk8gVbHfssK9', 'Yozgat/Sorgun'), 
   Veteriner('Çapanoğlu Veteriner Kliniği', 39.8115123,35.1895494 , 'https://maps.app.goo.gl/QYoXhg2szEMvVAHh8', 'Yozgat/Sorgun'), 

   //69// Bayburt Veterinerleri//
   Veteriner('DR. HAW. Hayvan Sağlığı Merkezi', 40.2510308,40.2291543 , 'https://maps.app.goo.gl/6zCkQrRLiBpsTMRh8', 'Bayburt/Merkez'),
   Veteriner('Bayburt Veteriner Kliniği', 40.2585479,40.2256896 , 'https://maps.app.goo.gl/igKBXXgim5WGhE666', 'Bayburt/Merkez'),
   Veteriner('Kardelen Veteriner Kliniği', 40.2605846,40.2255016 , 'https://maps.app.goo.gl/Kjyok67U6XndKXz86', 'Bayburt/Merkez'),
 
   //74// Bartın Veterinerleri//
   Veteriner('Bartın Kocabaş Veteriner Kliniği', 41.6374254,32.3348961 , 'https://maps.app.goo.gl/TTgyqNgKiZr8wYTv5','Bartın/Merkez'),
   Veteriner('EmreM Veteriner Kliniği', 41.6266548,32.3261081 , 'https://maps.app.goo.gl/CSHrxWEUFiFsHA8R8','Bartın/Merkez'),
   Veteriner('Bartın Çağdaş Pet Veteriner Kliniği', 41.635718,32.3400838 , 'https://maps.app.goo.gl/kx5FbwRKmoeWmVG68','Bartın/Merkez'),
   Veteriner('Bartın Anka Veteriner Kliniği', 41.6353584,32.3374746 , 'https://maps.app.goo.gl/7XN2rpDgcKFqSXYu7','Bartın/Merkez'),
   Veteriner('Patim Veteriner Kliniği', 41.6241854,32.3358043 , 'https://maps.app.goo.gl/zSDbmvxXHS5mRsJS9','Bartın/Merkez'),
   Veteriner('Bar-Vet Veteriner Polikliniği', 41.628133,32.3328638 , 'https://maps.app.goo.gl/BSe2eNTSdBCjSf4z7','Bartın/Merkez'),
   Veteriner('BAR-DEM Veteriner Kliniği', 41.6309039,32.3465361 , 'https://maps.app.goo.gl/kaK8SSrDvMRgUysJ6','Bartın/Merkez'),

   //75// Ardahan Veterinerleri//
   Veteriner('Şifa Veteriner Kliniği', 41.1127685,42.6988884 , 'https://maps.app.goo.gl/cj4BHP6m5kJQd72i8', 'Ardahan/Merkez'),
   Veteriner('Durak Veteriner Kliniği', 41.1141599,42.7017309 , 'https://maps.app.goo.gl/vufTsWqNBvaTATt4A', 'Ardahan/Merkez'),
  
   //76// Iğdır Veterinerleri//
   Veteriner('Zozan Veteriner Kliniği', 39.9193651,44.0402963 , 'https://maps.app.goo.gl/4fdqKimKekoiKw1TA', 'Iğdır/Merkez'),
   Veteriner('Par-in Veteriner Kliniği', 39.9188921,44.039783 , 'https://maps.app.goo.gl/K9DpMjx5zY7weJQ78', 'Iğdır/Merkez'),
   Veteriner('Sevilen Veteriner Kliniği', 39.9185908,44.0386523 , 'https://maps.app.goo.gl/fzvhWWbCgMMn7bv5A', 'Iğdır/Merkez'),
   Veteriner('Karaca Veteriner Kliniği', 39.9208991,44.0400881 , 'https://maps.app.goo.gl/opohMV7p8a4XrxSg7', 'Iğdır/Merkez'),
   Veteriner('Zirve Veteriner Kliniği', 39.9196641,44.0464633 , 'https://maps.app.goo.gl/8Kf8gRnTqEv9qoKFA', 'Iğdır/Merkez'),
   Veteriner('Çekim Veteriner Kliniği', 39.9192391,44.0448654 , 'https://maps.app.goo.gl/CiGJwB4vsyVZRdQ68', 'Iğdır/Merkez'),
   Veteriner('Yaşam Veteriner Kliniği', 39.9252059,44.0505601 , 'https://maps.app.goo.gl/DAcdb8zWWYb4u6gSA', 'Iğdır/Merkez'),
   Veteriner('Pati Veteriner Kliniği', 39.9268379,44.0368655 , 'https://maps.app.goo.gl/jr8GSQewSpmGB5up9', 'Iğdır/Merkez'),
   Veteriner('Devam Veteriner Kliniği', 39.9230407,44.0474131 , 'https://maps.app.goo.gl/iGwdDrR6GB1Xryc87', 'Iğdır/Merkez'),
   Veteriner('Opçin Veteriner Kliniği', 39.9207033,44.044539 , 'https://maps.app.goo.gl/m8YnRMM7iGZ6n9Kk9', 'Iğdır/Merkez'),

   //79// Kilis Veterinerleri
   Veteriner('İhsan Veteriner Kliniği', 36.7078783,37.124491 , 'https://maps.app.goo.gl/X5zynBaMFuM3cgJP8', 'Kilis/Merkez'),
   Veteriner('Tunç Veteriner Kliniği', 36.719902,37.1098717 , 'https://maps.app.goo.gl/SSzqjWLxg1TXrPuj7', 'Kilis/Merkez'),
   Veteriner('Şifa Veteriner Kliniği', 36.7214542,37.1079858, 'https://maps.app.goo.gl/5rFfkTgtyfYp7bSy7', 'Kilis/Merkez'),
   Veteriner('Kilis Veteriner Kliniği', 36.7113558,37.1184982 , 'https://maps.app.goo.gl/Qjp8TFFSkAidHfYC9', 'Kilis/Merkez'),

  
];


//  // Boş veteriner listesi  =  Veteriner('', 00.00,00.00 , ''),