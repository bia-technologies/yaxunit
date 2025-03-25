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

Процедура ВыполнитьМодульноеТестирование() Экспорт
	
	Если НЕ ЮТПараметрыЗапускаСлужебный.ЕстьПараметрыЗапускаТестов() Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.АргументыЗапуска = ПараметрЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьПараметры");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикАнализПараметровЗапуска");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПодключитьКомпоненты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПодключитсяКСерверуВнешнегоУправления");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПослеФормированияИсполняемыхНаборовТестов");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикРазрешитьЗависимости");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикВыполнитьТестирование");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСохранитьОтчет");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСохранитьКодВозврата");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗавершить");
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ВыполнитьМодульноеТестированиеПоНастройке(ПараметрыЗапуска, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПослеФормированияИсполняемыхНаборовТестов");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикРазрешитьЗависимости");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикВыполнитьТестирование");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ВыполнитьТестовыеМодули(ПараметрыЗапуска, ИсполняемыеМодули, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	ПараметрыИсполнения.ИсполняемыеТестовыеМодули = ИсполняемыеМодули;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПослеФормированияИсполняемыхНаборовТестов");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикРазрешитьЗависимости");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикВыполнитьТестирование");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ЗагрузитьЗарегистрированныеТесты(ПараметрыЗапуска, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ЗагрузитьИсполняемыеТесты(ПараметрыЗапуска, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ВыполнитьТестыВременногоМодуля(ПараметрыЗапуска, ОписаниеМодуля, ИменаМетодов, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполненияТестовВременногоМодуля(ПараметрыЗапуска, ОписаниеМодуля, ИменаМетодов);
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСоздатьВнешнююОбработку");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьТестыВнешнейОбработки");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПослеФормированияИсполняемыхНаборовТестов");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикРазрешитьЗависимости");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикВыполнитьТестирование");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОписаниеВременногоМодуля() Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Текст", "");
	Описание.Вставить("ИмяМодуля", "");
	Описание.Вставить("КлиентУправляемое", Ложь);
	Описание.Вставить("КлиентОбычное", Ложь);
	Описание.Вставить("Сервер", Ложь);
	
	Возврат Описание;
	
КонецФункции

Функция ПараметрыИсполнения() Экспорт
	
	Параметры = ЮТАсинхроннаяОбработкаСлужебныйКлиент.ЦепочкаАсинхроннойОбработки();
	Параметры.Вставить("АргументыЗапуска");
	Параметры.Вставить("ПараметрыЗапуска");
	Параметры.Вставить("ИсполняемыеТестовыеМодули");
	Параметры.Вставить("РезультатыТестирования");
	
	Возврат Параметры;
	
КонецФункции

Функция ПараметрыИсполненияТестовВременногоМодуля(ПараметрыЗапуска, ОписаниеМодуля, ИменаМетодов)
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	ПараметрыИсполнения.Вставить("ИменаМетодов", ИменаМетодов);
	ПараметрыИсполнения.Вставить("ОписаниеМодуля", ОписаниеМодуля);
	ПараметрыИсполнения.Вставить("ИмяВнешнейОбработки", "");
	
	Возврат ПараметрыИсполнения;
	
КонецФункции

#Область ОбработчикиЦепочкиДействий

Процедура ОбработчикОшибки(ИнформацияОбОшибке, СтандартнаяОбработка, ДополнительныеПараметры) Экспорт
	
	// TODO Подумать надо ли и как реализовать нормально
	
КонецПроцедуры

