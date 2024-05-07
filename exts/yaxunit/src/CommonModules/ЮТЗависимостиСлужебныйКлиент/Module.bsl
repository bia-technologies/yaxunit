//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
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

// Разрешить зависимости.
// 
// Параметры:
//  ТестовыеМодули - Массив из см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоТестовогоМодуля
//  Обработчик - ОписаниеОповещения
Процедура РазрешитьЗависимости(ТестовыеМодули, Обработчик) Экспорт
	
	Зависимости = СобратьЗависимости(ТестовыеМодули);
	
	Если НЕ ЗначениеЗаполнено(Зависимости) Тогда
		ЮТЛогирование.Отладка("Обработка зависимостей: нет зависимостей");
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьОбработчик(Обработчик);
		Возврат;
	КонецЕсли;
	
	ПараметрыИсполнения = ЮТАсинхроннаяОбработкаСлужебныйКлиент.ЦепочкаАсинхроннойОбработки();
	ПараметрыИсполнения.Вставить("ТестовыеМодули", ТестовыеМодули);
	
	Для Каждого ОписаниеЗависимости Из Зависимости Цикл
		Параметры = Новый Структура("ОписаниеЗависимости, ПараметрыИсполнения", ОписаниеЗависимости, ПараметрыИсполнения);
		
		Если ОписаниеЗависимости.Асинхронный Тогда
			Загрузчик = Новый ОписаниеОповещения("РазрешитьЗависимостьАсинхронно", ЭтотОбъект, Параметры);
		Иначе
			Загрузчик = Новый ОписаниеОповещения("РазрешитьЗависимость", ЭтотОбъект, Параметры);
		КонецЕсли;
		
		ПараметрыИсполнения.Цепочка.Добавить(Загрузчик);
	КонецЦикла;
	
	ПараметрыИсполнения.Цепочка.Добавить(Новый ОписаниеОповещения("ПослеОбработкиЗависимостей", ЭтотОбъект, ПараметрыИсполнения));
	ПараметрыИсполнения.Цепочка.Добавить(Обработчик);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

// Дедупликация зависимостей.
// 
// Параметры:
//  РезультатЧтенияТестов - Массив из см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля - Набор описаний тестовых модулей,
//                          которые содержат информацию о запускаемых тестах
Процедура ДедупликацияЗависимостей(РезультатЧтенияТестов) Экспорт
	
	Зависимости = Новый Соответствие();
	
	Для Каждого ТестовыйМодуль Из РезультатЧтенияТестов Цикл
		
		ДедупликацияЗависимостейОбъекта(Зависимости, ТестовыйМодуль);
		
		Для Каждого ТестовыйНабор Из ТестовыйМодуль.НаборыТестов Цикл
			
			ДедупликацияЗависимостейОбъекта(Зависимости, ТестовыйНабор);
			
			Для Каждого Тест Из ТестовыйНабор.Тесты Цикл
				ДедупликацияЗависимостейОбъекта(Зависимости, Тест);
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область РазрешениеЗависимостей

Функция СобратьЗависимости(ТестовыеМодули)
	
	Зависимости = Новый Массив();
	ДобавленныеЗависимости = Новый Соответствие();
	
	Для Каждого ТестовыйМодуль Из ТестовыеМодули Цикл
		
		СобратьЗависимостиОбъекта(ТестовыйМодуль, Зависимости, ДобавленныеЗависимости);
		
		Для Каждого Набор Из ТестовыйМодуль.НаборыТестов Цикл
			
			СобратьЗависимостиОбъекта(Набор, Зависимости, ДобавленныеЗависимости);
			
			Для Каждого Тест Из Набор.Тесты Цикл
				СобратьЗависимостиОбъекта(Тест, Зависимости, ДобавленныеЗависимости);
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Зависимости;
	
КонецФункции

