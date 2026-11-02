//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2026 BIA-Technologies Limited Liability Company
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

// Параметры генерации отчета.
// Описывает предоставляемые модулем форматы отчетов.
//
// Возвращаемое значение:
//  Структура - см. ЮТФабрикаСлужебный.ПараметрыГенератораОтчета
//
// Пример:
//  Параметры = ЮТОтчетCTRFСлужебный.ПараметрыГенерацииОтчета();
Функция ПараметрыГенерацииОтчета() Экспорт
	
	Параметры = ЮТФабрикаСлужебный.ПараметрыГенератораОтчета();
	
	ОписаниеФормата = ЮТФабрикаСлужебный.ОписаниеФорматаОтчета("ctrf", "CTRF (json)");
	ОписаниеФормата.ИмяФайлаПоУмолчанию = "ctrf-report.json";
	ОписаниеФормата.ФильтрВыбораФайла = "CTRF (*.json)|*.json";
	Параметры.Форматы.Вставить(ОписаниеФормата.Идентификатор, ОписаниеФормата);
	
	Возврат Параметры;
	
КонецФункции

// Формирует отчет в формате CTRF (Common Test Report Format) версии 0.2.0.
//
// Параметры:
//  РезультатВыполнения - Массив из см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
//  Формат - см. ЮТФабрикаСлужебный.ОписаниеФорматаОтчета
//
// Возвращаемое значение:
//  ДвоичныеДанные - Данные отчета
Функция ДанныеОтчета(Знач РезультатВыполнения, Формат) Экспорт
	
	ВызватьИсключение "Не реализовано";
	
КонецФункции

#КонецОбласти
