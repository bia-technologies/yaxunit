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

#Область СлужебныйПрограммныйИнтерфейс

Функция ИсполняемыйТестовыйМодуль(ТестовыйМодуль) Экспорт
	
	ИсполняемыйТестовыйМодуль = ЮТФабрикаСлужебный.НовоеОписаниеИсполняемогоТестовогоМодуля(ТестовыйМодуль);
	
	КонтекстыПриложения = ЮТФабрикаСлужебный.КонтекстыПриложения();
	КонтекстыМодуля = ЮТФабрикаСлужебный.КонтекстыМодуля(ТестовыйМодуль.Метаданные);
	КонтекстыИсполнения = ЮТФабрика.КонтекстыИсполнения();
	
	ИсполняемыйТестовыйМодуль.НаборыТестов = ИсполняемыеНаборыМодуля(ТестовыйМодуль);
	
	Для Каждого Набор Из ИсполняемыйТестовыйМодуль.НаборыТестов Цикл
		
		КонтекстИсполнения = ЮТФабрикаСлужебный.КонтекстИсполнения(Набор.Режим);
		
		Если КонтекстыПриложения.Найти(Набор.Режим) = Неопределено Тогда
			ОшибкаКонтекста = "Неподдерживаемый режим запуска";
		ИначеЕсли КонтекстыМодуля.Найти(Набор.Режим) = Неопределено Тогда
			ОшибкаКонтекста = "Модуль не доступен в этом контексте";
		ИначеЕсли КонтекстИсполнения <> КонтекстыИсполнения.Сервер И КонтекстИсполнения <> КонтекстыИсполнения.Клиент Тогда
			ОшибкаКонтекста = "Неизвестный контекст/режим исполнения";
		Иначе
			ОшибкаКонтекста = Неопределено;
		КонецЕсли;
		
		Если ОшибкаКонтекста <> Неопределено Тогда
			Набор.Выполнять = Ложь;
			ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуРежимаВыполнения(Набор, ОшибкаКонтекста);
			Для Каждого Тест Из Набор.Тесты Цикл
				ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуРежимаВыполнения(Тест, ОшибкаКонтекста);
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ИсполняемыйТестовыйМодуль;
	
КонецФункции

Функция ИсполняемыеНаборыМодуля(ТестовыйМодуль) Экспорт
	
	Результат = Новый Массив();
	
	Для Каждого ТестовыйНабор Из ТестовыйМодуль.НаборыТестов Цикл

		ОбработатьОшибкиЧтенияНабора(ТестовыйНабор, ТестовыйМодуль);
		НаборыКонтекстов = ИсполняемыеНаборыПоКонтекстам(ТестовыйНабор, ТестовыйМодуль);
		
		Если НаборыКонтекстов.Количество() Тогда
			Для Каждого Элемент Из НаборыКонтекстов Цикл
				Результат.Добавить(Элемент.Значение);
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Выполняет тесты группы наборов, соответствующих одному режиму выполнения (клиент/сервер) 
// Параметры:
//  Наборы - Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов - Наборы тестов модуля
//  ОписаниеТестовогоОбъекта - см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
// 
// Возвращаемое значение:
//  Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов - Результат прогона наборов тестов с заполненной информацией о выполнении
Функция ВыполнитьГруппуНаборовТестов(Наборы, ОписаниеТестовогоОбъекта) Экспорт
	
	Если Наборы.Количество() = 0 Тогда
		Возврат Наборы;
	КонецЕсли;
	
	ТестовыйМодуль = ТестовыйМодуль(ОписаниеТестовогоОбъекта);
	ЮТСобытияСлужебный.ПередВсемиТестамиМодуля(ТестовыйМодуль, ОписаниеТестовогоОбъекта);
	
	Если ЕстьОшибки(ОписаниеТестовогоОбъекта) Тогда
		СкопироватьОшибкиВ(Наборы, ОписаниеТестовогоОбъекта.Ошибки);
		Возврат Наборы;
	КонецЕсли;
	
	Для Каждого Набор Из Наборы Цикл
		
		Результат = ВыполнитьНаборТестов(ТестовыйМодуль, Набор, ОписаниеТестовогоОбъекта);
		
		Если Результат <> Неопределено Тогда
			Набор.Тесты = Результат;
		КонецЕсли;
		
	КонецЦикла;
	
	ЮТСобытияСлужебный.ПослеВсехТестовМодуля(ТестовыйМодуль, ОписаниеТестовогоОбъекта);
	
	Если ЕстьОшибки(ОписаниеТестовогоОбъекта) Тогда
		СкопироватьОшибкиВ(Наборы, ОписаниеТестовогоОбъекта.Ошибки);
	КонецЕсли;
	
	ОписаниеТестовогоОбъекта.Ошибки.Очистить(); // Эти ошибки используются как буфер и уже скопированы в наборы, но ломают последующие наборы
	
	Возврат Наборы;
	
