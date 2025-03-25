//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2025 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

// Обработка реализована на основании разработки https://infostart.ru/1c/tools/1691321/ by ZhokhovM
// Позволяет распаковывать, модифицировать и запаковывать внутренние файлы обработки  
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

//@skip-check object-module-export-variable
// Хранит информацию о файлах обработки
Перем ФайлыОбработки Экспорт;

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Загрузить шаблон.
// 	Загружает обработку, для дальнейшей работы с ней
// Параметры:
//  ДанныеШаблона - Неопределено - Используется шаблон обработки по умолчанию (см: макеты. ШаблонОбработки)
//                - ДвоичныеДанные - Данные редактируемой обработки
Процедура ЗагрузитьШаблон(Знач ДанныеШаблона = Неопределено) Экспорт
	
	Если ДанныеШаблона = Неопределено Тогда
		ДанныеШаблона = ПолучитьМакет("ШаблонОбработки");
	КонецЕсли;
	
	Поток = ДанныеШаблона.ОткрытьПотокДляЧтения();
	ПараметрыЗаписи = ПараметрыЗаписи();
	Попытка
		ФайлыОбработки = ПрочитатьКонтейнер(Поток, ПараметрыЗаписи, Истина);
		Поток.Закрыть();
	Исключение
		Поток.Закрыть();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

// Возвращает список файлов загруженной обработки
// 
// Возвращаемое значение:
//  Массив из см. ЗаписьОглавления - Файлы обработки
Функция ФайлыОбработки() Экспорт
	
	Возврат ФайлыОбработки;
	
КонецФункции

// Устанавливает данные внутреннего файла обработки.
// 
// Параметры:
//  ПолноеИмяФайла - Строка - Полное имя файла, разделитель пути - `/`
//  Текст - Строка - Новый текст файла
Процедура УстановитьДанныеФайла(ПолноеИмяФайла, Текст) Экспорт
	
	Файл = НайтиФайл(ПолноеИмяФайла);
	Если Файл.ЭтоКонтейнер Тогда
		ВызватьИсключение СтрШаблон("%1 это контейнер, а должен быть обычный файл", ПолноеИмяФайла);
	КонецЕсли;
	
	Файл.Данные = ПолучитьДвоичныеДанныеИзСтроки(Текст, КодировкаТекста.UTF8, Ложь);
	
КонецПроцедуры

// Возвращает текст файла
// 
// Параметры:
//  ПолноеИмяФайла - Строка - Полное имя файла, разделитель пути - `/`
// 
// Возвращаемое значение:
//  Строка - Текст файла
Функция ТекстФайла(ПолноеИмяФайла) Экспорт
	
	Файл = НайтиФайл(ПолноеИмяФайла);
	Если Файл.ЭтоКонтейнер Тогда
		ВызватьИсключение СтрШаблон("%1 это контейнер, а должен быть обычный файл", ПолноеИмяФайла);
	КонецЕсли;
	
	Возврат ПолучитьСтрокуИзДвоичныхДанных(Файл.Данные);
	
КонецФункции

// Собирает обработку из файлов
// 
// Возвращаемое значение:
//  ДвоичныеДанные - Обработку
Функция СформироватьОбработку() Экспорт
	
	ПараметрыЗаписи = ПараметрыЗаписи();
	ПотокЗаписи = Новый ПотокВПамяти();
	ЗаписатьКонтейнер(ПотокЗаписи, ФайлыОбработки, ПараметрыЗаписи, Истина);
	Возврат ПотокЗаписи.ЗакрытьИПолучитьДвоичныеДанные();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Чтение

Функция ПрочитатьКонтейнер(Поток, ПараметрыЗаписи, Распаковывать)
	
	Оглавление = ДанныеОглавления(ПотокДокумента(Поток, ПараметрыЗаписи, 16)); // Пропускаем заголовок контейнера - 16 байт
	ЗагрузитьФайлы(Поток, ПараметрыЗаписи, Оглавление, Распаковывать);
	
	Возврат Оглавление;
	
КонецФункции

