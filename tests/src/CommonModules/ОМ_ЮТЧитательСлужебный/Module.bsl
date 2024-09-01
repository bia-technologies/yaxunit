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

Процедура ИсполняемыеСценарии() Экспорт
	
	Контекст = ЮТКонтекстСлужебный.ДанныеКонтекста();
	Если ЮТКоллекции.ЗначениеСтруктуры(Контекст, ИмяРеквизитаПроверки(), Ложь) Тогда
		ВызватьИсключение "Проверка чтения состава тестов";
	КонецЕсли;
	
	ЮТТесты
		.ДобавитьТест("ИсполняемыеСценарииМодуля")
		.ДобавитьТестовыйНабор("ЭтоТестовыйМодуль", "Параметризированный, 1,2")
			.ДобавитьТест("ЭтоТестовыйМодуль")
				.СПараметрами("ОМ_ЮТЧитательСлужебный", Истина)
				.СПараметрами("ОМ_ЮТУтверждения", Истина)
				.СПараметрами("ОМ_Мокито", Истина)
				.СПараметрами("ЮТЧитательСлужебный", Ложь)
		.ДобавитьТестовыйНабор("ЗагрузкаТестов")
			.ДобавитьКлиентскийТест("ЗагрузитьТесты")
		.ДобавитьТестовыйНабор("ИсполняемыеСценарииМодуляСОшибкойЧтения")
			.ДобавитьТест("ИсполняемыеСценарииМодуляСОшибкойЧтения")
	;
	
КонецПроцедуры

Процедура ЗагрузитьТесты() Экспорт
	
	ПараметрыЗапуска = ЮТФабрика.ПараметрыЗапуска();
	ПараметрыЗапуска.filter.extensions = Неопределено;
	ПараметрыЗапуска.filter.modules = ЮТКоллекции.ЗначениеВМассиве("ОМ_ЮТЧитательСлужебный");
	
	Наборы = ЮТЧитательСлужебный.ЗагрузитьТесты(ПараметрыЗапуска);
	ЮТест.ОжидаетЧто(Наборы, "Прочитанные наборы")
		.ИмеетТип("Массив")
		.ИмеетДлину(1);
	
	НаборМодуля = Наборы[0];
	
	ЮТест.ОжидаетЧто(НаборМодуля, "Набор тестов ОМ_ЮТЧитательСлужебный")
		.ИмеетТип("Структура")
		.Свойство("Метаданные").ИмеетТип("Структура")
		.Свойство("НаборыТестов").ИмеетТип("Массив");
	
	НаборыТестов = НаборМодуля.НаборыТестов;
	
	ЮТест.ОжидаетЧто(НаборыТестов, "Наборы тестов модуля")
		.ИмеетТип("Массив")
		.ИмеетДлину(4);
	
	ЮТест.ОжидаетЧто(НаборыТестов[0], "Набор тестов по умолчанию")
		.ИмеетТип("Структура")
		.Свойство("Имя").Равно("ОМ_ЮТЧитательСлужебный")
		.Свойство("Представление").Равно("ОМ_ЮТЧитательСлужебный")
		.Свойство("Ошибки").ИмеетТип("Массив").НеЗаполнено()
		.Свойство("Теги").ИмеетТип("Массив").НеЗаполнено()
		.Свойство("Тесты").ИмеетТип("Массив").ИмеетДлину(1);
	
	Тесты = НаборыТестов[0].Тесты;
	
	ЮТест.ОжидаетЧто(Тесты.Количество(), "Количество тестов модуля")
		.БольшеИлиРавно(1);
	
	ЮТест.ОжидаетЧто(Тесты[0], "Первый тест")
		.Свойство("Имя").Равно("ИсполняемыеСценарииМодуля")
		.Свойство("Представление").НеЗаполнено()
		.Свойство("Теги").Равно(Новый Массив())
		.Свойство("КонтекстВызова").Равно(ЮТКоллекции.ЗначениеВМассиве("КлиентУправляемоеПриложение"));
	
	ПараметрыЗапуска = ЮТФабрика.ПараметрыЗапуска();
	ПараметрыЗапуска.filter.extensions = ЮТКоллекции.ЗначениеВМассиве("tests");
	
	Наборы = ЮТЧитательСлужебный.ЗагрузитьТесты(ПараметрыЗапуска);
	ЮТест.ОжидаетЧто(Наборы, "Прочитанные наборы расширения tests")
		.ИмеетДлину(38);
	
КонецПроцедуры