Процедура СобратьЗависимостиОбъекта(Объект, Зависимости, ДобавленныеЗависимости)
	
	Для Каждого Зависимость Из Объект.Зависимости Цикл
		
		Если ДобавленныеЗависимости[Зависимость.Ключ] = Неопределено Тогда
			Зависимости.Добавить(Зависимость);
			ДобавленныеЗависимости.Вставить(Зависимость.Ключ, Истина);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура РазрешитьЗависимостьАсинхронно(_, Параметры) Экспорт
	
	ОписаниеЗависимости = Параметры.ОписаниеЗависимости;
	ПредставлениеЗависимости = ЮТЗависимостиСлужебный.ПредставлениеЗависимости(ОписаниеЗависимости);
	
	ЮТЛогирование.Отладка("Обработка зависимостей: асинхронная обработка зависимости " + ПредставлениеЗависимости);
	
	Если ОписаниеЗависимости.ОбработкаНаСервере Тогда
		Результат = ЮТФабрикаСлужебный.РезультатРазрешенияЗависимости();
		Результат.Ошибка = "Скорректируйте параметры зависимости, асинхронная зависимость не может обрабатываться на сервере";
		ОбработатьРезультатРазрешенияЗависимости(Результат, Параметры);
		Возврат;
	КонецЕсли;
	
	Обработчик = Новый ОписаниеОповещения("ОбработатьРезультатРазрешенияЗависимости", ЭтотОбъект, Параметры);
	
	ИмяМетода = ОписаниеЗависимости.МетодРеализации;
	ПараметрыМетода = ЮТКоллекции.СкопироватьМассив(ОписаниеЗависимости.Параметры);
	ПараметрыМетода.Добавить(Обработчик);
	
	Ошибка = ЮТМетодыСлужебный.ВыполнитьМетод(ИмяМетода, ПараметрыМетода);
	
	Если Ошибка <> Неопределено Тогда
		Результат = ЮТФабрикаСлужебный.РезультатРазрешенияЗависимости();
		Результат.Ошибка = Ошибка;
		ОбработатьРезультатРазрешенияЗависимости(Результат, Параметры);
	КонецЕсли;
	
КонецПроцедуры

Процедура РазрешитьЗависимость(_, Параметры) Экспорт
	
	ОписаниеЗависимости = Параметры.ОписаниеЗависимости;
	
	Попытка
		Если ОписаниеЗависимости.ОбработкаНаСервере Тогда
			Результат = ЮТЗависимостиСлужебныйВызовСервера.РазрешитьЗависимость(ОписаниеЗависимости);
		Иначе
			Результат = ЮТМетодыСлужебный.ВызватьФункцию(ОписаниеЗависимости.МетодРеализации, ОписаниеЗависимости.Параметры, Ложь);
		КонецЕсли;
	Исключение
		
		Результат = ЮТФабрикаСлужебный.РезультатРазрешенияЗависимости();
		Результат.Ошибка = ИнформацияОбОшибке();
		
	КонецПопытки;
	
	ОбработатьРезультатРазрешенияЗависимости(Результат, Параметры);
	
КонецПроцедуры

Процедура ОбработатьРезультатРазрешенияЗависимости(Результат, Параметры) Экспорт
	
	ОписаниеЗависимости = Параметры.ОписаниеЗависимости;
	
	ПредставлениеЗависимости = ЮТЗависимостиСлужебный.ПредставлениеЗависимости(ОписаниеЗависимости);
	ЮТЛогирование.Отладка("Обработка зависимостей: сохранение результата обработки зависимости " + ПредставлениеЗависимости);
	
	Если НЕ Результат.Успешно Тогда
		Сообщение = СтрШаблон("Не удалось разрешить зависимость `%1`", ПредставлениеЗависимости);
		Результат.Ошибка = ОписаниеОшибкиПропуска(Сообщение, Результат.Ошибка);
		ЮТЛогирование.Ошибка(Результат.Ошибка.Сообщение);
	КонецЕсли;
	
	СохранитьРезультатРазрешенияЗависимости(ОписаниеЗависимости, Результат);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(Параметры.ПараметрыИсполнения);
	
	ЮТЛогирование.Отладка("Обработка зависимостей: завершена обработка зависимости " + ПредставлениеЗависимости);
	
