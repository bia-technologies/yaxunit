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

#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ДобавитьТест("ДобавитьСтроку")
		.ДобавитьТест("ОбъединитьВСтруктуру")
		.ДобавитьТест("СформироватьСтрокуСимволов")
		.ДобавитьТест("ДанныеСовпадают")
		.ДобавитьТест("Пауза")
	;
	
КонецПроцедуры

Процедура Пауза() Экспорт
	
	ЮТОбщий.Пауза(0.001);
	ЮТОбщий.Пауза(0.01);
	ЮТОбщий.Пауза(0.1);
	ЮТОбщий.Пауза(1);
	
КонецПроцедуры

Процедура ДобавитьСтроку() Экспорт
	
	Варианты = ЮТест.Варианты("Исходная, Дополнение, Разделитель, Результат")
		.Добавить("1", "2", "+", "1+2")
		.Добавить("", "2", "+", "2")
		.Добавить("1", "", "+", "1")
		.Добавить(Неопределено, "2", "+", "2")
		.Добавить("1", "2", Неопределено, "12")
		.СписокВариантов();
	
	Для Каждого Вариант Из Варианты Цикл
		
		Результат = ЮТОбщий.ДобавитьСтроку(Вариант.Исходная, Вариант.Дополнение, Вариант.Разделитель);
		
		Сообщение = СтрШаблон("ДобавитьСтроку(%1, %2, %3)", Вариант.Исходная, Вариант.Дополнение, Вариант.Разделитель);
		ЮТест.ОжидаетЧто(Результат, Сообщение).Равно(Вариант.Результат);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбъединитьВСтруктуру() Экспорт
	
	Варианты = ЮТест.Варианты("Описание, Исходная, Добавляемая, Результат")
		.Добавить("Структуры без пересечения",     "Строка, Число", "Дата",          "Строка, Число, Дата")
		.Добавить("Структуры с пересечением",      "Строка, Число", "Дата, Число",   "Строка, Число, Дата")
		.Добавить("Добавление пустой структуры",   "Строка, Число", "",              "Строка, Число")
		.Добавить("Добавление в пустую структуру", "",              "Строка, Число", "Строка, Число")
		.СписокВариантов();
	
	Для Каждого Вариант Из Варианты Цикл
		
		Для Режим = 1 По 3 Цикл
			
			ИсходнаяЭтоСоответствие = Режим = 1 ИЛИ Режим = 3;
			ДобавляемаяЭтоСоответствие = Режим = 2 ИЛИ Режим = 3;
			
			Исходная = СтруктураДляОбъединения(Вариант.Исходная, ИсходнаяЭтоСоответствие);
			Добавляемая = СтруктураДляОбъединения(Вариант.Добавляемая, ДобавляемаяЭтоСоответствие);
			
			Результат = ЮТОбщий.ОбъединитьВСтруктуру(Исходная, Добавляемая);
			
			ЮТест.ОжидаетЧто(Результат, Вариант.Описание)
				.Заполнено()
				.ИмеетТип("Структура");
			
			Для Каждого Ключ Из СтрРазделить(Вариант.Результат, ", ", Ложь) Цикл
				
				ЕстьКлюч = ДобавляемаяЭтоСоответствие И Добавляемая[Ключ] <> Неопределено
					ИЛИ НЕ ДобавляемаяЭтоСоответствие И Добавляемая.Свойство(Ключ);
				Если ЕстьКлюч Тогда
					ЮТУтверждения.Свойство(Ключ).Равно(Добавляемая[Ключ]);
				Иначе
					ЮТУтверждения.Свойство(Ключ).Равно(Исходная[Ключ]);
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СформироватьСтрокуСимволов() Экспорт
	
	Варианты = ЮТест.Варианты("Символ, Количество, Результат")
		.Добавить("1", 1, "1")
		.Добавить("12", 0, "")
		.Добавить("12", 2, "1212")
		.СписокВариантов();
		
	Для Каждого Вариант Из Варианты Цикл
		
		Результат = ЮТОбщий.СформироватьСтрокуСимволов(Вариант.Символ, Вариант.Количество);
		ЮТест.ОжидаетЧто(Результат, СтрШаблон("%1 * %2", Вариант.Символ, Вариант.Количество))
			.Равно(Вариант.Результат);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СтруктураДляОбъединения(КлючиСтрокой, Соответствие)
	
	Ключи = СтрРазделить(КлючиСтрокой, ", ", Ложь);
	
	Если Соответствие Тогда
		Результат = Новый Соответствие();
	Иначе
		Результат = Новый Структура();
	КонецЕсли;
	
	Для Каждого Ключ Из Ключи Цикл
		
		Если СтрСравнить(Ключ, "Число") Тогда
			Значение = ЮТест.Данные().СлучайноеЧисло();
		ИначеЕсли СтрСравнить(Ключ, "Дата") Тогда
			Значение = ЮТест.Данные().СлучайнаяДата();
		Иначе
			Значение = ЮТест.Данные().СлучайнаяСтрока();
		КонецЕсли;
		
		Результат.Вставить(Ключ, Значение);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Процедура ДанныеСовпадают() Экспорт
	
	Массив = ЮТОбщий.ЗначениеВМассиве(1, 2, "3");
	Структура = Новый Структура("Строка, Число, Массив", "1", 1, Массив);
	Соответствие = Новый Соответствие();
	Соответствие.Вставить("Строка", "1");
	Соответствие.Вставить(2, "Число");
	Соответствие.Вставить("Массив", Массив);
	
	Варианты = ЮТест.Варианты("Значение")
		.Добавить(Массив)
		.Добавить(Структура)
		.Добавить(Соответствие)
		.Добавить(Новый ФиксированныйМассив(Массив))
		.Добавить(Новый ФиксированнаяСтруктура(Структура))
		.Добавить(Новый ФиксированноеСоответствие(Соответствие))
		.СписокВариантов();
	
	Для Каждого Вариант Из Варианты Цикл
		
		Описание = Строка(ТипЗнч(Вариант.Значение));
		
		ЮТест.ОжидаетЧто(
				ЮТОбщий.ДанныеСовпадают(Вариант.Значение, Вариант.Значение),
				Описание)
			.ЭтоИстина();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
