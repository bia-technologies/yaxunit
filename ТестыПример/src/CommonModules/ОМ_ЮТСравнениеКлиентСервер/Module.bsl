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
// Экспортные процедуры и функции, предназначенные для использования другими 
// объектами конфигурации или другими программами
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	Массив = ЮТОбщий.ЗначениеВМассиве(1, 2, "3");
	Структура = Новый Структура("Строка, Число, Массив", "1", 1, Массив);
	Соответствие = Новый Соответствие();
	Соответствие.Вставить("Строка", "1");
	Соответствие.Вставить(2, "Число");
	Соответствие.Вставить("Массив", Массив);
	
	КопияМассива = СоздатьКопию(Массив);
	КопияМассива.Добавить(1);
	
	КопияСтруктуры = СоздатьКопию(Структура);
	КопияСтруктуры.Вставить("Новый", 8);
	КопияСтруктуры2 = СоздатьКопию(Структура);
	КопияСтруктуры2.Строка = 1;
	
	КопияСоответствия = СоздатьКопию(Соответствие);
	КопияСоответствия.Вставить("Новый", 8);
	КопияСоответствия2 = СоздатьКопию(Соответствие);
	КопияСоответствия2.Вставить("Строка", 1);
	
	ЮТТесты
		.ДобавитьТест("ЗначенияРавны")
			.СПараметрами(1)
			.СПараметрами("1")
			.СПараметрами(Истина)
			.СПараметрами(ТекущаяДата())
			.СПараметрами(Новый УникальныйИдентификатор())
			.СПараметрами(Массив)
			.СПараметрами(Структура)
			.СПараметрами(Соответствие)
			.СПараметрами(Новый ФиксированнаяСтруктура(Структура))
			.СПараметрами(Новый ФиксированноеСоответствие(Соответствие))
			.СПараметрами(Новый ФиксированныйМассив(Массив))
			.СПараметрами(ПредопределенноеЗначение("Перечисление.PushУведомления.ИспользоватьВспомогательныйСервис"))
			.СПараметрами(ПредопределенноеЗначение("Справочник.ВидыЦен.Закупочная"))
		.ДобавитьТест("ЗначенияНеРавны")
			.СПараметрами(1, 2)
			.СПараметрами("1", 1)
			.СПараметрами(Массив, КопияМассива)
			.СПараметрами(Структура, КопияСтруктуры)
			.СПараметрами(Структура, КопияСтруктуры2)
			.СПараметрами(Соответствие, КопияСоответствия)
			.СПараметрами(Соответствие, КопияСоответствия2)
		.ДобавитьСерверныйТест("ЗначенияРавны_ТаблицаЗначений")
		.ДобавитьСерверныйТест("ЗначенияРавны_ХранилищеЗначений")
			.СПараметрами(Массив)
			.СПараметрами(Структура)
			.СПараметрами(Соответствие)
			.СПараметрами(Новый ФиксированнаяСтруктура(Структура))
			.СПараметрами(Новый ФиксированноеСоответствие(Соответствие))
			.СПараметрами(Новый ФиксированныйМассив(Массив))
	;
	
КонецПроцедуры

Процедура ЗначенияРавны(Значение) Экспорт
	
	Описание = Строка(ТипЗнч(Значение));
	Копия = СоздатьКопию(Значение);
	
	Результат = ЮТСравнениеКлиентСервер.ЗначенияРавны(Значение, Копия);
	ЮТест.ОжидаетЧто(Результат, Описание)
		.ЭтоИстина();
	
КонецПроцедуры

Процедура ЗначенияНеРавны(Значение1, Значение2) Экспорт
	
	Описание = Строка(ТипЗнч(Значение1));
	
	Результат = ЮТСравнениеКлиентСервер.ЗначенияРавны(Значение1, Значение2);
	ЮТест.ОжидаетЧто(Результат, Описание)
		.ЭтоЛожь();
	
	Результат = ЮТСравнениеКлиентСервер.ЗначенияРавны(Значение2, Значение1);
	ЮТест.ОжидаетЧто(Результат, Описание + ". Переменаа мест")
		.ЭтоЛожь();
	
КонецПроцедуры

#Если Сервер Тогда

Процедура ЗначенияРавны_ХранилищеЗначений(Значение) Экспорт
	
	Описание = Строка(ТипЗнч(Значение));
	Копия = СоздатьКопию(Значение);
	
	Алгоритм = Новый СжатиеДанных(1);
	Результат = ЮТСравнениеКлиентСервер.ЗначенияРавны(
		Новый ХранилищеЗначения(Значение, Алгоритм),
		Новый ХранилищеЗначения(Копия, Алгоритм));
	
	ЮТест.ОжидаетЧто(Результат, Описание)
		.ЭтоИстина();
	
КонецПроцедуры

Процедура ЗначенияРавны_ТаблицаЗначений() Экспорт
	
	Варианты = ЮТест.Варианты("Значение, Описание");
	
	Таблица = Новый ТаблицаЗначений();
	Варианты.Добавить(СоздатьКопию(Таблица), "Пустая таблица");
	
	Для Инд = 1 По ЮТест.Данные().СлучайноеЧисло(3, 9) Цикл
		Таблица.Колонки.Добавить("К" + Инд);
	КонецЦикла;
	Варианты.Добавить(СоздатьКопию(Таблица), "Пустая таблица с описанием колонок");
	
	Для Инд = 1 По ЮТест.Данные().СлучайноеЧисло(3, 9) Цикл
		
		Строка = Таблица.Добавить();
		Строка[0] = ЮТест.Данные().СлучайнаяДата();
		Строка[1] = ЮТест.Данные().СлучайноеЧисло();
		Строка[2] = ЮТест.Данные().СлучайноеБулево();
		Для Колонка = 3 По Таблица.Колонки.Количество() - 1 Цикл
			Строка[Колонка] = ЮТест.Данные().СлучайнаяСтрока();
		КонецЦикла;
		
	КонецЦикла;
	Варианты.Добавить(СоздатьКопию(Таблица), "Заполненная таблица");
	
	Для Каждого Вариант Из Варианты.СписокВариантов() Цикл
		
		Копия = СоздатьКопию(Вариант.Значение);
		
		Результат = ЮТСравнениеКлиентСервер.ЗначенияРавны(Вариант.Значение, Копия);
		ЮТест.ОжидаетЧто(Результат, Вариант.Описание)
			.ЭтоИстина();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецЕсли

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьКопию(Значение)
	
	Возврат ПомощникТестированияВызовСервера.СоздатьКопию(Значение);
	
КонецФункции

#КонецОбласти