КонецПроцедуры

Процедура СохранитьРезультатРазрешенияЗависимости(ОписаниеЗависимости, Результат) Экспорт
	
	ИмяДанныеЗависимостей = ЮТЗависимостиСлужебный.ИмяКонтекстаДанныеЗависимостей();
	ИмяРазрешенныеЗависимости = ЮТЗависимостиСлужебный.ИмяКонтекстаРазрешенныеЗависимости();
	
	Результат.ДоступностьНаКлиенте = ОписаниеЗависимости.ДоступностьНаКлиенте;
	Результат.ДоступностьНаСервере = ОписаниеЗависимости.ДоступностьНаСервере;
	
	КонтекстРазрешенныеЗависимости = ЮТЗависимостиСлужебный.КонтекстРазрешенныеЗависимости();
	КонтекстРазрешенныеЗависимости.Вставить(ОписаниеЗависимости.Ключ, Результат);
	
	ПередаваемыеЗначения = Новый Соответствие();
	ПередаваемыеЗначения.Вставить(ОписаниеЗависимости.Ключ, Результат);
	
	ЮТКонтекстСлужебный.ВставитьЗначениеКонтекста(ИмяРазрешенныеЗависимости, ПередаваемыеЗначения);
	ЮТКонтекстСлужебный.ВставитьЗначениеКонтекста(ИмяРазрешенныеЗависимости, ПередаваемыеЗначения, Истина);
	
	Если Результат.СохраняемыйКонтекст <> Неопределено Тогда
		
		ПередаваемыеЗначения.Вставить(ОписаниеЗависимости.Ключ, Результат.СохраняемыйКонтекст);
		ЮТКонтекстСлужебный.ВставитьЗначениеКонтекста(ИмяДанныеЗависимостей, ПередаваемыеЗначения);
		ЮТКонтекстСлужебный.ВставитьЗначениеКонтекста(ИмяДанныеЗависимостей, ПередаваемыеЗначения, Истина);
		
	КонецЕсли;
	
	Если Результат.СохраняемыйКонтекстСервер <> Неопределено Тогда
		
		ПередаваемыеЗначения.Вставить(ОписаниеЗависимости.Ключ, Результат.СохраняемыйКонтекстСервер);
		ЮТКонтекстСлужебный.ВставитьЗначениеКонтекста(ИмяДанныеЗависимостей, ПередаваемыеЗначения, Истина);
		
	КонецЕсли;
	
	Если Результат.СохраняемыйКонтекстКлиент <> Неопределено Тогда
		
		ПередаваемыеЗначения.Вставить(ОписаниеЗависимости.Ключ, Результат.СохраняемыйКонтекстКлиент);
		ЮТКонтекстСлужебный.ВставитьЗначениеКонтекста(ИмяДанныеЗависимостей, ПередаваемыеЗначения);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеОбработкиЗависимостей(_, ПараметрыИсполнения) Экспорт
	
	РазрешенныеЗависимости = ЮТЗависимостиСлужебный.КонтекстРазрешенныеЗависимости();
	Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	
	Для Каждого ТестовыйМодуль Из ПараметрыИсполнения.ТестовыеМодули Цикл
		РезультатРазрешенияЗависимостей = ПроверкаРазрешенныхЗависимостей(ТестовыйМодуль, РазрешенныеЗависимости);
		
		Если НЕ РезультатРазрешенияЗависимостей.Успешно Тогда
			УстановитьОшибкиВ(ТестовыйМодуль.НаборыТестов, РезультатРазрешенияЗависимостей.Ошибка);
			Прервать;
		КонецЕсли;
		
		Для Каждого Набор Из ТестовыйМодуль.НаборыТестов Цикл
			
			РезультатРазрешенияЗависимостей = ПроверкаРазрешенныхЗависимостей(Набор, РазрешенныеЗависимости);
			
			Если НЕ РезультатРазрешенияЗависимостей.Успешно Тогда
				УстановитьОшибкиВ(Набор.Тесты, РезультатРазрешенияЗависимостей.Ошибка);
				Набор.Ошибки.Добавить(РезультатРазрешенияЗависимостей.Ошибка);
				Набор.Выполнять = Ложь;
				Продолжить;
			КонецЕсли;
			
			Для Каждого Тест Из Набор.Тесты Цикл
				РезультатРазрешенияЗависимостей = ПроверкаРазрешенныхЗависимостей(Тест, РазрешенныеЗависимости);
				
				Если НЕ РезультатРазрешенияЗависимостей.Успешно Тогда
					Тест.Ошибки.Добавить(РезультатРазрешенияЗависимостей.Ошибка);
					Тест.Статус = Статусы.Пропущен;
				КонецЕсли;
			КонецЦикла;
			
		КонецЦикла;
	КонецЦикла;
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Функция ОписаниеОшибкиПропуска(Описание, ИнформацияОбОшибке = Неопределено)
	
	Ошибка = ЮТФабрикаСлужебный.ОписаниеОшибкиПропуска(Описание);
	
	Если ИнформацияОбОшибке = Неопределено Тогда
		Возврат Ошибка;
	КонецЕсли;
	
	ТипОшибки = ТипЗнч(ИнформацияОбОшибке);
	
	Если ТипОшибки = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(Ошибка, ИнформацияОбОшибке, , "ТипОшибки, Сообщение");
		Ошибка.Сообщение = ЮТСтроки.ДобавитьСтроку(Описание, ИнформацияОбОшибке.Сообщение, Символы.ПС);
	ИначеЕсли ТипОшибки = Тип("ИнформацияОбОшибке") Тогда
		Ошибка.Стек = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке);
	ИначеЕсли ТипОшибки = Тип("Строка") Тогда
		Ошибка.Сообщение = ЮТСтроки.ДобавитьСтроку(Описание, ИнформацияОбОшибке, Символы.ПС);
	КонецЕсли;
	
	Возврат Ошибка;
	