КонецФункции

// Возвращает идентификатор тестового модуля.
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
// 
// Возвращаемое значение:
//  Строка
Функция ИдентификаторТестовогоМодуля(ТестовыйМодуль) Экспорт
	
	Возврат ТестовыйМодуль.Метаданные.Имя;
	
КонецФункции

// Возвращает идентификатор тестового набора.
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
//  ТестовыйНабор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
// 
// Возвращаемое значение:
//  Строка - Идентификатор тестового набора
Функция ИдентификаторТестовогоНабора(ТестовыйМодуль, ТестовыйНабор) Экспорт
	
	Возврат СтрШаблон("%1.%2.%3", ТестовыйМодуль.Метаданные.Имя, ТестовыйНабор.Имя, ТестовыйНабор.Режим);
	
КонецФункции

// Возврашает идентификатор теста.
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
//  ТестовыйНабор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
//  Тест - см. ЮТФабрика.ОписаниеИсполняемогоТеста
// 
// Возвращаемое значение:
//  Строка - Идентификатор теста
Функция ИдентификаторТеста(ТестовыйМодуль, ТестовыйНабор, Тест) Экспорт
	
	Возврат СтрШаблон("%1.%2.%3.%4.%5", ТестовыйМодуль.Метаданные.Имя, ТестовыйНабор.Имя, ТестовыйНабор.Режим, Тест.Имя, Тест.НомерВНаборе);
	
КонецФункции

Функция СценарииВнешнейОбработки(ИмяОбработки, ОписаниеМодуля) Экспорт
	
	МетаданныеОбработки = МетаданныеОбработки(ИмяОбработки, ОписаниеМодуля.Сервер, ОписаниеМодуля.КлиентУправляемое, ОписаниеМодуля.КлиентОбычное);
	Модуль = ТестовыйМодуль(Новый Структура("Метаданные", МетаданныеОбработки));
	
	Возврат ЮТЧитательСлужебный.ИсполняемыеСценарииОбъекта(Модуль, МетаданныеОбработки);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция МетаданныеОбработки(ИмяОбработки, Сервер, КлиентУправляемоеПриложение, КлиентОбычноеПриложение)
	
	Описание = ЮТФабрика.ОписаниеМетаданныеМодуля();
	Описание.Тип = "ВнешняяОбработка";
	Описание.Имя = ИмяОбработки;
	Описание.КлиентУправляемоеПриложение = КлиентУправляемоеПриложение;
	Описание.КлиентОбычноеПриложение = КлиентОбычноеПриложение;
	Описание.Сервер = Сервер;
	
	Возврат Описание;
	
КонецФункции

Функция ВыполнитьНаборТестов(ТестовыйМодуль, Набор, ОписаниеТестовогоОбъекта)
	
	Набор.ДатаСтарта = ТекущаяУниверсальнаяДатаВМиллисекундах();
	ЮТСобытияСлужебный.ПередТестовымНабором(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор);
	
	Если ЕстьОшибки(Набор) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Результаты = Новый Массив();
	
	Для Каждого Тест Из Набор.Тесты Цикл
		
#Если ТолстыйКлиентОбычноеПриложение Тогда
		Состояние(Тест.Имя);
#КонецЕсли
		ВТранзакции = Ложь;
		ПередКаждымТестом(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест, ВТранзакции);
		
		Тест.ДатаСтарта = ТекущаяУниверсальнаяДатаВМиллисекундах();
		ВыполнитьТестовыйМетод(ТестовыйМодуль, Тест);
		Тест.Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - Тест.ДатаСтарта;
		
		ПослеКаждогоТеста(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест, ВТранзакции);
		
		Тест.Статус = ЮТРегистрацияОшибокСлужебный.СтатусВыполненияТеста(Тест);
		Результаты.Добавить(Тест);
		
	КонецЦикла;
	
	ЮТСобытияСлужебный.ПослеТестовогоНабора(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор);
	
	Набор.Длительность = ТекущаяУниверсальнаяДатаВМиллисекундах() - Набор.ДатаСтарта;
		
	Возврат Результаты;
	
