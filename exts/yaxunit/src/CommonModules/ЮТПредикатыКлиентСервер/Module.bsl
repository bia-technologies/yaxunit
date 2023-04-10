//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
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

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

// Проверить предикат.
// 
// Параметры:
//  Значение - Произвольный
//  Предикаты - Массив Из см. ЮТФабрика.ВыражениеПредиката
//  ПараметрыСообщенийОбОшибке - см. ПараметрыСообщенийОбОшибке
//  ПараметрыСравнения - Неопределено
//                     - Структура - Параметры сравнения значений, для разных выражений испльзуются свои параметры
// 
// Возвращаемое значение:
//  см. ЮТФабрика.ОписаниеРезультатаПроверки
Функция ПроверитьПредикаты(Знач Значение, Знач Предикаты, Знач ПараметрыСообщенийОбОшибке = Неопределено, ПараметрыСравнения = Неопределено) Экспорт
	
	Результат = ЮТФабрика.ОписаниеРезультатаПроверки();
	
	Если ПараметрыСообщенийОбОшибке = Неопределено Тогда
		ПараметрыСообщенийОбОшибке = ПараметрыСообщенийОбОшибке();
	КонецЕсли;
	
	Предикаты = НаборПредикатов(Предикаты);
	Для Каждого Выражение Из Предикаты Цикл
		
		ПроверитьВыражениеПредиката(Значение, Выражение, Результат, ПараметрыСообщенийОбОшибке, ПараметрыСравнения);
		Если НЕ Результат.Успешно Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Набор предикатов.
// 
// Параметры:
//  Предикаты - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор утверждений. см. ЮТПредикаты.Получить, см. ЮТест.Предикат
//            - см. ЮТФабрика.ВыражениеПредиката
//            - ОбщийМодуль.ЮТПредикаты - Модуль настройки предикатов, см. ЮТест.Предикат
// 
// Возвращаемое значение:
//  Массив из см. ЮТФабрика.ВыражениеПредиката - Набор предикатов
Функция НаборПредикатов(Знач Предикаты) Экспорт
	
	ТипПараметра = ТипЗнч(Предикаты);
	
	Если ТипПараметра = Тип("ОбщийМодуль") И Предикаты = ЮТПредикаты Тогда
		Результат = ЮТПредикаты.Получить();
	ИначеЕсли ТипПараметра = Тип("Массив") Тогда
		Результат = Предикаты;
	ИначеЕсли ТипПараметра = Тип("Структура") Тогда
		Результат = ЮТОбщий.ЗначениеВМассиве(Предикаты);
	Иначе
		ВызватьИсключение "Некорректный параметр метода `ЮТПредикатыКлиентСервер.НаборПредикатов`";
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПредставлениеПредикатов(Знач Предикаты, Разделитель) Экспорт
	
	Представления = Новый Массив();
	Предикаты = НаборПредикатов(Предикаты);
	Для Каждого Выражение Из Предикаты Цикл
		Представления.Добавить(ПредставлениеПредиката(Выражение));
	КонецЦикла;
	
	Возврат СтрСоединить(Представления, Разделитель);
	
КонецФункции

Функция ПредставлениеПредиката(ВыражениеПредиката) Экспорт
	
	Если ВыражениеПредиката.ИмяРеквизита = Неопределено Тогда
		ПроверяемоеЗначение = "";
	Иначе
		ПроверяемоеЗначение = СтрШаблон("содержит свойство `%1`, которое ", ВыражениеПредиката.ИмяРеквизита);
	КонецЕсли;
	
	Выражение = СтрШаблон(ШаблонВыражения(ВыражениеПредиката.ВидСравнения), ВыражениеПредиката.Значение);
	
	Возврат СтрШаблон("%1%2", ПроверяемоеЗначение, Выражение);
	
КонецФункции

Функция ШаблонВыражения(Знач Выражение) Экспорт
	
	Отрицание = СтрНачинаетсяС(Выражение, "Не");
	Если Отрицание Тогда
		Выражение = Сред(Выражение, 3);
	КонецЕсли;
	
	Выражения = ЮТПредикаты.Выражения();
	
	Шаблон = Неопределено;
	Если Выражение = Выражения.Равно Тогда
		Шаблон = "равно `%1`";
	ИначеЕсли Выражение = Выражения.Заполнено Тогда
		Шаблон = "является заполненным";
	ИначеЕсли Выражение = Выражения.Больше Тогда
		Шаблон = "больше чем `%1`";
	ИначеЕсли Выражение = Выражения.БольшеРавно Тогда
		Шаблон = "больше или равно `%1`";
	ИначеЕсли Выражение = Выражения.Меньше Тогда
		Шаблон = "меньше чем `%1`";
	ИначеЕсли Выражение = Выражения.МеньшеРавно Тогда
		Шаблон = "меньше или равно `%1`";
	ИначеЕсли Выражение = Выражения.ИмеетТип Тогда
		Шаблон = "имеет тип `%1`";
	ИначеЕсли Выражение = Выражения.ИмеетДлину Тогда
		Шаблон = "имеет длину (размер) `%1`";
	ИначеЕсли Выражение = Выражения.ИмеетСвойство Тогда
		Шаблон = "содержит свойство `%1`";
	ИначеЕсли Выражение = Выражения.Содержит Тогда
		Шаблон = "содержит `%1`";
	Иначе
		ВызватьИсключение "Не описан шаблон сообщения для выражения предиката " + Выражение;
	КонецЕсли;
	
	Если Отрицание Тогда
		Шаблон = "не " + Шаблон;
	КонецЕсли;
	
	Возврат Шаблон;
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьВыражениеПредиката(Значение, Выражение, СтатусПроверки, БазовыеПараметрыПроверки, ПараметрыСравнения)
	
	Попытка
		ВызватьОбработчикПредиката(Значение, Выражение, СтатусПроверки, БазовыеПараметрыПроверки, ПараметрыСравнения);
	Исключение
		ЮТРегистрацияОшибок.ДобавитьОшибкуКРезультатуПроверки(СтатусПроверки, ИнформацияОбОшибке());
	КонецПопытки;
	