Процедура ЗагрузитьФайлы(Поток, ПараметрыЗаписи, Оглавление, Распаковывать)
	
	Для Каждого Запись Из Оглавление Цикл
		Запись.ИмяФайла = ИмяФайлаИзАтрибутов(Поток, ПараметрыЗаписи, Запись.АдресЗаголовкаФайла);
		Данные = ДанныеФайла(Поток, ПараметрыЗаписи, Запись.АдресТелаФайла, Распаковывать);
		Запись.ЭтоКонтейнер = ЭтоКонтейнер(Данные);
		
		Если Запись.ЭтоКонтейнер Тогда
			ВложенныйПоток = Данные.ОткрытьПотокДляЧтения();
			ДанныеКонтейнера = ПрочитатьКонтейнер(ВложенныйПоток, ПараметрыЗаписи, Ложь);
			ВложенныйПоток.Закрыть();
			Запись.Данные = ДанныеКонтейнера;
		Иначе
			Запись.Данные = Данные;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ИмяФайлаИзАтрибутов(Поток, ПараметрыЗаписи, АдресАтрибутовФайла)
	
	ПотокАтрибутыФайла = ПотокДокумента(Поток, ПараметрыЗаписи, АдресАтрибутовФайла);
	Чтение = Новый ЧтениеДанных(ПотокАтрибутыФайла, КодировкаТекста.UTF16, ПорядокБайтов.LittleEndian, , Символ(0));
	Чтение.Пропустить(20); // Атрибуты
	ИмяФайла = СокрП(Чтение.ПрочитатьСтроку());
	ПотокАтрибутыФайла.Закрыть();
	
	Возврат ИмяФайла;
	
КонецФункции

Функция ДанныеФайла(Поток, ПараметрыЗаписи, АдресДанныеФайла, Распаковать)
	
	ПотокДанные = ПотокДокумента(Поток, ПараметрыЗаписи, АдресДанныеФайла);
	Данные = ПотокДанные.ЗакрытьИПолучитьДвоичныеДанные();
	ПотокДанные.Закрыть();
	
	Если Распаковать Тогда
		Данные = РаспаковатьДанные(Данные);
	КонецЕсли;
	
	Возврат Данные;
	
КонецФункции

Функция РаспаковатьДанные(Знач ДвоичныеДанные)
	
	Заголовок64 = "AgFTS2/0iI3BTqDV67a9oKcNAFEArv89AAAAAAAAAO+7v3siIyIsODcxMjYyMDAt
		|M2U5OC00NGUwLWI5MzEtY2NiMWQ3ZWRjNDk3LA0KezEsDQp7MH0NCn0NCn0AAAAA
		|//////////8=";
	ЗаголовокДляХранилищаЗначения = Base64Значение(Заголовок64);
	
	Поток = Новый ПотокВПамяти;
	ПотокЗаголовка = ЗаголовокДляХранилищаЗначения.ОткрытьПотокДляЧтения();
	ПотокЗаголовка.КопироватьВ(Поток);
	ПотокЗаголовка.Закрыть();
	ПотокДанных = ДвоичныеДанные.ОткрытьПотокДляЧтения();
	ПотокДанных.КопироватьВ(Поток);
	ПотокДанных.Закрыть();
	СводныйФайл = Поток.ЗакрытьИПолучитьДвоичныеДанные();
	ХранилищеЗначения = XMLЗначение(Тип("ХранилищеЗначения"), ПолучитьBase64СтрокуИзДвоичныхДанных(СводныйФайл));
	
	Попытка
		РаспакованныеДанные = ХранилищеЗначения.Получить();
	Исключение
		РаспакованныеДанные = ПолучитьДвоичныеДанныеИзHexСтроки("");
	КонецПопытки;
	
	Возврат РаспакованныеДанные;
	
КонецФункции

Функция ЗаголовокБлока(Чтение)
	
	Если Чтение.ПрочитатьБайт() <> 13 Или Чтение.ПрочитатьБайт() <> 10 Тогда
		ВызватьИсключение "Заголовок блока должен начинаться с `0D 0A`";
	КонецЕсли;
	
	ДлинаФайла = ЧислоЗаголовка(Чтение);
	Чтение.Пропустить(1); // Пробел 20
	ДлинаБлока = ЧислоЗаголовка(Чтение);
	Чтение.Пропустить(1); // Пробел 20
	СледующийБлок = ЧислоЗаголовка(Чтение);
	Чтение.Пропустить(3); // 20 0D 0A
	
	Чтение.Закрыть();
	ДанныеЗаголовка = Новый Структура("ДлинаФайла, ДлинаБлока, СледующийБлок", ДлинаФайла, ДлинаБлока, СледующийБлок);
	
	Возврат ДанныеЗаголовка;
	
КонецФункции