КонецФункции

Процедура ПередКаждымТестом(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест, ВТранзакции)
	
	ОбновитьПовторноИспользуемыеЗначения();
	ЮТКонтекстИсполненияСлужебныйКлиентСервер.УстановитьКонтекстИсполнения(ОписаниеТестовогоОбъекта, Набор, Тест);
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	ВТранзакции = ЮТНастройкиВыполнения.ВТранзакции();
	Если ВТранзакции Тогда
		// BSLLS:PairingBrokenTransaction-off
		// BSLLS:BeginTransactionBeforeTryCatch-off
		НачатьТранзакцию(); // Отмена транзакции в см. ПослеКаждогоТеста
		// BSLLS:PairingBrokenTransaction-on
		// BSLLS:BeginTransactionBeforeTryCatch-on
	КонецЕсли;
#КонецЕсли
	
	ЮТСобытияСлужебный.ПередКаждымТестом(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест);
	
КонецПроцедуры

Процедура ПослеКаждогоТеста(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест, ВТранзакции)
	
	Если КонтекстСломан(Тест, ВТранзакции) Тогда
		ЮТСобытияСлужебный.ПослеКаждогоТеста(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест);
	Иначе
		ЮТСобытияСлужебный.ПослеКаждогоТеста(ТестовыйМодуль, ОписаниеТестовогоОбъекта, Набор, Тест);
		Если НЕ КонтекстСломан(Тест, ВТранзакции) Тогда
			ОтменитьТранзакциюТеста(Тест, ВТранзакции);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Функция КонтекстСломан(Объект, ВТранзакции)
	
	КонтекстСломан = ЮТКонтекстСлужебный.ДанныеКонтекста() = Неопределено;
	
	Если КонтекстСломан Тогда
		ОбновитьПовторноИспользуемыеЗначения();
		ОтменитьТранзакциюТеста(Объект, ВТранзакции);
		ЮТЛогирование.Предостережение("Обнаружена поломка глобального контекста движка. Выполнена отмена транзакции и восстановление контекста");
	КонецЕсли;
	
	Возврат КонтекстСломан;
	
КонецФункции

Процедура ОтменитьТранзакциюТеста(Тест, ВТранзакции)
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	// BSLLS:PairingBrokenTransaction-off
	// BSLLS:WrongUseOfRollbackTransactionMethod-off
	Если ВТранзакции Тогда
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		Иначе
			ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьПростуюОшибкуВыполнения(Тест, "Обнаружено лишне закрытие транзакции");
		КонецЕсли;
	КонецЕсли;
	
	Пока ТранзакцияАктивна() Цикл
		ОтменитьТранзакцию();
		ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьПростуюОшибкуВыполнения(Тест, "Обнаружена незакрытая транзакция");
	КонецЦикла;
	// BSLLS:PairingBrokenTransaction-on
	// BSLLS:WrongUseOfRollbackTransactionMethod-on
#КонецЕсли
	
КонецПроцедуры

Функция ЕстьОшибки(Объект)
	
	Возврат ЗначениеЗаполнено(Объект.Ошибки);
	
КонецФункции

Процедура ВыполнитьТестовыйМетод(ТестовыйМодуль, Тест)
	
	Если ЕстьОшибки(Тест) Тогда
		Возврат;
	КонецЕсли;
	
	СтатусыИсполненияТеста = ЮТФабрика.СтатусыИсполненияТеста();
	Тест.Статус = СтатусыИсполненияТеста.Исполнение;
	
	Ошибка = ЮТМетодыСлужебный.ВыполнитьМетодОбъектаСПерехватомОшибки(ТестовыйМодуль, Тест.Метод, Тест.Параметры);
	
	Если Ошибка <> Неопределено Тогда
		ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуВыполненияТеста(Тест, Ошибка);
	КонецЕсли;
	
КонецПроцедуры