Процедура ОбработчикЗагрузитьПараметры(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Загрузка параметров запуска");
	Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
	ЮТПараметрыЗапускаСлужебный.ПараметрыЗапуска(ДополнительныеПараметры.АргументыЗапуска, Обработчик);
	
КонецПроцедуры

Процедура ОбработчикАнализПараметровЗапуска(ПараметрыЗапуска, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Анализ параметров запуска");
	
	Если НЕ ПараметрыЗапуска.ВыполнятьМодульноеТестирование Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры.ПараметрыЗапуска = ПараметрыЗапуска;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработчикИнициализация(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Инициализация");
	ВыполнитьИнициализацию(ДополнительныеПараметры.ПараметрыЗапуска);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработчикЗагрузитьЗарегистрированныеТесты(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Загрузка тестовых сценариев");
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().ЗагрузкаТестов);
	
	Отказ = Ложь;
	ЮТСобытияСлужебный.ПередЧтениеСценариев(Отказ);
	
	Если Отказ Тогда
		ТестовыеМодули = Новый Массив;
	Иначе
		ТестовыеМодули = ЮТЧитательСлужебный.ЗагрузитьТесты(ДополнительныеПараметры.ПараметрыЗапуска);
		ЮТСобытияСлужебный.ПослеЧтенияСценариев(ТестовыеМодули);
	КонецЕсли;
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры, ТестовыеМодули);
	
КонецПроцедуры

Процедура ОбработчикСформироватьИсполняемыеТесты(ТестовыеМодули, ДополнительныеПараметры) Экспорт
	
	ИсполняемыеТестовыеМодули = Новый Массив;
	
	Для Каждого ТестовыйМодуль Из ТестовыеМодули Цикл
		ИсполняемыйТестовыйМодуль = ЮТИсполнительСлужебныйКлиентСервер.ИсполняемыйТестовыйМодуль(ТестовыйМодуль);
		ИсполняемыеТестовыеМодули.Добавить(ИсполняемыйТестовыйМодуль);
	КонецЦикла;
	
	ДополнительныеПараметры.ИсполняемыеТестовыеМодули = ИсполняемыеТестовыеМодули;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры, ИсполняемыеТестовыеМодули);
	
КонецПроцедуры

Процедура ОбработчикПослеФормированияИсполняемыхНаборовТестов(_, ДополнительныеПараметры) Экспорт
	
	ЮТСобытияСлужебный.ПослеФормированияИсполняемыхНаборовТестов(ДополнительныеПараметры.ИсполняемыеТестовыеМодули);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработчикРазрешитьЗависимости(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Разрешение зависимостей");
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().РазрешениеЗависимостей);
	Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
	
	ЮТЗависимостиСлужебныйКлиент.РазрешитьЗависимости(ДополнительныеПараметры.ИсполняемыеТестовыеМодули, Обработчик);
	
КонецПроцедуры

Процедура ОбработчикВыполнитьТестирование(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Выполнение тестовых сценариев");
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().ПрогонТестов);
	ЮТИсполнительСлужебныйВызовСервера.СохранитьИнформациюОТестовыхСценариях(ДополнительныеПараметры.ИсполняемыеТестовыеМодули);
	
	РезультатыТестирования = Новый Массив();
	Отказ = Ложь;
	ЮТСобытияСлужебный.ПередВыполнениемТестов(ДополнительныеПараметры.ИсполняемыеТестовыеМодули, Отказ);
	
	Если НЕ Отказ Тогда
		
		Для Каждого ТестовыйМодуль Из ДополнительныеПараметры.ИсполняемыеТестовыеМодули Цикл
			
			РезультатыПрогонаМодуля = ВыполнитьТестыМодуля(ТестовыйМодуль);
			РезультатыТестирования.Добавить(РезультатыПрогонаМодуля);
			
		КонецЦикла;
		
		ЮТСобытияСлужебный.ПослеВыполненияТестов(РезультатыТестирования);
		
	КонецЕсли;
	
	ДополнительныеПараметры.РезультатыТестирования = РезультатыТестирования;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры, РезультатыТестирования);
	
КонецПроцедуры