Функция ПотокДокумента(ВходнойПоток, ПараметрыЗаписи, АдресБлока)
	ОсталосьПрочитать = -1;
	
	СледующийБлок = АдресБлока;
	МаксимальноеЦелоеЧисло = ПараметрыЗаписи.МаксимальноеЦелоеЧисло;
	ЭтоПервыйБлок = Истина;
	
	Пока СледующийБлок < МаксимальноеЦелоеЧисло Цикл
		
		Если НЕ ЭтоПервыйБлок Или ОсталосьПрочитать = 0 Тогда
			ВызватьИсключение "Ошибка чтения потока из контейнера. Все байты прочитаны, но цепочка блоков не кончилась.";
		КонецЕсли;
		
		ВходнойПоток.Перейти(СледующийБлок, ПозицияВПотоке.Начало);
		Чтение = Новый ЧтениеДанных(ВходнойПоток, КодировкаТекста.ANSI, ПорядокБайтов.LittleEndian);
		
		Заголовок = ЗаголовокБлока(Чтение);
		СледующийБлок = Заголовок.СледующийБлок;
		
		Если Заголовок.ДлинаБлока = 0 Тогда
			ВызватьИсключение "Ошибка чтения потока из контейнера. Длина блока = 0.";
		КонецЕсли;
		
		Если ЭтоПервыйБлок Тогда
			ОсталосьПрочитать = Заголовок.ДлинаФайла;
			ПотокЗаписи = Новый ПотокВПамяти(Заголовок.ДлинаФайла);
			Запись = Новый ЗаписьДанных(ПотокЗаписи); // собираем документ из нескольких блоков
			ЭтоПервыйБлок = Ложь;
		КонецЕсли;
		
		Читаем = Мин(Заголовок.ДлинаБлока, ОсталосьПрочитать);
		Буфер = Чтение.ПрочитатьВБуферДвоичныхДанных(Читаем);
		Чтение.Закрыть();
		Запись.ЗаписатьБуферДвоичныхДанных(Буфер);
		ОсталосьПрочитать = ОсталосьПрочитать - Читаем;
	КонецЦикла;
	
	Запись.Закрыть();
	
	Если ОсталосьПрочитать > 0 Тогда
		ВызватьИсключение "Ошибка чтения потока из контейнера. Поток не считан до конца, но цепочка блоков закончилась.";
	КонецЕсли;
	
	ПотокЗаписи.Перейти(0, ПозицияВПотоке.Начало);
	
	Возврат ПотокЗаписи;
	
КонецФункции

Функция ДанныеОглавления(Поток)
	
	Чтение = Новый ЧтениеДанных(Поток, , ПорядокБайтов.LittleEndian);
	Оглавление = Новый Массив;
	
	Пока Истина Цикл
		
		Запись = ЗаписьОглавления();
		Запись.АдресЗаголовкаФайла = Чтение.ПрочитатьЦелое32();
		
		Если Запись.АдресЗаголовкаФайла = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Запись.АдресТелаФайла = Чтение.ПрочитатьЦелое32();
		Чтение.Пропустить(4); // 4 байта зарезервированное поле (7FFFFFFF)
		
		Оглавление.Добавить(Запись);
		
	КонецЦикла;
	
	Возврат Оглавление;
	
КонецФункции

Функция ЧислоЗаголовка(Чтение)
	
	Значение = "0x" + Чтение.ПрочитатьСимволы(8);
	Возврат ЧислоИзШестнадцатеричнойСтроки(Значение);
	
КонецФункции

Функция ЭтоКонтейнер(Данные)
	
	МаксимальноеЦелоеЧисло = 2147483647;
	Чтение = Новый ЧтениеДанных(Данные);
	Флаг = Чтение.ПрочитатьЦелое32();
	Чтение.Закрыть();
	
	Возврат Флаг = МаксимальноеЦелоеЧисло;
	
КонецФункции

#КонецОбласти

#Область Запись

