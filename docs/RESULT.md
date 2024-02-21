# Приложение для генерации мемов MEMGEN
## Описание
MemGen - это конструктор для генерации демотивирующих картинок. Приложение состоит из одного экрана, на котором отображается картинка и текст мема.
## Целевая платформа
Платформа: Android 12.

## Результаты
### Функционал приложения
Функционал приложения соответствует требованиям, выдвинутым к среднему уровню:

✅ возможность ввести текст (TextField),

✅ возможность выбрать картинку из интернета по ссылке (cached_network_image),

✅ возможность выбрать картинку из галереи (image_picker),

✅ возможность делиться ссылкой на картинку полученного демотиватора:

>🟢ссылка действительна только для изображений, загруженных из интернета (share_plus),
  
>🟡если изображение выбрано из галереи, передается путь к изображению в памяти телефона,
  
>🟡передается ссылка исключительно на изображение, без включения текста.

✨ изменение размера выделенной области для текста при необходимости (LayoutBuilder),

✨ возможность просмотра информации о приложении (AlertDialog),

✨ иконка приложения (android:icon).
 
### Способ взаимодействия с текстом

✏️ Взаимодействие с текстом происходит путём нажатия на него или на соответсвующую кнопку в меню приложения (GestureDetector).

### Способ взаимодействия с изображением

🖼️ Взаимодействие с изображением происходит аналогично подобным действиям с текстом.

### Бонусные опции

🔥 Адаптив под альбомную ориентацию - приложение корректно запускается и отображается в альбомной ориентации (Expanded).

## Демонстрация работы

**Видео с озвучкой**

https://github.com/Kateriina/surf-flutter-study-jam-5/assets/47224878/0d8e492d-25d2-4675-8a8a-bc444c76ff6d

![**Скачать APK**](https://github.com/Kateriina/surf-flutter-study-jam-5/blob/main/docs/results/memgen.apk)

**Скриншоты**
<div class="row" align="center">
  <img src="images/img_1_main_screen.jpg" width="375" alt="Главный экран" style="margin-right: 30px;" />
  <img src="images/img_2_info_screen.jpg" width="375" alt="О приложении" style="margin-right: 30px;" />
</div>
<div class="row" align="center">
  <img src="images/img_3_edit_text_screen.jpg" width="375" alt="Изменение текста" style="margin-right: 30px;" />
  <img src="images/img_4_edit_img_screen.jpg" width="375" alt="Изменение картинки" style="margin-right: 30px;" />
</div>
<div class="row" align="center">
  <img src="images/img_5_share_img_screen.jpg" width="375" alt="Поделиться изображением" style="margin-right: 30px;" />
  <img src="images/img_6_big_text_screen.jpg" width="375" alt="Изменение размера области текста" style="margin-right: 30px;" />
</div>
<div class="row" align="center">
  <img src="images/img_7_albom_screen.jpg" width="375" alt="Альбомная ориентация" style="margin-right: 30px;" />
</div>


