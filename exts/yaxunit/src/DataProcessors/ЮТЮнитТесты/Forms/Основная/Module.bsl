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

#Область ОписаниеПеременных

// Содержит описания исполняемыъх тестовых модулей (наборов и тестов)
&НаКлиенте
Перем ИсполняемыеТестовыеМодули;

// Хранит параметры запуска тестов
&НаКлиенте
Перем ДанныеПоИдентификаторам;

&НаКлиенте
Перем ПараметрыЗапускаТестирования;

// Флаг необходимости отображения вопроса перед закрытием формы
&НаКлиенте
Перем НеЗадаватьВопросПриЗакрытии;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЭтоАдресВременногоХранилища(Параметры.АдресХранилища) Тогда
		АдресОтчета = Параметры.АдресХранилища;
	Иначе
		ЗагрузитьТестыПриОткрытии = Истина;
	КонецЕсли;
	
	Для Каждого Формат Из ФорматыВыводаОшибки() Цикл
		Элементы.ФорматВыводаОшибки.СписокВыбора.Добавить(Формат.Ключ, Формат.Ключ);
	КонецЦикла;
	
	ИмяФайлаПараметров = СохраненноеИмяФайлаПараметров();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(АдресОтчета) Тогда
		ДанныеОтчета = ДанныеОтчета(АдресОтчета);
		ПослеЗагрузкиТестов(ДанныеОтчета.РезультатыТестирования, ДанныеОтчета.ПараметрыЗапуска);
		ИмяФайлаПараметров = ЮТПараметрыЗапускаСлужебный.ФайлПараметровЗапускаТестирования();
	ИначеЕсли ЗагрузитьТестыПриОткрытии Тогда
		ЗагрузитьПараметрыТестирования();
		ЗагрузитьТесты();
	КонецЕсли;
	
	ПереключитьВыводОшибки();
	ОбновитьЗаголовок();
	
	НеЗадаватьВопросПриЗакрытии = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Или НеЗадаватьВопросПриЗакрытии Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	Обработчик = Новый ОписаниеОповещения("ОбработкаПодтвержденияЗакрытия", ЭтотОбъект);
	ПоказатьВопрос(Обработчик, "Закрыть окно работы с тестами?", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФорматВыводаОшибкиПриИзменении(Элемент)
	
	ПереключитьВыводОшибки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоТестов

&НаКлиенте
Процедура ДеревоТестовПриАктивизацииСтроки(Элемент)
	
	ПриИзмененииТекущегоЭлементаДереваТестов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сравнить(Команда)
	
	Данные = ДанныеТекущейОшибки();
	
	Если Данные = Неопределено ИЛИ ПустаяСтрока(Данные.ОжидаемоеЗначение) И ПустаяСтрока(Данные.ФактическоеЗначение) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("ОжидаемоеЗначение, ФактическоеЗначение", Данные.ОжидаемоеЗначение, Данные.ФактическоеЗначение);
	
	ОткрытьФорму("Обработка.ЮТЮнитТесты.Форма.Сравнение", ПараметрыФормы, ЭтотОбъект, , , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗамерВремениВыполнения(Команда)
	
	Обработчик = Новый ОписаниеОповещения("ПослеВодаКоличестваИтерацийЗамера", ЭтотОбъект);
	ПоказатьВводЧисла(Обработчик, 100, "Укажите количество итераций замера", 3, 0);
	
КонецПроцедуры

#Область ЗапускТестов

&НаКлиенте
Процедура ЗапуститьВсеТесты(Команда)
	
	ВыполнитьТестовыеМодули(ИсполняемыеТестовыеМодули);
	
КонецПроцедуры

&НаКлиенте
Процедура ПерезапуститьУпавшиеТесты(Команда)
	
	СтатусыИсполненияТеста = ЮТФабрика.СтатусыИсполненияТеста();
	Статусы = ЮТКоллекции.ЗначениеВМассиве(СтатусыИсполненияТеста.Ошибка, СтатусыИсполненияТеста.Сломан);
	
	Модули = МодулиСоответствующиеСтатусу(Статусы);
	ВыполнитьТестовыеМодули(Модули);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьВыделенныеТесты(Команда)
	
	Модули = ВыделенныеТестовыеМодули();
	ВыполнитьТестовыеМодули(Модули);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыполненияВыделенныхМодулей(Результат, ПараметрыИсполнения) Экспорт
	
	ПослеВыполненияТестов(Результат);
	
КонецПроцедуры

#КонецОбласти

#Область Настройки

&НаКлиенте
Процедура НастройкиРедактировать(Команда)
	
	ОткрытьФорму("Обработка.ЮТЮнитТесты.Форма.СозданиеНастройки", , ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗагрузить(Команда)
	
	Обработчик = Новый ОписаниеОповещения("ОбработчикВыбораФайлаПараметров", ЭтотОбъект);
	ЮТПользовательскийИнтерфейсСлужебныйКлиент.ВыбратьЗагружаемыйФайл("*.json", ИмяФайлаПараметров, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиПерезагрузить(Команда)
	
	ЗагрузитьПараметрыТестирования();
	
	Обработчик = Новый ОписаниеОповещения("ОбработчикВопросаПерезагрузитьТесты", ЭтотОбъект);
	ПоказатьВопрос(Обработчик, "Перезагрузить тесты?", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ТестыПерезагрузить(Команда)
	
	ЗагрузитьТесты();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ВыводОтчета

&НаСервереБезКонтекста
Функция ДанныеОтчета(Знач АдресХранилища)
	
	Данные = ПолучитьИзВременногоХранилища(АдресХранилища);
	УдалитьИзВременногоХранилища(АдресХранилища);
	
	Возврат Данные;
	
КонецФункции

&НаКлиенте
Процедура ОтобразитьРезультатТеста(СтрокаТеста, Тест, Набор)
	
	СтрокаТеста.Представление = Тест.Имя;
	СтрокаТеста.Контекст = НормализоватьКонтекст(Набор.Режим);
	СтрокаТеста.ПредставлениеВремяВыполнения = ЮТОбщий.ПредставлениеПродолжительности(Тест.Длительность);
	СтрокаТеста.ВремяВыполнения = Тест.Длительность;
	СтрокаТеста.Состояние = Тест.Статус;
	СтрокаТеста.ТипОбъекта = 3;
	СтрокаТеста.Иконка = КартинкаСтатуса(Тест.Статус);
	
	ЗаполнитьОшибки(СтрокаТеста, Тест);
	
КонецПроцедуры

&НаКлиенте
Функция ОбновитьСтатистикуНабора(СтрокаНабора)
	
	СтатистикаНабора = СтатистикаНабора(СтрокаНабора);
	Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	
	Если СтатистикаНабора.Сломано Тогда
		СтрокаНабора.Состояние = Статусы.Сломан;
	ИначеЕсли СтатистикаНабора.Упало Тогда
		СтрокаНабора.Состояние = Статусы.Ошибка;
	ИначеЕсли СтатистикаНабора.Пропущено Тогда
		СтрокаНабора.Состояние = Статусы.Пропущен;
	ИначеЕсли СтатистикаНабора.Неизвестно Тогда
		СтрокаНабора.Состояние = Статусы.Ошибка;
	ИначеЕсли СтатистикаНабора.Ожидание Тогда
		СтрокаНабора.Состояние = Статусы.Ожидание;
	Иначе
		СтрокаНабора.Состояние = Статусы.Успешно;
	КонецЕсли;
	
	Если СтрокаНабора.Состояние = Статусы.Ожидание И ЗначениеЗаполнено(СтрокаНабора.Ошибки) Тогда
		СтрокаНабора.Прогресс = КартинкаСтатуса(Статусы.Сломан);
		Возврат СтатистикаНабора;
	КонецЕсли;
	
	СтрокаНабора.Прогресс = ГрафическоеПредставлениеСтатистики(СтатистикаНабора);
	
	СтрокаНабора.ПредставлениеВремяВыполнения = ЮТОбщий.ПредставлениеПродолжительности(СтатистикаНабора.Продолжительность);
	СтрокаНабора.ВремяВыполнения = СтатистикаНабора.Продолжительность;
	
	Возврат СтатистикаНабора;
	
КонецФункции

&НаКлиенте
Процедура ОбновитьОбщуюСтатистику(ОбновлятьСтатистикуНаборов)
	
	ОбщаяСтатистика = Статистика();
	
	Для Каждого СтрокаНабора Из ДеревоТестов.ПолучитьЭлементы() Цикл
		
		Если ОбновлятьСтатистикуНаборов Тогда
			СтатистикаНабора = ОбновитьСтатистикуНабора(СтрокаНабора);
		Иначе
			СтатистикаНабора = СтатистикаНабора(СтрокаНабора);
		КонецЕсли;
		
		Для Каждого Элемент Из СтатистикаНабора Цикл
			ЮТОбщий.Инкремент(ОбщаяСтатистика[Элемент.Ключ], Элемент.Значение);
		КонецЦикла;
		
	КонецЦикла;
	
	Элементы.СтатистикаВыполнения.Заголовок = ПредставлениеСтатистики(ОбщаяСтатистика);
	
КонецПроцедуры

&НаКлиенте
Функция СтатистикаНабора(СтрокаНабора)
	
	СтатистикаНабора = Статистика();
	Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	
	Для Каждого СтрокаТеста Из СтрокаНабора.ПолучитьЭлементы() Цикл
		
		ИнкрементСтатистики(СтатистикаНабора, СтрокаТеста.Состояние, Статусы);
		ЮТОбщий.Инкремент(СтатистикаНабора.Продолжительность, СтрокаТеста.ВремяВыполнения);
		
	КонецЦикла;
	
	Возврат СтатистикаНабора;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьОшибки(СтрокаДерева, ОписаниеОбъекта)
	
	СтрокаДерева.Ошибки.Очистить();
	Для Каждого Ошибка Из ОписаниеОбъекта.Ошибки Цикл
		
		СтрокаОшибки = СтрокаДерева.Ошибки.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаОшибки, Ошибка);
		СтрокаОшибки.Лог.ЗагрузитьЗначения(Ошибка.Лог);
		СтрокаОшибки.ОжидаемоеЗначение = ЮТКоллекции.ЗначениеСтруктуры(Ошибка, "ОжидаемоеЗначение");
		СтрокаОшибки.ФактическоеЗначение = ЮТКоллекции.ЗначениеСтруктуры(Ошибка, "ПроверяемоеЗначение");
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция Статистика()
	
	Статистика = Новый Структура();
	Статистика.Вставить("Всего", 0);
	Статистика.Вставить("Успешно", 0);
	Статистика.Вставить("Упало", 0);
	Статистика.Вставить("Сломано", 0);
	Статистика.Вставить("Пропущено", 0);
	Статистика.Вставить("Ожидание", 0);
	Статистика.Вставить("Неизвестно", 0);
	Статистика.Вставить("Продолжительность", 0);
	
	Возврат Статистика;
	
КонецФункции

&НаКлиенте
Функция НормализоватьКонтекст(Контекст)
	
	Если СтрНачинаетсяС(Контекст, "Клиент") Тогда
		Возврат "Клиент";
	Иначе
		Возврат Контекст;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ИнкрементСтатистики(Статистика, Статус, Знач Статусы = Неопределено)
	
	Если Статусы = Неопределено Тогда
		Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	КонецЕсли;
	
	ЮТОбщий.Инкремент(Статистика.Всего);
	
	Если Статус = Статусы.Успешно Тогда
		
		ЮТОбщий.Инкремент(Статистика.Успешно);
		
	ИначеЕсли Статус = Статусы.Сломан ИЛИ Статус = Статусы.НеРеализован Тогда
		
		ЮТОбщий.Инкремент(Статистика.Сломано);
		
	ИначеЕсли Статус = Статусы.Ошибка Тогда
		
		ЮТОбщий.Инкремент(Статистика.Упало);
		
	ИначеЕсли Статус = Статусы.Пропущен Тогда
		
		ЮТОбщий.Инкремент(Статистика.Пропущено);
		
	ИначеЕсли Статус = Статусы.Ожидание Тогда
		
		ЮТОбщий.Инкремент(Статистика.Ожидание);
		
	Иначе
		
		ЮТОбщий.Инкремент(Статистика.Неизвестно);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Интерфейсное

&НаКлиенте
Функция КартинкаСтатуса(Статус)
	
	Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	
	Если Статус = Статусы.Успешно Тогда
		
		Возврат БиблиотекаКартинок.ЮТУспешно;
		
	ИначеЕсли Статус = Статусы.Сломан ИЛИ Статус = Статусы.НеРеализован Тогда
		
		Возврат БиблиотекаКартинок.ЮТОшибка;
		
	ИначеЕсли Статус = Статусы.Ошибка Тогда
		
		Возврат БиблиотекаКартинок.ЮТУпал;
		
	ИначеЕсли Статус = Статусы.Пропущен Тогда
		
		Возврат БиблиотекаКартинок.ЮТПропущен;
		
	Иначе
		
		Возврат БиблиотекаКартинок.ЮТНеизвестный;
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Функция ПредставлениеСтатистики(Статистика)
	
	БлокиСтатистики = Новый Массив();
	Разделитель = ";    ";
	
	БлокиСтатистики.Добавить(СтрШаблон("Тестов: %1/%2", Статистика.Всего - Статистика.Пропущено - Статистика.Ожидание, Статистика.Всего));
	
	Если Статистика.Ожидание Тогда
		БлокиСтатистики.Добавить(Разделитель);
		БлокиСтатистики.Добавить(БиблиотекаКартинок.ЮТНеизвестный);
		БлокиСтатистики.Добавить(" Ожидание: " + Статистика.Ожидание);
	КонецЕсли;
	
	Если Статистика.Пропущено Тогда
		БлокиСтатистики.Добавить(Разделитель);
		БлокиСтатистики.Добавить(БиблиотекаКартинок.ЮТПропущен);
		БлокиСтатистики.Добавить(" Пропущено: " + Статистика.Пропущено);
	КонецЕсли;
	
	БлокиСтатистики.Добавить(Разделитель);
	БлокиСтатистики.Добавить(БиблиотекаКартинок.ЮТУспешно);
	БлокиСтатистики.Добавить(" Успешно: " + Статистика.Успешно);
	
	БлокиСтатистики.Добавить(Разделитель);
	БлокиСтатистики.Добавить(БиблиотекаКартинок.ЮТОшибка);
	БлокиСтатистики.Добавить(" Сломано: " + Статистика.Сломано);
	
	БлокиСтатистики.Добавить(Разделитель);
	БлокиСтатистики.Добавить(БиблиотекаКартинок.ЮТУпал);
	БлокиСтатистики.Добавить(" Упало: " + Статистика.Упало);
	
	Если Статистика.Неизвестно Тогда
		БлокиСтатистики.Добавить(Разделитель);
		БлокиСтатистики.Добавить(БиблиотекаКартинок.ЮТНеизвестный);
		БлокиСтатистики.Добавить(" Неизвестно: " + Статистика.Неизвестно);
	КонецЕсли;
	
	БлокиСтатистики.Добавить(Разделитель);
	БлокиСтатистики.Добавить(" Время выполнения: " + ЮТОбщий.ПредставлениеПродолжительности(Статистика.Продолжительность));
	
	Возврат Новый ФорматированнаяСтрока(БлокиСтатистики);
	
КонецФункции

&НаКлиенте
Функция ГрафическоеПредставлениеСтатистики(Статистика)
	
	Текст = БлокиСтатистики(Статистика);
	
	Возврат Новый Картинка(ПолучитьДвоичныеДанныеИзСтроки(Текст));
	
КонецФункции

&НаКлиенте
Функция БлокиСтатистики(Статистика)
	
	Блоки = Новый Массив();
	Ключи = "Количество, Цвет";
	
	Блоки.Добавить(Новый Структура(Ключи, Статистика.Успешно, "25AE88"));
	Блоки.Добавить(Новый Структура(Ключи, Статистика.Пропущено, "999999"));
	Блоки.Добавить(Новый Структура(Ключи, Статистика.Упало, "EFCE4A"));
	Блоки.Добавить(Новый Структура(Ключи, Статистика.Сломано, "D75A4A"));
	Блоки.Добавить(Новый Структура(Ключи, Статистика.Ожидание, "BBBBBB"));
	Блоки.Добавить(Новый Структура(Ключи, Статистика.Неизвестно, "9400d3"));
	
	Сдвиг = 0;
	Высота = 20;
	
	Текст = "";
	
	Для Инд = 0 По Блоки.ВГраница() Цикл
		
		Если Блоки[Инд].Количество = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Текст = Текст + СтрШаблон("	<rect x=""%1"" y=""2"" width=""%2"" height=""%3"" rx=""4"" ry=""4"" style=""fill:none;stroke:#%4;stroke-width:2""/>
								  |	<text x=""%5"" y=""%6"" dominant-baseline=""middle"" text-anchor=""middle"" style=""fill:#%4;"">%7</text>
								  |", Сдвиг + 2, Высота * 2 - 4, Высота - 4, Блоки[Инд].Цвет, Сдвиг + Высота, Высота - 4, Блоки[Инд].Количество);
		ЮТОбщий.Инкремент(Сдвиг, Высота * 2 + 2);
		
	КонецЦикла;
	
	Возврат СтрШаблон("<svg version=""1.1"" xmlns=""http://www.w3.org/2000/svg"" xmlns:xlink=""http://www.w3.org/1999/xlink""
					  |  x=""0px"" y=""0px"" width=""%1px"" height=""%2px""
					  |  viewBox=""0 0 %1 %2"">
					  |	%3
					  |</svg>", Сдвиг, Высота + 2, Текст);
	
КонецФункции

&НаКлиенте
Процедура ПриИзмененииТекущегоЭлементаДереваТестов()
	
	Данные = Элементы.ДеревоТестов.ТекущиеДанные;
	
	Если Данные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Данные.Ошибки.Количество() Тогда
		Элементы.ДеревоТестовОшибки.ТекущаяСтрока = Данные.Ошибки[0].ПолучитьИдентификатор();
	КонецЕсли;
	
	ОтобразитьДанныеОшибки();
	ОбновитьДоступностьСравнения();
	
КонецПроцедуры

#КонецОбласти

#Область ЗагрузкаТестов

&НаКлиенте
Процедура ЗагрузитьТесты()
	
	Если ПараметрыЗапускаТестирования = Неопределено Тогда
		ПараметрыЗапускаТестирования = ЮТПараметрыЗапускаСлужебный.ПараметрыТестированияПоУмолчанию();
	КонецЕсли;
	
	Обработчик = Новый ОписаниеОповещения("ПослеЗагрузкиТестов", ЭтотОбъект, ПараметрыЗапускаТестирования);
	ЮТИсполнительСлужебныйКлиент.ЗагрузитьИсполняемыеТесты(ПараметрыЗапускаТестирования, Обработчик);
	ПоказатьОповещениеПользователя("Дерево тестов", , "Тесты загружены", БиблиотекаКартинок.ЮТСтруктура);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗагрузкиТестов(Результат, ПараметрыЗапуска) Экспорт
	
	ИсполняемыеТестовыеМодули = Результат;
	ПараметрыЗапускаТестирования = ПараметрыЗапуска;
	
	ДанныеПоИдентификаторам = Новый Структура("Тесты, Наборы, Модули", Новый Соответствие, Новый Соответствие, Новый Соответствие);
	ДеревоТестов.ПолучитьЭлементы().Очистить();
	
	Для Каждого ТестовыйМодуль Из ИсполняемыеТестовыеМодули Цикл
		
		Для Каждого Набор Из ТестовыйМодуль.НаборыТестов Цикл
			
			СтрокаНабора = ДеревоТестов.ПолучитьЭлементы().Добавить();
			СтрокаНабора.Набор = Истина;
			СтрокаНабора.Представление = Набор.Представление;
			СтрокаНабора.Контекст = НормализоватьКонтекст(Набор.Режим);
			СтрокаНабора.ПредставлениеВремяВыполнения = ЮТОбщий.ПредставлениеПродолжительности(Набор.Длительность);
			СтрокаНабора.ВремяВыполнения = Набор.Длительность;
			СтрокаНабора.ТипОбъекта = 2;
			СтрокаНабора.Теги = СтрСоединить(Набор.Теги, ", ");
			
			ЗаполнитьОшибки(СтрокаНабора, Набор);
			
			Набор.Вставить("Идентификатор", СтрокаНабора.ПолучитьИдентификатор());
			ДанныеПоИдентификаторам.Наборы.Вставить(Набор.Идентификатор, Набор);
			ДанныеПоИдентификаторам.Модули.Вставить(Набор.Идентификатор, ТестовыйМодуль);
			
			Для Каждого Тест Из Набор.Тесты Цикл
				
				СтрокаТеста = СтрокаНабора.ПолучитьЭлементы().Добавить();
				
				ОтобразитьРезультатТеста(СтрокаТеста, Тест, Набор);
				СтрокаТеста.Теги = СтрСоединить(Тест.Теги, ", ");
				
				Тест.Вставить("Идентификатор", СтрокаТеста.ПолучитьИдентификатор());
				ДанныеПоИдентификаторам.Тесты.Вставить(Тест.Идентификатор, Тест);
				
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ОбновитьОбщуюСтатистику(Истина);
	
	ЮТКонтекстСлужебный.УдалитьКонтекст();
	
КонецПроцедуры

#КонецОбласти

#Область ЗапускТестов

&НаКлиенте
Процедура ПередВыполнениемТестов(Модули, Отказ)
	
	Если Модули.Количество() = 0 Тогда
		ПоказатьПредупреждение( , "Нет тестов для запуска");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ОповещениеПользователю("Прогон тестов", "Запушено выполнение тестов");
	
	Для Каждого Модуль Из Модули Цикл
		СброситьСостояниеТестирования(Модуль);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыполненияТестов(Модули)
	
	Для Каждого Модуль Из Модули Цикл
		
		Для Каждого Набор Из Модуль.НаборыТестов Цикл
			
			Для Каждого Тест Из Набор.Тесты Цикл
				
				Строка = ДеревоТестов.НайтиПоИдентификатору(Тест.Идентификатор);
				ОтобразитьРезультатТеста(Строка, Тест, Набор);
				
			КонецЦикла;
			
			Строка = ДеревоТестов.НайтиПоИдентификатору(Набор.Идентификатор);
			ЗаполнитьОшибки(Строка, Набор);
			ОбновитьСтатистикуНабора(Строка);
			
		КонецЦикла;
		
	КонецЦикла;
	
	ОбновитьОбщуюСтатистику(Ложь);
	
	ЮТКонтекстСлужебный.УдалитьКонтекст();
	
	ПриИзмененииТекущегоЭлементаДереваТестов();
	ОповещениеПользователю("Прогон тестов завершен", "Завершено выполнение тестов");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьТестовыеМодули(Модули)
	
	Отказ = Ложь;
	
	ПередВыполнениемТестов(Модули, Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Обработчик = Новый ОписаниеОповещения("ПослеВыполненияВыделенныхМодулей", ЭтотОбъект);
	ЮТИсполнительСлужебныйКлиент.ВыполнитьТестовыеМодули(ПараметрыЗапускаТестирования, Модули, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьСостояниеТестирования(Модуль)
	
	Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	
	Модуль.Ошибки.Очистить();
	
	Для Каждого Набор Из Модуль.НаборыТестов Цикл
		Набор.Ошибки.Очистить();
		Набор.Выполнять = Истина;
		
		Для Каждого Тест Из Набор.Тесты Цикл
			Тест.Ошибки.Очистить();
			Тест.Статус = Статусы.Ожидание;
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ВыделенныеТестовыеМодули()
	
	МодулиКЗапуску = Новый Массив();
	
	ВыделенныеСтроки = Элементы.ДеревоТестов.ВыделенныеСтроки;
	
	Если ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат МодулиКЗапуску;
	КонецЕсли;
	
	Наборы = Новый Массив;
	Тесты = Новый Массив;
	ЗапускаемыеМодули = Новый Соответствие();
	ЗапускаемыеНаборы = Новый Соответствие();
	
	Для Каждого Идендификатор Из ВыделенныеСтроки Цикл
		
		Если ДанныеПоИдентификаторам.Наборы[Идендификатор] <> Неопределено Тогда
			Наборы.Добавить(ДанныеПоИдентификаторам.Наборы[Идендификатор]);
			ЗапускаемыеМодули.Вставить(ДанныеПоИдентификаторам.Модули[Идендификатор]);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого Идендификатор Из ВыделенныеСтроки Цикл
		
		Тест = ДанныеПоИдентификаторам.Тесты[Идендификатор];
		Если Тест = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ИдентификаторНабора = ДеревоТестов.НайтиПоИдентификатору(Идендификатор).ПолучитьРодителя().ПолучитьИдентификатор();
		Набор = ДанныеПоИдентификаторам.Наборы[ИдентификаторНабора];
		Модуль = ДанныеПоИдентификаторам.Модули[ИдентификаторНабора];
		
		Если Набор <> Неопределено И Наборы.Найти(Набор) = Неопределено Тогда
			Тесты.Добавить(Новый Структура("Тест, Набор", Тест, Набор));
			ЗапускаемыеМодули.Вставить(Модуль);
			ЗапускаемыеНаборы.Вставить(Набор);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого Набор Из ЮТКоллекции.ВыгрузитьЗначения(ЗапускаемыеНаборы, "Ключ") Цикл
		Копия = ЮТКоллекции.СкопироватьСтруктуру(Набор, Ложь);
		Копия.Тесты = Новый Массив;
		ЗапускаемыеНаборы.Вставить(Набор, Копия);
		Наборы.Добавить(Копия);
	КонецЦикла;
	
	Для Каждого Тест Из Тесты Цикл
		ЗапускаемыйНабор = ЗапускаемыеНаборы[Тест.Набор];
		ЗапускаемыйНабор.Тесты.Добавить(Тест.Тест);
	КонецЦикла;
	
	Для Каждого Модуль Из ЮТКоллекции.ВыгрузитьЗначения(ЗапускаемыеМодули, "Ключ") Цикл
		Копия = ЮТКоллекции.СкопироватьСтруктуру(Модуль, Ложь);
		Копия.НаборыТестов = Новый Массив;
		ЗапускаемыеМодули.Вставить(Модуль, Копия);
		МодулиКЗапуску.Добавить(Копия);
	КонецЦикла;
	
	Для Каждого Набор Из Наборы Цикл
		
		Модуль = ДанныеПоИдентификаторам.Модули[Набор.Идентификатор];
		ЗапускаемыйМодуль = ЗапускаемыеМодули[Модуль];
		ЗапускаемыйМодуль.НаборыТестов.Добавить(Набор);
		
	КонецЦикла;
	
	Возврат МодулиКЗапуску;
	
КонецФункции

&НаКлиенте
Функция МодулиСоответствующиеСтатусу(Статусы)
	
	МодулиКЗапуску = Новый Массив();
	
	Для Каждого Модуль Из ИсполняемыеТестовыеМодули Цикл
		
		НаборыКЗапуску = Новый Массив();
		
		Для Каждого Набор Из Модуль.НаборыТестов Цикл
			
			ТестыКЗапуску = Новый Массив();
			
			Для Каждого Тест Из Набор.Тесты Цикл
				Если Статусы.Найти(Тест.Статус) <> Неопределено Тогда
					ТестыКЗапуску.Добавить(Тест);
				КонецЕсли;
			КонецЦикла;
			
			Если ТестыКЗапуску.Количество() Тогда
				ЗапускаемыйНабор = ЮТКоллекции.СкопироватьСтруктуру(Набор, Ложь);
				ЗапускаемыйНабор.Тесты = ТестыКЗапуску;
				НаборыКЗапуску.Добавить(ЗапускаемыйНабор);
			КонецЕсли;
			
		КонецЦикла;
		
		Если НаборыКЗапуску.Количество() Тогда
			
			ЗапускаемыйМодуль = ЮТКоллекции.СкопироватьСтруктуру(Модуль, Ложь);
			ЗапускаемыйМодуль.НаборыТестов = НаборыКЗапуску;
			МодулиКЗапуску.Добавить(ЗапускаемыйМодуль);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат МодулиКЗапуску;
	
КонецФункции

&НаКлиенте
Процедура ВыполнитьЗапускТестовПоПараметрам(ПараметрыЗапуска, Обработчик)
	
	ЮТИсполнительСлужебныйКлиент.ВыполнитьМодульноеТестированиеПоНастройке(ПараметрыЗапуска, Обработчик);
	
КонецПроцедуры

#КонецОбласти

#Область ПараметрыЗапуска

&НаКлиенте
Функция ПараметрыЗапуска()
	
	ПараметрыЗапуска = ЮТПараметрыЗапускаСлужебный.ПараметрыТестированияПоУмолчанию();
	ПараметрыЗапуска.closeAfterTests = Ложь;
	ПараметрыЗапуска.showReport = Ложь;
	ПараметрыЗапуска.ВыполнятьМодульноеТестирование = Истина;
	
	Возврат ПараметрыЗапуска;
	
КонецФункции

#КонецОбласти

&НаКлиенте
Процедура ОбновитьДоступностьСравнения()
	
	Данные = ДанныеТекущейОшибки();
	Элементы.Сравнить.Доступность = Данные <> Неопределено И (НЕ ПустаяСтрока(Данные.ОжидаемоеЗначение) ИЛИ НЕ ПустаяСтрока(Данные.ФактическоеЗначение));
	
КонецПроцедуры

&НаКлиенте
Функция ДанныеТекущейОшибки()
	
	Данные = Элементы.ДеревоТестовОшибки.ТекущиеДанные;
	
	Если Данные <> Неопределено Или ФорматВыводаОшибки = ФорматыВыводаОшибки().Текст Тогда
		Возврат Данные;
	КонецЕсли;
	
	ДанныеТеста = Элементы.ДеревоТестов.ТекущиеДанные;
	
	Если ДанныеТеста <> Неопределено И ЗначениеЗаполнено(ДанныеТеста.Ошибки) Тогда
		Возврат ДанныеТеста.Ошибки[0];
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ПослеВодаКоличестваИтерацийЗамера(Результат, ДополнительныеПараметры) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыЗамера = Новый Структура();
	ПараметрыЗамера.Вставить("ПараметрыЗапуска", ПараметрыЗапуска());
	ПараметрыЗамера.Вставить("КоличествоИтераций", Результат);
	ПараметрыЗамера.Вставить("ТекущаяИтерация", 0);
	ПараметрыЗамера.Вставить("Замеры", Новый Массив());
	ПараметрыЗамера.Вставить("НачалоИтерации");
	
	ПослеВыполненияИтерации(Неопределено, ПараметрыЗамера);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыполненияИтерации(Результат, ПараметрыЗамера) Экспорт
	
	Если ПараметрыЗамера.ТекущаяИтерация > 0 Тогда
		Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - ПараметрыЗамера.НачалоИтерации;
		ПараметрыЗамера.Замеры.Добавить(Длительность);
	КонецЕсли;
	
	Если ЮТОбщий.Инкремент(ПараметрыЗамера.ТекущаяИтерация) <= ПараметрыЗамера.КоличествоИтераций Тогда
		
		Обработчик = Новый ОписаниеОповещения("ПослеВыполненияИтерации", ЭтотОбъект, ПараметрыЗамера);
		ПараметрыЗамера.НачалоИтерации = ТекущаяУниверсальнаяДатаВМиллисекундах();
		ВыполнитьЗапускТестовПоПараметрам(ПараметрыЗамера.ПараметрыЗапуска, Обработчик);
		
	Иначе
		
		ОбщееВремя = 0;
		Для Каждого Замер Из ПараметрыЗамера.Замеры Цикл
			ЮТОбщий.Инкремент(ОбщееВремя, Замер);
		КонецЦикла;
		
		Список = Новый СписокЗначений();
		Список.ЗагрузитьЗначения(ПараметрыЗамера.Замеры);
		Список.СортироватьПоЗначению();
		
		ОбщееВремя = Окр(ОбщееВремя / 1000, 2);
		СреднееВремя = Окр(ОбщееВремя / ПараметрыЗамера.Замеры.Количество(), 2);
		МедианноеВремя = Окр(Список[Цел(Список.Количество() / 2) + 1].Значение / 1000, 2);
		
		Сообщение = СтрШаблон("Количество итераций: %1
							  |Общее время: %2 сек
							  |Среднее время: %3 сек
							  |Медианное время: %4 сек", ПараметрыЗамера.Замеры.Количество(), ОбщееВремя, СреднееВремя, МедианноеВремя);
		
		ЮТОбщий.СообщитьПользователю(Сообщение);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОповещениеПользователю(Текст, Пояснение)
	
	ПоказатьОповещениеПользователя(Текст,
								   ,
								   Пояснение,
								   БиблиотекаКартинок.ЮТПодсистема,
								   СтатусОповещенияПользователя.Важное,
								   УникальныйИдентификатор);
	
КонецПроцедуры

#Область ВыводОшибки

&НаКлиенте
Процедура ПереключитьВыводОшибки()
	
	Форматы = ФорматыВыводаОшибки();
	Если НЕ ЗначениеЗаполнено(ФорматВыводаОшибки) Тогда
		ФорматВыводаОшибки = Форматы.HTML;
	КонецЕсли;
	
	Элементы.ДеревоТестовОшибки.Видимость = ФорматВыводаОшибки = Форматы.Текст;
	Элементы.ДеревоТестовОшибкиСтек.Видимость = ФорматВыводаОшибки = Форматы.Текст;
	Элементы.ОтображениеОшибки.Видимость = ФорматВыводаОшибки = Форматы.HTML;
	
	Если ФорматВыводаОшибки = Форматы.HTML Тогда
		ОтобразитьДанныеОшибки();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ФорматыВыводаОшибки()
	
	Форматы = Новый Структура();
	Форматы.Вставить("Текст", "Текст");
	Форматы.Вставить("HTML", "HTML");
	
	Возврат Форматы;
	
КонецФункции

&НаКлиенте
Процедура ОтобразитьДанныеОшибки()
	
	ДанныеТеста = Элементы.ДеревоТестов.ТекущиеДанные;
	Если ДанныеТеста = Неопределено Или НЕ ЗначениеЗаполнено(ДанныеТеста.Ошибки) Тогда
		Если ЭтоАдресВременногоХранилища(ОтображениеОшибки) Тогда
			УдалитьИзВременногоХранилища(ОтображениеОшибки);
		КонецЕсли;
		ОтображениеОшибки = Неопределено;
		Возврат;
	КонецЕсли;
	
	ОтображениеОшибки = ДеревоОшибкиHTML(ОтображениеОшибки, ДанныеТеста.Ошибки);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДеревоОшибкиHTML(Знач АдресХранилища, Знач Ошибки)
	
	Если ЭтоАдресВременногоХранилища(АдресХранилища) Тогда
		УдалитьИзВременногоХранилища(АдресХранилища);
	КонецЕсли;
	
	Блоки = Новый Массив();
	
	Для Каждого Ошибка Из Ошибки Цикл
		ВывестиДанныеОшибки(Блоки, Ошибка);
	КонецЦикла;
	
	ШаблонПредставленияОшибки = ЮТОбщий.Макет("ОбщийМакет.ЮТИнформацияОбОшибке").ПолучитьТекст();
	ПредставленияОшибки = СтрЗаменить(ШаблонПредставленияОшибки, "TREE_CONTENT", СтрСоединить(Блоки, Символы.ПС));
	
	Возврат ПредставленияОшибки;

КонецФункции

&НаСервереБезКонтекста
Процедура ВывестиДанныеОшибки(Блоки, Ошибка)
	
	ТипыОшибок = ЮТФабрикаСлужебный.ТипыОшибок();
	Если Ошибка.ТипОшибки = ТипыОшибок.Утверждений Тогда
		Класс = "failure";
	ИначеЕсли Ошибка.ТипОшибки = ТипыОшибок.Пропущен Тогда
		Класс = "skipped";
	Иначе
		Класс = "error";
	КонецЕсли;
	
	Блоки.Добавить(СтрШаблон("<div class='row main %1'>
							 |<div class='row-title'>
							 |	<span class='caret'></span>
							 |	<span class='status'></span>
							 |	<pre>%2</pre>
							 |</div>
							 |", Класс, ЗаменитьСпецСимволы(Ошибка.Сообщение)));
	Если ЗначениеЗаполнено(Ошибка.Лог) Или ЗначениеЗаполнено(Ошибка.Стек) Тогда
		Блоки.Добавить("<div class='nested'>");
		ВывестиЛог(Блоки, Ошибка.Лог);
		ВывестиСтек(Блоки, Ошибка.Стек, Класс);
		Блоки.Добавить("</div>");
	КонецЕсли;
	Блоки.Добавить("</div>");
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ВывестиЛог(Блоки, Лог)
	
	Если НЕ ЗначениеЗаполнено(Лог) Тогда
		Возврат;
	КонецЕсли;
	
	Блоки.Добавить("<div class='log-block side'>
				   |	<span class='log-title'>Лог исполнения</span>
				   |	<div class='nested'>");
	Для Каждого Строка Из Лог Цикл
		Блоки.Добавить(СтрШаблон("	<pre class='note-line'>%1</pre>", ЗаменитьСпецСимволы(Строка)));
	КонецЦикла;
	Блоки.Добавить("</div></div>");
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ВывестиСтек(Блоки, ПредставлениеСтека, Класс)
	
	Если НЕ ЗначениеЗаполнено(ПредставлениеСтека) Тогда
		Возврат;
	КонецЕсли;
	
	Стек = Стек(ПредставлениеСтека);
	
	Блоки.Добавить(СтрШаблон("<div class='row main %1' style='margin-left:1em'>
							 |<div class='row-title'>
							 |	<span class='caret'></span>
							 |	<span class='status'></span>
							 |	<pre>%2</pre>
							 |</div>
							 |<div class='nested'>
							 |", Класс, ЗаменитьСпецСимволы(Стек.Сообщение)));
	
	Для Каждого Линия Из Стек.Линии Цикл
		Блоки.Добавить(СтрШаблон("<div class='row-title side line' style='margin-left:1em'></span><span class='status'></span>
								 |<pre>%1</pre>
								 |</div>
								 |", ЗаменитьСпецСимволы(Линия)));
	КонецЦикла;
	
	Блоки.Добавить("</div></div>");
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаменитьСпецСимволы(Знач Стр)

	Стр = СтрЗаменить(Стр, "&", "&amp;");
	Стр = СтрЗаменить(Стр, """", "&quot;");
	Стр = СтрЗаменить(Стр, "<", "&lt;");
	Стр = СтрЗаменить(Стр, ">", "&gt;");
	Стр = СтрЗаменить(Стр, "‘", "&apos;");
	
	Возврат СокрЛП(Стр);
	
КонецФункции

&НаСервереБезКонтекста
Функция Стек(Стек)
	
	Разделитель = Символы.ПС;
	Строки = СтрРазделить(Стек, Разделитель);
	
	Корень = Новый Структура("Сообщение, Линии", Неопределено, Новый Массив());
	
	Для Инд = 0 По Строки.ВГраница() Цикл
		
		Строка = Строки[Инд];
		Если СтрНачинаетсяС(Строка, "{") И СтрНайти(Строка, ")}") Тогда
			НомерСтроки = Инд;
			Прервать;
		КонецЕсли;
		
		Корень.Сообщение = ЮТСтроки.ДобавитьСтроку(Корень.Сообщение, Строка, Разделитель);
	КонецЦикла;
	
	Для Инд = НомерСтроки По Строки.ВГраница() Цикл
		Строка = Строки[Инд];
		Если СтрНачинаетсяС(Строка, "{") И СтрНайти(Строка, ")}") Тогда
			Корень.Линии.Добавить(Строка);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Корень;
	
КонецФункции

#КонецОбласти

&НаКлиенте
Процедура ОбработкаПодтвержденияЗакрытия(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		НеЗадаватьВопросПриЗакрытии = Истина;
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикВыбораФайлаПараметров(ИмяФайла, ДополнительныеПараметры) Экспорт
	
	ИмяФайлаПараметров = ИмяФайла;
	ЗагрузитьПараметрыТестирования();
	СохранитьИмяФайлаПараметров(ИмяФайлаПараметров);
	
	Обработчик = Новый ОписаниеОповещения("ОбработчикВопросаПерезагрузитьТесты", ЭтотОбъект);
	ПоказатьВопрос(Обработчик, "Перезагрузить тесты?", РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикВопросаПерезагрузитьТесты(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ЗагрузитьТесты();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗаголовок()
	
	ЗаголовокПоУмолчанию = "YAxUnit";
	
	Если ЗначениеЗаполнено(ИмяФайлаПараметров) Тогда
		Заголовок = СтрШаблон("%1: %2", ЗаголовокПоУмолчанию, ИмяФайлаПараметров);
	Иначе
		Заголовок = ЗаголовокПоУмолчанию;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьПараметрыТестирования()
	
	Если НЕ ЗначениеЗаполнено(ИмяФайлаПараметров) Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьЗаголовок();
	
	Попытка
		ПараметрыЗапускаТестирования = ЮТПараметрыЗапускаСлужебный.ПараметрыЗапускаИзФайла(ИмяФайлаПараметров, Неопределено);
	Исключение
		Ошибка = ИнформацияОбОшибке();
	КонецПопытки;
	
	Если Ошибка = Неопределено Тогда
		ПоказатьОповещениеПользователя("Настройки тестирования", , "Настройки загружены", БиблиотекаКартинок.ЮТНастройки);
	Иначе
		ПоказатьПредупреждение(, "Не удалось загрузить настройки тестирования. " + КраткоеПредставлениеОшибки(Ошибка));
	КонецЕсли;
	
КонецПроцедуры

#Область СохраняемыеПараметры

&НаСервереБезКонтекста
Функция СохраненноеИмяФайлаПараметров()
	
	Возврат ЗначениеИзХранилищаОбщихНастроек(КлючОбъекта(), КлючИмяФайлаПараметров());
	
КонецФункции

&НаСервереБезКонтекста
Процедура СохранитьИмяФайлаПараметров(Знач ИмяФайла)
	
	ХранилищеОбщихНастроек.Сохранить(КлючОбъекта(), КлючИмяФайлаПараметров(), ИмяФайла);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗначениеИзХранилищаОбщихНастроек(Знач КлючОбъекта, Знач КлючНастройки, Знач ОжидаемыйТип = Неопределено)
	
	Значение = ХранилищеОбщихНастроек.Загрузить(КлючОбъекта, КлючНастройки);
	
	Если ОжидаемыйТип <> Неопределено Тогда
		Значение = ОжидаемыйТип.ПривестиЗначение(Значение);
	КонецЕсли;
	
	Возврат Значение;
	
КонецФункции

&НаСервереБезКонтекста
Функция КлючИмяФайлаПараметров()
	
	Возврат "ИмяФайлаПараметров";
	
КонецФункции

&НаСервереБезКонтекста
Функция КлючОбъекта()
	
	Возврат "YAxUnit";
	
КонецФункции

#КонецОбласти

#Область ВнешниеКоманды

&НаКлиенте
Процедура ПодключитсяКСерверу(ПараметрыПодключения)
	
	Ключ = "yaxunit-rpc-ws";
	
	Обработчики = Новый ОбработчикиWebSocketКлиентСоединения();
	Сокет = WebSocketКлиентСоединения.ОткрытьСоединение(Ключ, ПараметрыПодключения.АдресСервера)
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