Процедура ЗаписатьКонтейнер(Поток, Файлы, ПараметрыЗаписи, Паковать, ВыравниватьОглавление = Истина)
	
	ЗаписатьЗаголовокКонтейнера(Поток, ПараметрыЗаписи, Файлы);
	
	РазмерОглавления = Файлы.Количество() * ПараметрыЗаписи.РазмерПоляАдресации * 3;
	ПозицияОглавления = ЗарезервироватьМестоОглавления(Поток, ПараметрыЗаписи, РазмерОглавления, ВыравниватьОглавление);
	
	Оглавление = Новый БуферДвоичныхДанных(РазмерОглавления, ПорядокБайтов.LittleEndian);
	ПотокОглавления = Новый ПотокВПамяти(Оглавление);
	ЗаписьОглавления = Новый ЗаписьДанных(ПотокОглавления);
	
	Для Каждого Файл Из Файлы Цикл
		
		АдресДокументов = ЗаписатьФайл(Поток, Файл, ПараметрыЗаписи, Паковать);
		
		ЗаписьОглавления.ЗаписатьЦелое32(АдресДокументов.АдресАтрибутов);
		ЗаписьОглавления.ЗаписатьЦелое32(АдресДокументов.АдресДанных);
		ЗаписьОглавления.ЗаписатьБуферДвоичныхДанных(ПараметрыЗаписи.РазделительОглавления);
		
	КонецЦикла;
	
	ЗаписьОглавления.Закрыть();
	ПотокОглавления.Закрыть();
	
	Поток.Перейти(ПозицияОглавления, ПозицияВПотоке.Начало);
	ЗаписатьДокумент(Поток, Оглавление, ПараметрыЗаписи, Ложь, ВыравниватьОглавление);
	
КонецПроцедуры

Процедура ЗаписатьЗаголовокКонтейнера(Поток, ПараметрыЗаписи, Файлы)
	
	Запись = Новый ЗаписьДанных(Поток, , ПорядокБайтов.LittleEndian);
	Запись.ЗаписатьЦелое32(ПараметрыЗаписи.МаксимальноеЦелоеЧисло);
	Запись.ЗаписатьЦелое32(ПараметрыЗаписи.РазмерБлокаСодержимого); // размер блока по умолчанию
	Запись.ЗаписатьЦелое32(Файлы.Количество());
	Запись.ЗаписатьЦелое32(0);
	Запись.Закрыть();
	
КонецПроцедуры

Функция ЗарезервироватьМестоОглавления(Поток, ПараметрыЗаписи, РазмерОглавления, ВыравниватьОглавление)
	
	ПозицияОглавления = Поток.ТекущаяПозиция();
	Если ВыравниватьОглавление Тогда
		РезервируемыйРазмер = Макс(РазмерОглавления, ПараметрыЗаписи.РазмерБлокаСодержимого) + ПараметрыЗаписи.РазмерЗаголовкаБлока;
	Иначе
		РезервируемыйРазмер = РазмерОглавления + ПараметрыЗаписи.РазмерЗаголовкаБлока;
	КонецЕсли;
	
	Поток.Записать(Новый БуферДвоичныхДанных(РезервируемыйРазмер, ПорядокБайтов.LittleEndian), 0, РезервируемыйРазмер); // Резервирование под оглавление
	
	Возврат ПозицияОглавления;
	
КонецФункции

Функция ЗаписатьФайл(Поток, ОписаниеФайла, ПараметрыЗаписи, Паковать)
	
	Если ОписаниеФайла.ЭтоКонтейнер Тогда
		ПотокКонтейнера = Новый ПотокВПамяти();
		ЗаписатьКонтейнер(ПотокКонтейнера, ОписаниеФайла.Данные, ПараметрыЗаписи, Ложь, Ложь);
		ДанныеФайла = ПотокКонтейнера.ЗакрытьИПолучитьДвоичныеДанные();
	Иначе
		ДанныеФайла = ОписаниеФайла.Данные;
	КонецЕсли;
	
	АтрибутыФайла = АтрибутыФайла(ОписаниеФайла.ИмяФайла);
	
	АдресАтрибутов = ЗаписатьДокумент(Поток, АтрибутыФайла, ПараметрыЗаписи, Ложь, Ложь);
	АдресДанных = ЗаписатьДокумент(Поток, ДанныеФайла, ПараметрыЗаписи, Паковать, Истина);
	
	Возврат Новый Структура("АдресАтрибутов, АдресДанных", АдресАтрибутов, АдресДанных);
	
КонецФункции

Функция АтрибутыФайла(ИмяФайла)
	
	БуферИмениФайла = ПолучитьБуферДвоичныхДанныхИзСтроки(ИмяФайла, КодировкаТекста.UTF16);
	БуферАтрибутов = Новый БуферДвоичныхДанных(БуферИмениФайла.Размер + 24);
	БуферАтрибутов.ЗаписатьЦелое64(0, ДатаЧислом(ТекущаяДатаСеанса()));
	БуферАтрибутов.ЗаписатьЦелое64(8, ДатаЧислом(ТекущаяДатаСеанса()));
	БуферАтрибутов.ЗаписатьЦелое32(16, 0);
	БуферАтрибутов.Записать(20, БуферИмениФайла);
	
	Возврат БуферАтрибутов;
	
