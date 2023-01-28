//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2022 BIA-Technologies Limited Liability Company
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

///////////////////////////////////////////////////////////////////
// ПрограммныйИнтерфейс
// Экспортные процедуры и функции для прикладного использования 
/////////////////////////////////////////////////////////////////// 

#Область ПрограммныйИнтерфейс

// СоздатьЭлемент
//  Создает новый элемент и возвращает его ссылку 
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Наименование - Строка, Неопределено - Наименование элемента
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданный объект
Функция СоздатьЭлемент(Знач Менеджер, Знач Наименование = Неопределено, Знач Реквизиты = Неопределено) Экспорт
	
	Если ТипЗнч(Менеджер) = Тип("Строка") Тогда
		Менеджер = Вычислить(Менеджер);
	КонецЕсли;
	
	Объект = Менеджер.СоздатьЭлемент();
	
	Если ЗначениеЗаполнено(Наименование) Тогда
		Объект.Наименование = Наименование;
	ИначеЕсли Объект.Метаданные().ДлинаНаименования > 0 Тогда
		Объект.Наименование = ЮТТестовыеДанные.УникальнаяСтрока();
	КонецЕсли;
	
	Если Реквизиты <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Объект, Реквизиты);
	КонецЕсли;
	
	Объект.Записать();
	
	Возврат Объект.Ссылка;
	
КонецФункции

// СоздатьДокумент
//  Создает новый документ и возвращает его ссылку 
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
//	ДанныеТабличныхЧастей - Структура, Неопределено - Содержит данные
//							для заполнения табличных частей документа.
//							Ключ - наименование табличной части,
//							Значение - таблица значений, которая
//							будет загружена в табличную часть.
// 
// Возвращаемое значение:
//  ДокументСсылка - Ссылка на созданный объект
Функция СоздатьДокумент(Знач Менеджер, Знач Реквизиты = Неопределено, Знач ДанныеТабличныхЧастей = Неопределено) Экспорт
	
	РежимЗаписи = РежимЗаписиДокумента.Запись;
	
	Если ТипЗнч(Менеджер) = Тип("Строка") Тогда
		Менеджер = Вычислить(Менеджер);
	КонецЕсли;
	
	Объект = Менеджер.СоздатьДокумент();
	Объект.Дата = ТекущаяДатаСеанса();
	Объект.УстановитьНовыйНомер();
	
	Если Реквизиты <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Объект, Реквизиты);
		РежимЗаписи = ЮТОбщий.ЗначениеСтруктуры(Реквизиты, "РежимЗаписи", РежимЗаписи);
	КонецЕсли;

	Если ДанныеТабличныхЧастей <> Неопределено Тогда
		Для каждого ЭлементДанных Из ДанныеТабличныхЧастей Цикл
			Объект[ЭлементДанных.Ключ].Загрузить(ЭлементДанных.Значение);
		КонецЦикла;
	КонецЕсли;
	
	Объект.Записать(РежимЗаписи);
	
	Возврат Объект.Ссылка;
	
КонецФункции

#КонецОбласти
/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