Процедура ИсполняемыеСценарииМодуля() Экспорт
	
	МетаданныеМодуля = Новый Структура;
	МетаданныеМодуля.Вставить("Имя", "ОМ_ЮТЧитательСлужебный");
	МетаданныеМодуля.Вставить("КлиентУправляемоеПриложение", Истина);
	МетаданныеМодуля.Вставить("КлиентОбычноеПриложение", Истина);
	МетаданныеМодуля.Вставить("Клиент", Ложь);
	МетаданныеМодуля.Вставить("Сервер", Истина);
	МетаданныеМодуля.Вставить("ВызовСервера", Ложь);
	ТипКлиента = ?(ЮТест.Окружение().ОбычноеПриложение, "КлиентОбычноеПриложение", "КлиентУправляемоеПриложение");
	
	ЮТФильтрацияСлужебный.УстановитьКонтекст(Новый Структура("filter", Новый Структура));
	ОписаниеМодуля = ЮТЧитательСлужебный.ИсполняемыеСценарииМодуля(МетаданныеМодуля);
	
	ЮТест.ОжидаетЧто(ОписаниеМодуля, "ОписаниеМодуля")
		.ИмеетТип("Структура")
		.Свойство("НаборыТестов")
		.ИмеетДлину(4)
		.Элемент("НаборыТестов[0]").ИмеетТип("Структура")
		.Элемент("НаборыТестов[1]").ИмеетТип("Структура")
		.Элемент("НаборыТестов[2]").ИмеетТип("Структура")
	;
	Сценарии = ОписаниеМодуля.НаборыТестов;
	
	НаборПоУмолчанию = Сценарии[0];
	НаборЭтоТестовыйМодуль = Сценарии[1];
	НаборЗагрузкаТестов = Сценарии[2];
	
	ЮТест.ОжидаетЧто(НаборПоУмолчанию, "Набор по умолчанию")
		.Свойство("Имя").Равно("ОМ_ЮТЧитательСлужебный")
		.Свойство("Представление").Равно("ОМ_ЮТЧитательСлужебный")
		.Свойство("Теги").ИмеетДлину(0)
		.Свойство("Тесты").ИмеетДлину(1)
		.Свойство("Тесты[0].Имя").Равно("ИсполняемыеСценарииМодуля")
		.Свойство("Тесты[0].Представление").НеЗаполнено()
		.Свойство("Тесты[0].Теги").ИмеетДлину(0)
		.Свойство("Тесты[0].КонтекстВызова").Равно(ЮТКоллекции.ЗначениеВМассиве("Сервер", ТипКлиента))
	;
	
	ЮТест.ОжидаетЧто(НаборЗагрузкаТестов, "Набор 'ЗагрузкаТестов'")
		.Свойство("Имя").Равно("ЗагрузкаТестов")
		.Свойство("Тесты").ИмеетДлину(1)
		.Свойство("Тесты[0].Имя").Равно("ЗагрузитьТесты")
		.Свойство("Тесты[0].КонтекстВызова").Равно(ЮТКоллекции.ЗначениеВМассиве(ТипКлиента))
	;
	
	ЮТест.ОжидаетЧто(НаборЭтоТестовыйМодуль, "Набор 'ЭтоТестовыйМодуль'")
		.Свойство("Имя").Равно("ЭтоТестовыйМодуль")
		.Свойство("Тесты").ИмеетДлину(4)
		.Свойство("Теги").ИмеетДлину(3)
	;
	
КонецПроцедуры

Процедура ИсполняемыеСценарииМодуляСОшибкойЧтения() Экспорт
	ОписаниеМодуля = ЮТФабрикаСлужебный.ОписаниеМетаданныеМодуля();
	ОписаниеМодуля.Имя = "ОМ_ЮТЧитатель";
	ОписаниеМодуля.Расширение = "tests";
#Если Клиент Тогда
	ОписаниеМодуля.КлиентУправляемоеПриложение = Истина;
	ОписаниеМодуля.КлиентОбычноеПриложение = Истина;
#Иначе
	ОписаниеМодуля.Сервер = Истина;
#КонецЕсли
	
	ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста(ИмяРеквизитаПроверки(), Истина);
	
	Результат = ЮТЧитательСлужебный.ИсполняемыеСценарииМодуля(ОписаниеМодуля);
	ЮТест.ОжидаетЧто(Результат)
		.ИмеетТип("Структура")
		.Свойство("НаборыТестов").ИмеетДлину(1)
		.Свойство("НаборыТестов[0].Ошибки").ИмеетДлину(1)
		.Свойство("НаборыТестов[0].Ошибки[0].ТипОшибки").Равно(ЮТФабрикаСлужебный.ТипыОшибок().ЧтенияТестов)
	;
КонецПроцедуры

Процедура ЭтоТестовыйМодуль(ИмяМодуля, ЭтоТестовый) Экспорт
	
	ОписаниеМодуля = ЮТМетаданныеСлужебныйВызовСервера.МетаданныеМодуля(ИмяМодуля);
	ЮТест.ОжидаетЧто(ЮТЧитательСлужебный.ЭтоТестовыйМодуль(ОписаниеМодуля), "Проверка модуля " + ИмяМодуля)
		.Равно(ЭтоТестовый);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИмяРеквизитаПроверки()
	Возврат "ПроверкаЧтенияСоставаТестов";
КонецФункции

#КонецОбласти