КонецФункции

Функция ЗаписатьДокумент(ПотокЗаписи, ИсточникДанных, ПараметрыЗаписи, Паковать = Ложь, Выравнивать = Истина)
	
	Позиция = ПотокЗаписи.ТекущаяПозиция();
	
	Если ТипЗнч(ИсточникДанных) = Тип("БуферДвоичныхДанных") Тогда
		ДанныеДокумента = ПолучитьДвоичныеДанныеИзБуфераДвоичныхДанных(ИсточникДанных);
	ИначеЕсли Паковать Тогда
		ДанныеДокумента = СжатьДвоичныеДанные(ИсточникДанных);
	Иначе
		ДанныеДокумента = ИсточникДанных;
	КонецЕсли;
	
	РазмерДанных = ДанныеДокумента.Размер();
	РазмерБлока = ?(Не Выравнивать, РазмерДанных, Макс(ПараметрыЗаписи.РазмерБлокаСодержимого, РазмерДанных));
	
	ЗаписьДокумента = Новый ЗаписьДанных(ПотокЗаписи);
	
	ЗаписатьЗаголовокБлока(ЗаписьДокумента, ПараметрыЗаписи, РазмерДанных, РазмерБлока);
	ЗаписьДокумента.Записать(ДанныеДокумента);
	
	ТребуетсяДописать = РазмерБлока - РазмерДанных;
	
	Если Выравнивать И ТребуетсяДописать > 0 Тогда
		ЗаписьДокумента.ЗаписатьБуферДвоичныхДанных(Новый БуферДвоичныхДанных(ТребуетсяДописать));
	КонецЕсли;
	
	ЗаписьДокумента.Закрыть();
	
	Возврат Позиция;
	
КонецФункции

Процедура ЗаписатьЗаголовокБлока(Запись, ПараметрыЗаписи, Размер, РазмерБлока)
	
	Запись.ЗаписатьБайт(13); // CR
	Запись.ЗаписатьБайт(10); // LF
	Запись.ЗаписатьБуферДвоичныхДанных(БайтыИзЧисла(Размер, ПараметрыЗаписи.РазмерПоляАдресации));
	Запись.ЗаписатьБайт(32); // Пробел
	Запись.ЗаписатьБуферДвоичныхДанных(БайтыИзЧисла(РазмерБлока, ПараметрыЗаписи.РазмерПоляАдресации));
	Запись.ЗаписатьБайт(32); // Пробел
	Запись.ЗаписатьБуферДвоичныхДанных(ПараметрыЗаписи.АдресПоследнегоБлока);
	Запись.ЗаписатьБайт(32); // Пробел
	Запись.ЗаписатьБайт(13); // CR
	Запись.ЗаписатьБайт(10); // LF
	
КонецПроцедуры

Функция БайтыИзЧисла(Число, Размер)
	
	Буфер = Новый БуферДвоичныхДанных(Размер);
	
	Если Размер = 4 Тогда
		Буфер.ЗаписатьЦелое32(0, Число, ПорядокБайтов.BigEndian);
	Иначе
		Буфер.ЗаписатьЦелое64(0, Число, ПорядокБайтов.BigEndian);
	КонецЕсли;
	
	Хекс = ПолучитьHexСтрокуИзБуфераДвоичныхДанных(Буфер);
	
	Возврат ПолучитьБуферДвоичныхДанныхИзСтроки(?(Размер = 4, НРег(Хекс), ВРег(Хекс)));
	
КонецФункции

Функция ДатаЧислом(ДатаВремя)
	
	Возврат (ДатаВремя - Дата(1, 1, 1)) * 10000;
	
КонецФункции

Функция СжатьДвоичныеДанные(ДвоичныеДанные)
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	ДвоичныеДанные.Записать(ИмяВременногоФайла);
	СжатыйФайл = СжатьФайл(ИмяВременногоФайла);
	УдалитьФайлы(ИмяВременногоФайла);
	
	Возврат СжатыйФайл;
	
КонецФункции