Процедура СкопироватьОшибкиВ(Объекты, Ошибки)
	
	Для Каждого Объект Из Объекты Цикл
		
		ЮТКоллекции.ДополнитьМассив(Объект.Ошибки, Ошибки);
		
		Если Объект.Свойство("Статус") Тогда
			Объект.Статус = ЮТФабрика.СтатусыИсполненияТеста().Сломан;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьОшибкиЧтенияНабора(Набор, Модуль)
	
	ТестыНабора = ЮТКоллекции.ЗначениеСтруктуры(Набор, "Тесты", Новый Массив());
	Ошибки = ЮТКоллекции.ЗначениеСтруктуры(Набор, "Ошибки", Новый Массив());
	
	Если Ошибки.Количество() > 0 Тогда
		Для Каждого Ошибка Из Ошибки Цикл
			
			Если Ошибка.ТипОшибки = ЮТФабрикаСлужебный.ТипыОшибок().ЧтенияТестов Тогда
				Тест = ОписаниеТестаСОшибкойЧтения(Модуль, Ошибка);
				ТестыНабора.Добавить(Тест);
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Функция ОписаниеТестаСОшибкойЧтения(Модуль, Ошибка)
	
	Контексты = ЮТФабрикаСлужебный.КонтекстыМодуля(Модуль.Метаданные);
	Тест = ЮТФабрикаСлужебный.ОписаниеТеста("ИсполняемыеСценарии", "ИсполняемыеСценарии", Контексты);
	Тест.Вставить("Ошибки", Новый Массив);
	Тест.Ошибки.Добавить(ЮТКоллекции.СкопироватьСтруктуру(Ошибка));
	
	Возврат Тест;
	
КонецФункции

Функция ТестовыйМодуль(ОписаниеТестовогоОбъекта)
	
	Если ОписаниеТестовогоОбъекта.Метаданные.Тип = "ОбщийМодуль" Тогда
		Возврат ЮТМетодыСлужебный.ВычислитьБезопасно(ОписаниеТестовогоОбъекта.Метаданные.Имя);
	КонецЕсли;
	
	Если ОписаниеТестовогоОбъекта.Метаданные.Тип = "ВнешняяОбработка" Тогда
#Если Клиент Тогда
		Возврат ПолучитьФорму(СтрШаблон("ВнешняяОбработка.%1.Форма", ОписаниеТестовогоОбъекта.Метаданные.Имя));
#Иначе
		Возврат ВнешниеОбработки.Создать(ОписаниеТестовогоОбъекта.Метаданные.Имя, Ложь);
#КонецЕсли
	КонецЕсли;
	
КонецФункции

Функция ИсполняемыеНаборыПоКонтекстам(ТестовыйНабор, ТестовыйМодуль)
	
	ТестыНабора = ЮТКоллекции.ЗначениеСтруктуры(ТестовыйНабор, "Тесты", Новый Массив());
	НаборыКонтекстов = Новый Структура;
	
	Для Каждого Тест Из ТестыНабора Цикл
		
		Для Каждого Контекст Из Тест.КонтекстВызова Цикл
			
			Если НЕ НаборыКонтекстов.Свойство(Контекст) Тогда
				ИсполняемыйНабор = ЮТФабрикаСлужебный.НовоеОписаниеИсполняемогоНабораТестов(ТестовыйНабор);
				ИсполняемыйНабор.Режим = Контекст;
				НаборыКонтекстов.Вставить(Контекст, ИсполняемыйНабор);
			Иначе
				ИсполняемыйНабор = НаборыКонтекстов[Контекст];
			КонецЕсли;
			
			ИсполняемыйТест = ЮТФабрикаСлужебный.НовоеОписаниеИсполняемогоТеста(Тест, Контекст, ТестовыйМодуль);
			
			Если Тест.Свойство("Ошибки") И Тест.Ошибки.Количество() > 0 Тогда
				ИсполняемыйТест.Ошибки = ЮТКоллекции.СкопироватьМассив(Тест.Ошибки);
				ИсполняемыйТест.ДатаСтарта = ТекущаяУниверсальнаяДатаВМиллисекундах();
				ИсполняемыйТест.Длительность = 0;
			КонецЕсли;
			
			ИсполняемыйНабор.Тесты.Добавить(ИсполняемыйТест);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат НаборыКонтекстов;
	
КонецФункции

#КонецОбласти
