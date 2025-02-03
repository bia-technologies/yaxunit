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

Процедура ПодключитсяКСерверу(ПараметрыПодключения) Экспорт
	
	Порт = ЮТКоллекции.ЗначениеСтруктуры(ПараметрыПодключения, "port", 0);
	КлючКлиента = ЮТКоллекции.ЗначениеСтруктуры(ПараметрыПодключения, "key", Неопределено);
	Транспорт = ЮТКоллекции.ЗначениеСтруктуры(ПараметрыПодключения, "transport", 0);
	
	Если СтрСравнить(Транспорт, "ws") <> 0 Тогда
		ВызватьИсключение "Неизвестный транспорт взаимодействия (`rpc.transport`) с 1С:EDT. Поддерживается `ws`";
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Порт) Тогда
		ВызватьИсключение "Не указан порт (`rpc.port`) для подключения к 1С:EDT";
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(КлючКлиента) Тогда
		ВызватьИсключение "Не указан ключ клиента (`rpc.key`) для подключения к 1С:EDT";
	КонецЕсли;
	
	АдресСервера = СтрШаблон("ws://localhost:%1", ЮТОбщий.ЧислоВСтроку(Порт));
	ЮТПараметрыПодключенияКВнешнемуСервису = Новый Структура("КлючКлиента, АдресСервера, Соединение", КлючКлиента, АдресСервера);
	ЮТПараметрыПодключенияКВнешнемуСервису.Вставить("СчетчикОшибок", 0);
	
	Если ЮТОкружение.ВерсияПлатформыБольшеИлиРавна("8.3.27") Тогда
		ПодключениеВебСокет8_3_27(АдресСервера);
	Иначе
		ПодключениеВебСокетДо8_3_27(АдресСервера);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОповеститьОСохраненииОтчета(ИмяФайла) Экспорт
	
	Соединение = Соединение();
	
	Если Соединение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОтправитьСообщение(Соединение, "reportFile", Новый Структура("reportFile", ИмяФайла));
	
КонецПроцедуры