Процедура ОбработчикСохранитьОтчет(_, ДополнительныеПараметры) Экспорт
	
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().ФормированиеОтчета);
	Если ЗначениеЗаполнено(ДополнительныеПараметры.ПараметрыЗапуска.reportPath) Тогда
		ЮТЛогирование.Информация("Формирование отчета о тестировании");
		Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
		ЮТОтчетСлужебный.СформироватьОтчет(ДополнительныеПараметры.РезультатыТестирования, ДополнительныеПараметры.ПараметрыЗапуска, Обработчик);
	Иначе
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
//@skip-check doc-comment-parameter-section
Процедура ОбработчикСохранитьКодВозврата(_, ДополнительныеПараметры) Экспорт
	
	ЗаписатьКодВозврата(ДополнительныеПараметры.РезультатыТестирования, ДополнительныеПараметры.ПараметрыЗапуска);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
//@skip-check doc-comment-parameter-section
Процедура ОбработчикЗавершить(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Завершение работы YAxUnit");
	Параметры = ДополнительныеПараметры.ПараметрыЗапуска;
	ЮТКонтекстСлужебный.УдалитьКонтекст();
	
	Если Параметры.showReport Тогда
		ПоказатьОтчет(ДополнительныеПараметры.РезультатыТестирования, Параметры);
	ИначеЕсли Параметры.CloseAfterTests Тогда
		ПрекратитьРаботуСистемы(Ложь);
	КонецЕсли;
	
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
//@skip-check doc-comment-parameter-section
Процедура ОбработчикПодключитьКомпоненты(_, ДополнительныеПараметры) Экспорт
	
	Если ДополнительныеПараметры.ПараметрыЗапуска.ПодключатьВнешниеКомпоненты Тогда
		ЮТЛогирование.Информация("Подключение внешних компонент");
		Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
		ЮТКомпонентыСлужебныйКлиент.ТихаяУстановкаКомпонент(Обработчик);
	Иначе
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаОшибки(ТекстОшибки) Экспорт
	ВызватьИсключение ТекстОшибки;
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
//@skip-check doc-comment-parameter-section
Процедура ОбработчикСоздатьВнешнююОбработку(_, ПараметрыИсполнения) Экспорт
	
	ЮТЛогирование.Информация("Создание внешней обработки");
	ПараметрыИсполнения.ИмяВнешнейОбработки = ЮТИсполнительСлужебныйВызовСервера.СоздатьВнешнююОбработку(ПараметрыИсполнения.ОписаниеМодуля);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
//@skip-check doc-comment-parameter-section
Процедура ОбработчикЗагрузитьТестыВнешнейОбработки(_, ПараметрыИсполнения) Экспорт
	
	ЮТФильтрацияСлужебный.УстановитьКонтекст(Новый Структура("filter", Новый Структура("tests", ПараметрыИсполнения.ИменаМетодов)));
	
	ТестовыеМодули = Новый Массив;
	
	Если ПараметрыИсполнения.ОписаниеМодуля.Сервер Тогда
		Сценарии = ЮТИсполнительСлужебныйВызовСервера.СценарииВнешнейОбработки(ПараметрыИсполнения.ИмяВнешнейОбработки, ПараметрыИсполнения.ОписаниеМодуля);
		ТестовыеМодули.Добавить(Сценарии);
	ИначеЕсли ПараметрыИсполнения.ОписаниеМодуля.КлиентОбычное Или ПараметрыИсполнения.ОписаниеМодуля.КлиентУправляемое Тогда
		Сценарии = ЮТИсполнительСлужебныйКлиентСервер.СценарииВнешнейОбработки(ПараметрыИсполнения.ИмяВнешнейОбработки, ПараметрыИсполнения.ОписаниеМодуля);
		ТестовыеМодули.Добавить(Сценарии);
	КонецЕсли;
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения, ТестовыеМодули);
	
КонецПроцедуры

//@skip-check bsl-variable-name-invalid
//@skip-check doc-comment-parameter-section
Процедура ОбработчикПодключитсяКСерверуВнешнегоУправления(_, ПараметрыИсполнения) Экспорт
	
	ПараметрыПодключения = ПараметрыИсполнения.ПараметрыЗапуска.rpc;
	Если ЗначениеЗаполнено(ПараметрыПодключения) И ЮТКоллекции.ЗначениеСтруктуры(ПараметрыПодключения, "enable") Тогда
		ЮТВнешнийЗапускТестовСлужебныйКлиент.ПодключитсяКСерверу(ПараметрыПодключения);
	КонецЕсли;
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

#КонецОбласти

Процедура ДобавитьОбработчикЦепочки(ПараметрыИсполнения, ИмяМетода)
	
	Обработчик = Новый ОписаниеОповещения(ИмяМетода, ЭтотОбъект, ПараметрыИсполнения, "ОбработчикОшибки", ЭтотОбъект);
	ПараметрыИсполнения.Цепочка.Добавить(Обработчик);
	
КонецПроцедуры

Процедура ПоказатьОтчет(РезультатыТестирования, Параметры)
	
	Данные = Новый Структура("РезультатыТестирования, ПараметрыЗапуска", РезультатыТестирования, Параметры);
	АдресДанных = ПоместитьВоВременноеХранилище(Данные, Новый УникальныйИдентификатор());
	
	ОткрытьФорму("Обработка.ЮТЮнитТесты.Форма.Основная", Новый Структура("АдресХранилища", АдресДанных));
	
КонецПроцедуры

// Записать код возврата.
// 
// Параметры:
//  РезультатыТестирования - Массив из см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
//  Параметры - см. ЮТФабрика.ПараметрыЗапуска
Процедура ЗаписатьКодВозврата(РезультатыТестирования, Параметры)
	
	Успешно = Истина;
	
	Если ПустаяСтрока(Параметры.exitCode) Тогда
		Возврат;
	КонецЕсли;
	
	ЮТЛогирование.Информация("Сохранение кода возврата в файл");
	Для Каждого Модуль Из РезультатыТестирования Цикл
		
		Для Каждого Набор Из Модуль.НаборыТестов Цикл
			
			Если РезультатТестаСодержитОшибки(Набор) Тогда
				Успешно = Ложь;
				Прервать;
			КонецЕсли;
			
			Для Каждого Тест Из Набор.Тесты Цикл
				
				Если РезультатТестаСодержитОшибки(Тест) Тогда
					Успешно = Ложь;
					Прервать;
				КонецЕсли;
				
			КонецЦикла;
			
			Если НЕ Успешно Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Если НЕ Успешно Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТИсполнительКлиент.ЗаписатьКодВозврата");
#Иначе
	Запись = Новый ЗаписьТекста(Параметры.exitCode, КодировкаТекста.UTF8);
	Запись.ЗаписатьСтроку(?(Успешно, 0, 1));
	Запись.Закрыть();
#КонецЕсли

КонецПроцедуры

Функция РезультатТестаСодержитОшибки(Тест)
	Результат = Ложь;
	
	Если НЕ ЗначениеЗаполнено(Тест.Ошибки) Тогда
		Возврат Результат;
	КонецЕсли;
	
	ТипОшибкиПропущен = ЮТФабрикаСлужебный.ТипыОшибок().Пропущен;
	Для Каждого ОписаниеОшибки Из Тест.Ошибки Цикл
		Если ОписаниеОшибки.ТипОшибки <> ТипОшибкиПропущен Тогда
			Результат = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Процедура ВыполнитьИнициализацию(ПараметрыЗапуска)
	
	ЮТЛогирование.Информация("Инициализация");
	ЮТКонтекстСлужебный.ИнициализироватьКонтекст(ПараметрыЗапуска);
	ЮТСобытияСлужебный.Инициализация(ПараметрыЗапуска);
	
	// Повторно сохраним для передачи на сервер
	ЮТКонтекстСлужебный.УстановитьГлобальныеНастройкиВыполнения(ЮТКонтекстСлужебный.ГлобальныеНастройкиВыполнения());
	ЮТСобытияСлужебный.ПослеИнициализации();
	
