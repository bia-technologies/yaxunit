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

#Область ПрограммныйИнтерфейс

// Возвращает внешнюю компоненту, реализующую паузу
// Предоставляет метод `Ожидать`, `Sleep`
// 
// Возвращаемое значение:
//  ВнешнийОбъект
Функция Пауза() Экспорт
	
	Возврат СоздатьКомпоненту(ОписаниеКомпонентыСервисногоНазначения(), Истина);
	
КонецФункции

// Возвращает внешнюю компоненту, реализующую вывод в консоль
// Предоставляет метод `Напечатать`, `Print`
// 
// Возвращаемое значение:
//  ВнешнийОбъект
Функция Консоль() Экспорт
	
	Возврат СоздатьКомпоненту(ОписаниеКомпонентыСервисногоНазначения(), Истина);
	
КонецФункции

// Возвращает внешнюю компоненту, реализующую функциональность регулярных выражений
// Подробнее с документацией можно ознакомиться по ссылке: https://github.com/alexkmbk/RegEx1CAddin
//
// Возвращаемое значение:
//  ВнешнийОбъект
Функция РегулярныеВыражения() Экспорт
	
#Если НЕ Сервер Тогда
	Если НЕ ЮТМетаданные.РазрешеныСинхронныеВызовы() Тогда
		ВызватьИсключение "Компонента регулярных выражений не доступна на клиенте при отключении синхронных вызовов";
	КонецЕсли;
#КонецЕсли
	
	Компонента = СоздатьКомпоненту(ОписаниеКомпонентыРегулярныхВыражений());
	Компонента.ВызыватьИсключения = Истина;
	Возврат Компонента;

КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Создает внешнюю компоненту по описанию
// 
// Параметры:
//  ОписаниеКомпоненты - см. ОписаниеКомпоненты
//  Кэшировать - Булево - Кэшировать созданную компоненту
// 
// Возвращаемое значение:
//  ВнешнийОбъект
Функция СоздатьКомпоненту(ОписаниеКомпоненты, Кэшировать = Ложь) Экспорт
	
	Если Кэшировать Тогда
		Возврат ЮТСлужебныйПовторногоИспользования.СоздатьКомпоненту(ОписаниеКомпоненты);
	КонецЕсли;
	
#Если Сервер Тогда
	Подключена = ПодключитьКомпоненту(ОписаниеКомпоненты.ИмяМакета, ОписаниеКомпоненты.ИмяКомпоненты, Истина);
#Иначе
	Если ЮТМетаданные.РазрешеныСинхронныеВызовы() Тогда
		Подключена = ПодключитьКомпоненту(ОписаниеКомпоненты.ИмяМакета, ОписаниеКомпоненты.ИмяКомпоненты, Истина);
	Иначе
		Подключена = Истина; // Подключены при старте системы
	КонецЕсли;
#КонецЕсли
	
	Если Подключена Тогда
		Возврат Новый (ОписаниеКомпоненты.ИмяКласса);
	Иначе
		ВызватьИсключение "Не удалось подключить внешнюю компоненту " + ОписаниеКомпоненты.ИмяКласса;
	КонецЕсли;
	
КонецФункции

// Подключает внешнюю компоненту из макета
// 
// Параметры:
//  ИмяМакета - Строка - Имя макета, в котором хранится компонента
//  ИмяКомпоненты - Строка - Имя компоненты
//  Кэшировать - Булево - Кэшировать создание компоненты
// 
// Возвращаемое значение:
//  Булево - Успешность подключения
Функция ПодключитьКомпоненту(ИмяМакета, ИмяКомпоненты, Кэшировать) Экспорт
	
	Если Кэшировать Тогда
		Возврат ЮТСлужебныйПовторногоИспользования.ПодключитьКомпоненту(ИмяМакета, ИмяКомпоненты);
	КонецЕсли;
	
	Если ЮТСтроки.ВерсияБольше(ЮТОкружение.ВерсияПлатформы(), "8.3.20") Тогда
		ТипПодключения = ЮТМетодыСлужебный.ВычислитьБезопасно("ТипПодключенияВнешнейКомпоненты.НеИзолированно");
		//@skip-check many-actual-parameters
		Возврат ПодключитьВнешнююКомпоненту(ИмяМакета, ИмяКомпоненты, ТипВнешнейКомпоненты.Native, ТипПодключения);
	Иначе
		Возврат ПодключитьВнешнююКомпоненту(ИмяМакета, ИмяКомпоненты, ТипВнешнейКомпоненты.Native);
	КонецЕсли;
	
КонецФункции

// Описание компоненты, реализующей паузу, консоль и другие
// 
// Возвращаемое значение:
//  см. ОписаниеКомпоненты
Функция ОписаниеКомпонентыСервисногоНазначения() Экспорт
	
	Возврат ОписаниеКомпоненты("ОбщийМакет.ЮТYaxUnitAddIn", "YaxUnitAddin", "Common");
	
КонецФункции

// Описание компоненты реализующей функциональность регулярных выражений.
//
// Возвращаемое значение:
//  см. ОписаниеКомпоненты
Функция ОписаниеКомпонентыРегулярныхВыражений() Экспорт

	Возврат ОписаниеКомпоненты("ОбщийМакет.ЮТRegEx1CAddin", "RegEx1CAddin", "RegEx");

КонецФункции

// Описание внешней компоненты.
// 
// Параметры:
//  ИмяМакета - Строка - Имя макета, в котором хранится компонента
//  ИмяКомпоненты - Строка -Имя компоненты
//  ИмяКласса - Строка - Имя класса, по которому создается компонента
// 
// Возвращаемое значение:
//  Структура - Описание компоненты:
// * ИмяМакета - Строка - Имя макета, в котором хранится компонента
// * ИмяКомпоненты - Строка -Имя компоненты
// * ИмяКласса - Строка - Имя класса
Функция ОписаниеКомпоненты(ИмяМакета, ИмяКомпоненты, ИмяКласса) Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("ИмяМакета", ИмяМакета);
	Описание.Вставить("ИмяКомпоненты", ИмяКомпоненты);
	Описание.Вставить("ИмяКласса", СтрШаблон("AddIn.%1.%2", ИмяКомпоненты, ИмяКласса));
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти
