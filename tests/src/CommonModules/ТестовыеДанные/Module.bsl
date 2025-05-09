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

Функция РезультатТестирования() Экспорт
	
	Результат = Новый Массив();
	Модуль = ОписаниеТестовогоМодуля();
	Набор = ОписаниеТестовогоНабора(Модуль);
	Тест = ОписаниеТеста(Модуль, Набор);
	Набор.Тесты.Добавить(Тест);
	Модуль.НаборыТестов.Добавить(Набор);
	Результат.Добавить(Модуль);
	
	Возврат Результат;
	
КонецФункции

Функция ОписаниеТестовогоМодуля(ИмяМодуля = Неопределено) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Метаданные", ЮТФабрика.ОписаниеМетаданныеМодуля());
	Описание.Вставить("НаборыТестов", Новый Массив);
	Описание.Вставить("Ошибки", Новый Массив);
	Описание.Вставить("НастройкиВыполнения", Новый Структура);
	Описание.Вставить("Теги", Новый Массив());
	Описание.Вставить("СвойстваОтчета", Новый Соответствие);
	Описание.Вставить("СвойстваAllure", Новый Соответствие);
	
	Описание.Метаданные.Имя = СлучайнаяСтрокаЕслиНеопределено(ИмяМодуля);
	
	Возврат Описание;
	
КонецФункции

Функция ОписаниеТестовогоНабора(ТестовыйМодуль, ИмяНабора = Неопределено, ПредставлениеНабора = Неопределено) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Имя", СлучайнаяСтрокаЕслиНеопределено(ИмяНабора));
	Описание.Вставить("Представление", СлучайнаяСтрокаЕслиНеопределено(ПредставлениеНабора));
	Описание.Вставить("Теги", Новый Массив());
	Описание.Вставить("Ошибки", Новый Массив());
	Описание.Вставить("Режим", "");
	Описание.Вставить("Тесты", Новый Массив);
	Описание.Вставить("Выполнять", Истина);
	Описание.Вставить("ДатаСтарта", 0);
	Описание.Вставить("Длительность", 0);
	Описание.Вставить("НастройкиВыполнения", Новый Структура);
	Описание.Вставить("СвойстваОтчета", Новый Соответствие);
	Описание.Вставить("СвойстваAllure", Новый Соответствие);
	
	Возврат Описание;
	
КонецФункции

Функция ОписаниеТеста(Модуль, Набор) Экспорт
	
	ИмяМетода = ЮТТестовыеДанные.СлучайнаяСтрока();
	
	Представление = ИмяМетода + "()";
	
	ОписаниеТеста = Новый Структура;
	ОписаниеТеста.Вставить("Имя", Представление);
	ОписаниеТеста.Вставить("Метод", ИмяМетода);
	ОписаниеТеста.Вставить("Теги", Новый Массив);
	ОписаниеТеста.Вставить("Режим", Набор.Режим);
	ОписаниеТеста.Вставить("ДатаСтарта", 0);
	ОписаниеТеста.Вставить("Длительность", 0);
	ОписаниеТеста.Вставить("Статус", "Ожидание");
	ОписаниеТеста.Вставить("Ошибки", Новый Массив);
	ОписаниеТеста.Вставить("НастройкиВыполнения", Новый Структура);
	ОписаниеТеста.Вставить("Параметры", Новый Массив);
	ОписаниеТеста.Вставить("НомерВНаборе", 0);
	ОписаниеТеста.Вставить("СвойстваОтчета", Новый Соответствие);
	ОписаниеТеста.Вставить("СвойстваAllure", Новый Соответствие);
	
	Возврат ОписаниеТеста;
	
КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СлучайнаяСтрокаЕслиНеопределено(Значение)
	
	Если Значение = Неопределено Тогда
		Возврат ЮТТестовыеДанные.СлучайнаяСтрока();
	КонецЕсли;
	
	Возврат Значение;
	
КонецФункции
#КонецОбласти