КонецПроцедуры

Функция ВыполнитьТестыМодуля(ТестовыйМодуль)
	
	МетаданныеМодуля = ТестовыйМодуль.Метаданные;
	ЮТЛогирование.Информация(СтрШаблон("Запуск тестов модуля `%1.%2`", МетаданныеМодуля.Расширение, МетаданныеМодуля.Имя));
	
	Наборы = НаборыТестовПоКонтекстам(ТестовыйМодуль);
	ТестовыйМодульОблегченный = ЮТКоллекции.СкопироватьСтруктуру(ТестовыйМодуль);
	ТестовыйМодульОблегченный.НаборыТестов = Новый Массив();
	
	РезультатыКлиентскихТестов = Неопределено;
	РезультатыСерверныхТестов = Неопределено;
	
	Если ЗначениеЗаполнено(Наборы.Клиентские) Тогда
		РезультатыКлиентскихТестов = ЮТИсполнительСлужебныйКлиентСервер.ВыполнитьГруппуНаборовТестов(Наборы.Клиентские,
																									 ТестовыйМодульОблегченный);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Наборы.Серверные) Тогда
		ИдентификаторТестовогоМодуля = ЮТИсполнительСлужебныйКлиентСервер.ИдентификаторТестовогоМодуля(ТестовыйМодуль);
		РезультатыСерверныхТестов = ЮТИсполнительСлужебныйВызовСервера.ВыполнитьГруппуНаборовТестов(Наборы.Серверные,
																									ИдентификаторТестовогоМодуля);
		ЮТЛогированиеСлужебный.ВывестиСерверныеСообщения();
	КонецЕсли;
	
	Если ЗначениеЗаполнено(РезультатыКлиентскихТестов) Тогда
		Результаты = РезультатыКлиентскихТестов;
	Иначе
		Результаты = Новый Массив();
	КонецЕсли;
	
	Если ЗначениеЗаполнено(РезультатыСерверныхТестов) Тогда
		ЮТКоллекции.ДополнитьМассив(Результаты, РезультатыСерверныхТестов);
	КонецЕсли;
	
	ЮТКоллекции.ДополнитьМассив(Результаты, Наборы.Пропущенные);
	
	ТестовыйМодульОблегченный.НаборыТестов = Результаты;
	
	Возврат ТестовыйМодульОблегченный;
	
КонецФункции

Функция НаборыТестовПоКонтекстам(ТестовыйМодуль)
	
	КонтекстыИсполнения = ЮТФабрика.КонтекстыИсполнения();
	
	КлиентскиеНаборы = Новый Массив();
	СерверныеНаборы = Новый Массив();
	ПропущенныеНаборы = Новый Массив();
	
	Для Каждого Набор Из ТестовыйМодуль.НаборыТестов Цикл
		
		Если НЕ Набор.Выполнять Тогда
			ПропущенныеНаборы.Добавить(Набор);
			Продолжить;
		КонецЕсли;
		
		РежимИсполнения = ЮТФабрикаСлужебный.КонтекстИсполнения(Набор.Режим);
		
		Если РежимИсполнения = КонтекстыИсполнения.Клиент Тогда
			КлиентскиеНаборы.Добавить(Набор);
		ИначеЕсли РежимИсполнения = КонтекстыИсполнения.Сервер Тогда
			ИдентификаторТестовогоНабора = ЮТИсполнительСлужебныйКлиентСервер.ИдентификаторТестовогоНабора(ТестовыйМодуль, Набор);
			СерверныеНаборы.Добавить(ИдентификаторТестовогоНабора);
		Иначе
			ПропущенныеНаборы.Добавить(Набор);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Новый Структура("Серверные, Клиентские, Пропущенные", СерверныеНаборы, КлиентскиеНаборы, ПропущенныеНаборы);
	
КонецФункции

#КонецОбласти