КонецПроцедуры

// Вычислить выражение предиката.
// 
// Параметры:
//  Значение - Произвольный - Значение
//  Выражение - см. ЮТФабрика.ВыражениеПредиката
//  СтатусПроверки - см. ЮТФабрика.ОписаниеРезультатаПроверки
//  БазовыеПараметрыПроверки - см. ПараметрыПроверки
//  ПараметрыСравнения - Неопределено
//                     - Структура - Параметры сравнения значений, для разных выражений испльзуются свои параметры
Процедура ВызватьОбработчикПредиката(Значение, Выражение, СтатусПроверки, БазовыеПараметрыПроверки, ПараметрыСравнения)
	
// BSLLS:CognitiveComplexity-off
	ВидыСравнения = ЮТПредикаты.Выражения();
	ПараметрыПроверки = ЮТСравнениеКлиентСервер.ПараметрыПроверки(Выражение.ВидСравнения, Значение, Выражение.ИмяРеквизита, Выражение.Значение, Ложь);
	ЗаполнитьЗначенияСвойств(ПараметрыПроверки, БазовыеПараметрыПроверки, "ОписаниеПроверки, ОбъектПроверки, ПредставлениеПроверяемогоЗначения");
	
	Если Выражение.ВидСравнения = ВидыСравнения.Равно Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьРавенствоЗначений(СтатусПроверки, ПараметрыПроверки, ПараметрыСравнения);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.НеРавно Тогда
		
		ПараметрыПроверки.Реверс = Истина;
		ЮТСравнениеКлиентСервер.ПроверитьРавенствоЗначений(СтатусПроверки, ПараметрыПроверки, ПараметрыСравнения);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.Заполнено Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьЗаполненность(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.НеЗаполнено Тогда
		
		ПараметрыПроверки.Реверс = Истина;
		ЮТСравнениеКлиентСервер.ПроверитьЗаполненность(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.Больше Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьНеравенство(СтатусПроверки, ПараметрыПроверки, Истина);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.БольшеРавно Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьНеравенство(СтатусПроверки, ПараметрыПроверки, Истина, , Истина);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.Меньше Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьНеравенство(СтатусПроверки, ПараметрыПроверки, , Истина);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.МеньшеРавно Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьНеравенство(СтатусПроверки, ПараметрыПроверки, , Истина, Истина);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.ИмеетТип Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьТипПараметра(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.НеИмеетТип Тогда
		
		ПараметрыПроверки.Реверс = Истина;
		ЮТСравнениеКлиентСервер.ПроверитьТипПараметра(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.ИмеетСвойство Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьНаличиеСвойства(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.НеИмеетСвойство Тогда
		
		ПараметрыПроверки.Реверс = Истина;
		ЮТСравнениеКлиентСервер.ПроверитьНаличиеСвойства(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.ИмеетДлину Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьДлину(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.НеИмеетДлину Тогда
		
		ПараметрыПроверки.Реверс = Истина;
		ЮТСравнениеКлиентСервер.ПроверитьДлину(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.Содержит Тогда
		
		ЮТСравнениеКлиентСервер.ПроверитьСодержит(СтатусПроверки, ПараметрыПроверки);
		
	ИначеЕсли Выражение.ВидСравнения = ВидыСравнения.НеСодержит Тогда
		
		ПараметрыПроверки.Реверс = Истина;
		ЮТСравнениеКлиентСервер.ПроверитьСодержит(СтатусПроверки, ПараметрыПроверки);
		
	Иначе
		
		ВызватьИсключение СтрШаблон("Неизвестное выражение предиката `%1`", Выражение.ВидСравнения);
		
	КонецЕсли;
// BSLLS:CognitiveComplexity-on
	
КонецПроцедуры

// Параметры сообщений об ошибке.
// 
// Параметры:
//  ОписаниеПроверки - Строка - Описание конкретной проверки
//  ОбъектПроверки - Строка - Человекочитаемое описание проверяемого значения
//  ПредставлениеПроверяемогоЗначения - Неопределено - Представление проверяемого значения
// 
// Возвращаемое значение:
//  Структура - Параметры сообщений об ошибке:
// * ОписаниеПроверки - Строка - Описание конкретной проверки
// * ОбъектПроверки - Строка - Человекочитаемое описание проверяемого значения
// * ПредставлениеПроверяемогоЗначения - Неопределено -
Функция ПараметрыСообщенийОбОшибке(ОписаниеПроверки = Неопределено,
								   ОбъектПроверки = "проверяемое значение",
								   ПредставлениеПроверяемогоЗначения = Неопределено) Экспорт
	
	Возврат Новый Структура("ОписаниеПроверки, ОбъектПроверки, ПредставлениеПроверяемогоЗначения",
							ОписаниеПроверки,
							ОбъектПроверки,
							ПредставлениеПроверяемогоЗначения);
	
КонецФункции

#КонецОбласти