Процедура ПолучитьСообщениеДо8_3_27() Экспорт
	
	Соединение = Соединение();
	
	Если Соединение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		Ответ = Соединение.ПолучитьСообщение(100);
	Исключение
		ОбработатьОшибкуСоединения(ИнформацияОбОшибке());
	КонецПопытки;
	
	СократитьСлужебныеСимолы(Ответ);
	Если ЗначениеЗаполнено(Ответ) Тогда
		ПодключениеКСерверуОбработчикПолученияСообщения(Соединение, Ответ);
	КонецЕсли;
	
	ПодключитьОбработчикОжидания("ЮТОпросВебСокетСоединения", 1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПодключениеВебСокетДо8_3_27(АдресСервера)
	
	// Для подключения используется компонента https://github.com/dlyubanevich/websocket1c
	// Автор - Дмитрий Любаневич
	Соединение = ЮТКомпоненты.СоздатьКомпоненту(ЮТКомпоненты.ОписаниеКомпонентыВебСокет());
	Попытка
		Соединение.Подключиться(АдресСервера);
	Исключение
		ОбработатьОшибкуСоединения(ИнформацияОбОшибке());
	КонецПопытки;
	ЗапомнитьСоединение(Соединение);
	
	ПодключениеКСерверуОбработчикОткрытияСоединения(Соединение);
	ПодключитьОбработчикОжидания("ЮТОпросВебСокетСоединения", 0.2, Истина);
	
КонецПроцедуры

Процедура ПодключениеВебСокет8_3_27(АдресСервера)
	
	//@skip-check bsl-legacy-check-string-literal
	Обработчики = Новый (Тип("ОбработчикиWebSocketКлиентСоединения"), ЮТКоллекции.ЗначениеВМассиве("ПодключениеКСерверуОбработчикОткрытияСоединения",
		"ПодключениеКСерверуОбработчикПолученияСообщения",
		"ПодключениеКСерверуОбработчикОшибки",
		"ПодключениеКСерверуОбработчикЗакрытияСоединения",
		ЭтотОбъект));
	
	МенеджерСоединений = ЮТМетодыСлужебный.ВычислитьБезопасно("WebSocketКлиентСоединения");
	Соединение = МенеджерСоединений.ОткрытьСоединение("yaxunit-rpc", АдресСервера, Обработчики);
	ЗапомнитьСоединение(Соединение);
	
КонецПроцедуры

Процедура ПодключениеКСерверуОбработчикОткрытияСоединения(Соединение) Экспорт
	
	Оповещение("Подключено");
	
	ОтправитьСообщение(Соединение, "hello", Новый Структура("protocolVersion, key", "1.0.0", ЮТПараметрыПодключенияКВнешнемуСервису.КлючКлиента));
	
КонецПроцедуры

Процедура ПодключениеКСерверуОбработчикПолученияСообщения(Соединение, Сообщение) Экспорт
	
	Оповещение("Получено сообщение: " +  Сообщение);
	
	ДанныеСообщение = ЮТОбщий.ЗначениеИзJSON(Сообщение);
	
	ТипСообщения = ДанныеСообщение.type;
	
	Если СтрСравнить(ТипСообщения, "runTest") = 0 Тогда
		ЗапуститьТест(ДанныеСообщение, Соединение);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПодключениеКСерверуОбработчикОшибки(Соединение, КодОшибки, Описание) Экспорт
	
	Оповещение(СтрШаблон("Ошибка с кодом %1. %2", КодОшибки, Описание));
	
КонецПроцедуры

Процедура ПодключениеКСерверуОбработчикЗакрытияСоединения(Соединение, КодЗакрытия) Экспорт
	
	Оповещение("Подключение закрыто");
	
КонецПроцедуры

Процедура ОтправитьСообщение(Соединение, ТипСообщения, Данные, Идентификатор = 0)
	
	Сообщение = НовоеСообщение(ТипСообщения, Данные, Идентификатор);
	Попытка
		Соединение.ОтправитьСообщение(ЮТОбщий.СтрокаJSON(Сообщение, Ложь, Истина));
	Исключение
		ОбработатьОшибкуСоединения(ИнформацияОбОшибке());
	КонецПопытки;
	
КонецПроцедуры

Функция НовоеСообщение(Тип, Данные, Идентификатор = 0)
	
	Возврат Новый Структура("type, data, id", Тип, Данные, Идентификатор);
	
КонецФункции

Процедура ЗапуститьТест(Сообщение, Соединение)
	
	Данные = Сообщение.data;
	ОписаниеМодуля = ЮТИсполнительСлужебныйКлиент.ОписаниеВременногоМодуля();
	ОписаниеМодуля.Текст = Данные.module;
	ОписаниеМодуля.ИмяМодуля = Данные.moduleName;
	ОписаниеМодуля.КлиентУправляемое = Данные.client;
	ОписаниеМодуля.КлиентОбычное = Данные.ordinaryClient;
	ОписаниеМодуля.Сервер = Данные.server;
	
	ОбработчикЗавершения = Новый ОписаниеОповещения("ПослеВыполненияТестов", ЭтотОбъект, Новый Структура("Соединение, id", Соединение, Сообщение.id));
	ЮТИсполнительСлужебныйКлиент.ВыполнитьТестыВременногоМодуля(ЮТПараметрыЗапускаСлужебный.ПараметрыТестированияПоУмолчанию(),
																ОписаниеМодуля,
																Данные.methods,
																ОбработчикЗавершения);
	
КонецПроцедуры

Процедура ПослеВыполненияТестов(Результат, ДополнительныеПараметры) Экспорт
	
	ОтправитьСообщение(Соединение(), "report", Отчет(Результат), ДополнительныеПараметры.id);
	
КонецПроцедуры

Функция Отчет(Результат)
	
	Ответ = Новый Массив;
	
	Номер = 1;
	Для Каждого Набор Из Результат[0].НаборыТестов Цикл
		
		Ответ.Добавить(ЮТОтчетJUnitСлужебный.ОписаниеНабора(Неопределено, Набор, Номер));
		Номер = Номер + 1;
		
	КонецЦикла;
	
	Возврат Ответ;
	
КонецФункции

Процедура Оповещение(Текст)
	
	ПоказатьОповещениеПользователя("Подключение WebSoket", , Текст);
	ЮТЛогирование.Информация("Подключение WebSoket: " + Текст);
	
КонецПроцедуры

Процедура ЗапомнитьСоединение(Соединение)
	
	ЮТПараметрыПодключенияКВнешнемуСервису.Соединение = Соединение;
	
КонецПроцедуры

Функция Соединение()
	
	Если ЮТПараметрыПодключенияКВнешнемуСервису <> Неопределено Тогда
		Возврат ЮТКоллекции.ЗначениеСтруктуры(ЮТПараметрыПодключенияКВнешнемуСервису, "Соединение");
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

Процедура ОбработатьОшибкуСоединения(Ошибка = Неопределено, Критичная = Ложь)
	
	Если ЮТПараметрыПодключенияКВнешнемуСервису = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЮТПараметрыПодключенияКВнешнемуСервису.СчетчикОшибок = ЮТПараметрыПодключенияКВнешнемуСервису.СчетчикОшибок + 1;
	
	Если Критичная Или ЮТПараметрыПодключенияКВнешнемуСервису.СчетчикОшибок > 5 Тогда
		Оповещение("Ошибка web socket: " + КраткоеПредставлениеОшибки(Ошибка));
		ЮТПараметрыПодключенияКВнешнемуСервису.Соединение = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

Процедура СократитьСлужебныеСимолы(Ответ)
	
	Если Не ЗначениеЗаполнено(Ответ) Тогда
		Возврат;
	КонецЕсли;
	
	
	Если СтрЗаканчиваетсяНа(Ответ, Символ(0)) Тогда
		Ответ = Лев(Ответ, СтрДлина(Ответ) - 1);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