Функция СжатьФайл(ИмяФайлаДляСжатия)
	
	ПотокДанных = Новый ПотокВПамяти;
	
	ЗаписьZip = Новый ЗаписьZipФайла(ПотокДанных, , , МетодСжатияZIP.Сжатие, УровеньСжатияZIP.Оптимальный);
	ЗаписьZip.Добавить(ИмяФайлаДляСжатия);
	ЗаписьZip.Записать();
	
	ПотокДанных.Перейти(18, ПозицияВПотоке.Начало);
	
	Буфер = Новый БуферДвоичныхДанных(12, ПорядокБайтов.LittleEndian);
	ПотокДанных.Прочитать(Буфер, 0, 12);
	РазмерСжатыхДанных = Буфер.ПрочитатьЦелое32(0);
	РазмерИмениФайла = Буфер.ПрочитатьЦелое16(8);
	РазмерИмениДоп = Буфер.ПрочитатьЦелое16(10);
	
	ПотокДанных.Перейти(РазмерИмениФайла + РазмерИмениДоп, ПозицияВПотоке.Текущая);
	
	БуферСжатыеДанные = Новый БуферДвоичныхДанных(РазмерСжатыхДанных);
	ПотокДанных.Прочитать(БуферСжатыеДанные, 0, РазмерСжатыхДанных);
	ПотокДанных.Закрыть();
	
	Возврат ПолучитьДвоичныеДанныеИзБуфераДвоичныхДанных(БуферСжатыеДанные);
	
КонецФункции

#КонецОбласти

#Область РаботаСФайлами

Функция НайтиФайл(ПолноеИмяФайла)
	
	Путь = СтрРазделить(ПолноеИмяФайла, "/");
	
	Файлы = ФайлыОбработки();
	Для Инд = 0 По Путь.ВГраница() Цикл
		
		НайденныйФайл = Неопределено;
		Для Каждого Файл Из Файлы Цикл
			Если СтрСравнить(Файл.ИмяФайла, Путь[Инд]) = 0 Тогда
				НайденныйФайл = Файл;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если НайденныйФайл = Неопределено Тогда
			ВызватьИсключение "Не удалось найти файл " + ПолноеИмяФайла;
		КонецЕсли;
		
		Если Инд < Путь.ВГраница() Тогда
			Если НЕ НайденныйФайл.ЭтоКонтейнер Тогда
				ВызватьИсключение СтрШаблон("%1 должен быть контейнером", Путь[Инд]);
			КонецЕсли;
			Файлы = НайденныйФайл.Данные;
		КонецЕсли;
	КонецЦикла;
	
	Возврат НайденныйФайл;
	
КонецФункции

#КонецОбласти
Функция ЗаписьОглавления()
	
	Запись = Новый Структура();
	Запись.Вставить("АдресЗаголовкаФайла", 0);
	Запись.Вставить("АдресТелаФайла", 0);
	Запись.Вставить("ИмяФайла", "");
	Запись.Вставить("ЭтоКонтейнер", Ложь);
	Запись.Вставить("Данные", Неопределено);
	
	Возврат Запись;
	
КонецФункции

Функция ПараметрыЗаписи()
	
	ПараметрыЗаписи = Новый Структура;
	ПараметрыЗаписи.Вставить("РазмерЗаголовкаКонтейнера", 16);
	ПараметрыЗаписи.Вставить("РазмерЗаголовкаБлока", 31);
	ПараметрыЗаписи.Вставить("РазмерПоляАдресации", 4);
	ПараметрыЗаписи.Вставить("РазделительОглавления", ПолучитьБуферДвоичныхДанныхИзHexСтроки("FFFFFF7F"));
	ПараметрыЗаписи.Вставить("Смещение", 0);
	ПараметрыЗаписи.Вставить("МаксимальноеЦелоеЧисло", 2147483647);
	ПараметрыЗаписи.Вставить("РазмерБлокаОглавления", 512);
	ПараметрыЗаписи.Вставить("РазмерБлокаСодержимого", 512);
	ПараметрыЗаписи.Вставить("ШаблонЗаголовкаБлока", ПолучитьБуферДвоичныхДанныхИзHexСтроки("0D0A0000000000000000200000000000000000203766666666666666200D0A"));
	ПараметрыЗаписи.Вставить("АдресПоследнегоБлока", ПолучитьБуферДвоичныхДанныхИзHexСтроки("3766666666666666"));
	
	Возврат ПараметрыЗаписи;
	
КонецФункции

#КонецОбласти

#КонецЕсли