КонецФункции

Функция УстановитьОшибкиВ(Объекты, Ошибка)
	
	Для Каждого Объект Из Объекты Цикл
		Объект.Ошибки.Добавить(Ошибка);
		Объект.Выполнять = Ложь;
	КонецЦикла;
	
	Возврат Ошибка;
	
КонецФункции

Функция ПроверкаРазрешенныхЗависимостей(Объект, РазрешенныеЗависимости)
	
	Для Каждого ОписаниеЗависимости Из Объект.Зависимости Цикл
		Результат = РазрешенныеЗависимости[ОписаниеЗависимости.Ключ];
		
		Если Результат = Неопределено Тогда
			Результат = ЮТФабрикаСлужебный.РезультатРазрешенияЗависимости();
			ПредставлениеЗависимости = ЮТЗависимостиСлужебный.ПредставлениеЗависимости(ОписаниеЗависимости);
			Сообщение = СтрШаблон("Нет информации о зависимости `%1`, что-то пошло не так", ПредставлениеЗависимости);
			Результат.Ошибка = ОписаниеОшибкиПропуска(Сообщение);
		КонецЕсли;
		
		Если НЕ Результат.Успешно Тогда
			Возврат Результат;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Новый Структура("Успешно", Истина);
	
КонецФункции

#КонецОбласти

Процедура ДедупликацияЗависимостейОбъекта(Зависимости, Объект)
	
	Для Инд = 0 По Объект.Зависимости.ВГраница() Цикл
		Объект.Зависимости[Инд] = ЮТЗависимостиСлужебный.УникальнаяЗависимость(Зависимости, Объект.Зависимости[Инд]);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
