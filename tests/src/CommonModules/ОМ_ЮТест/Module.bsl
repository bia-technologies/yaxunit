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
	
	ЮТТесты
		.ДобавитьТестовыйНабор("ОсновнойНабор")
			.ДобавитьТест("Пропустить")
			.ДобавитьТест("ПроверкаКонтекста")
			.ДобавитьСерверныйТест("ТранзакцияПоУмолчаниюАктивна")
			.ДобавитьТест("ОписаниеТекущегоТеста")
			.ДобавитьТест("ОписаниеТекущегоТестовогоНабора")
			.ДобавитьТест("ОписаниеТекущегоТестовогоМодуля")
		.ДобавитьТестовыйНабор("ПереопределенныйНабор").Перед("Перед_ПереопределенныйНабор")
			.ДобавитьТест("ПроверкаПереопределенногоКонтекста").Перед("Перед_ПроверкаПереопределенногоКонтекста")
		.ДобавитьТестовыйНабор("ПовторнаяПроверкаКонтекста")
			.ДобавитьТест("ПроверкаКонтекста")
			.ДобавитьТест("Окружение")
	;
	
КонецПроцедуры

Процедура ПередВсемиТестами() Экспорт
	
	ЮТест.Контекст().УстановитьЗначение("Глобальный", 1);
	ЮТест.Контекст().УстановитьЗначение("Заменяемый", 5);
	ЮТест.Контекст().УстановитьЗначение("Коллекция", Новый Массив());
	ЮТест.Контекст().Значение("Коллекция").Добавить("ПередВсемиТестами");
	
КонецПроцедуры

Процедура ПередТестовымНабором() Экспорт
	
	ЮТест.Контекст().УстановитьЗначение("Набор", 2);
	ЮТест.Контекст().Значение("Коллекция").Добавить("ПередТестовымНабором");
	
КонецПроцедуры

Процедура ПередКаждымТестом() Экспорт
	
	ЮТест.Контекст().УстановитьЗначение("Тест", 3);
	ЮТест.Контекст().УстановитьЗначение("Заменяемый", 3);
	ЮТест.Контекст().Значение("Коллекция").Добавить("ПередКаждымТестом");
	
КонецПроцедуры

Процедура ПослеКаждогоТеста() Экспорт
	
	ЮТест.Контекст().Значение("Коллекция").Добавить("ПослеКаждогоТеста");
	
КонецПроцедуры

Процедура ПослеТестовогоНабора() Экспорт
	
	ЮТест.Контекст().Значение("Коллекция").Добавить("ПослеТестовогоНабора");
	
КонецПроцедуры

Процедура ПослеВсехТестов() Экспорт
	
	ЮТест.Контекст().Значение("Коллекция").Добавить("ПослеВсехТестов");
	
	// Нелья точно понять сколько будет тестов для толстого клиента в файловом режиме
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Коллекция").Количество())
		.ВСписке(ЮТКоллекции.ЗначениеВМассиве(24, 26));
	
КонецПроцедуры

Процедура Пропустить() Экспорт
	
	ЮТест.Пропустить("Тест пропущен");
	ВызватьИсключение "Не отработал пропуск теста";
	
КонецПроцедуры

Процедура ПроверкаКонтекста() Экспорт
	
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Глобальный"), "Значение глобального контекста").Равно(1);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Набор"), "Значение контекста набора").Равно(2);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Тест"), "Значение контекста теста").Равно(3);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Заменяемый"), "Замененное значение контекста").Равно(3);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Коллекция"))
		.ИмеетДлинуБольше(2)
		.Содержит("ПередВсемиТестами")
		.Содержит("ПередТестовымНабором")
		.Содержит("ПередКаждымТестом");
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("КоллекцияПереопределенногоНабора")).Равно(Неопределено);
	
КонецПроцедуры

Процедура Перед_ПереопределенныйНабор() Экспорт
	
	ЮТест.Контекст().УстановитьЗначение("Набор", -2);
	ЮТест.Контекст().Значение("Коллекция").Добавить("Перед_ПереопределенныйНабор");
	ЮТест.Контекст().УстановитьЗначение("КоллекцияПереопределенногоНабора", Новый Массив());
	ЮТест.Контекст().Значение("КоллекцияПереопределенногоНабора").Добавить("Перед_ПереопределенныйНабор");
	
КонецПроцедуры

Процедура Перед_ПроверкаПереопределенногоКонтекста() Экспорт
	
	ЮТест.Контекст().УстановитьЗначение("Тест", -3);
	ЮТест.Контекст().УстановитьЗначение("Заменяемый", -3);
	ЮТест.Контекст().Значение("Коллекция").Добавить("Перед_ПроверкаПереопределенногоКонтекста");
	ЮТест.Контекст().Значение("КоллекцияПереопределенногоНабора").Добавить("Перед_ПроверкаПереопределенногоКонтекста");
	
КонецПроцедуры

Процедура ПроверкаПереопределенногоКонтекста() Экспорт
	
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Глобальный"), "Значение глобального контекста").Равно(1);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Набор"), "Значение контекста набора").Равно(-2);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Тест"), "Значение контекста теста").Равно(-3);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Заменяемый"), "Замененное значение контекста").Равно(-3);
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("Коллекция"))
		.ИмеетДлинуБольше(4)
		.Содержит("ПередВсемиТестами")
		.Содержит("ПередТестовымНабором")
		.Содержит("Перед_ПереопределенныйНабор")
		.Содержит("ПередКаждымТестом")
		.Содержит("Перед_ПроверкаПереопределенногоКонтекста");
	ЮТест.ОжидаетЧто(ЮТест.Контекст().Значение("КоллекцияПереопределенногоНабора"))
		.ИмеетДлинуБольше(1)
		.Содержит("Перед_ПереопределенныйНабор")
		.Содержит("Перед_ПроверкаПереопределенногоКонтекста");
	
КонецПроцедуры

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ТолстыйКлиентУправляемоеПриложение Тогда
Процедура ТранзакцияПоУмолчаниюАктивна() Экспорт

	ЮТест.ОжидаетЧто(ТранзакцияАктивна(), "Транзакция из настроек по умолчанию не активна")
		.ЭтоИстина();
	
КонецПроцедуры
#КонецЕсли

Процедура Окружение() Экспорт
	
	Окружение = ЮТест.Окружение();
	
	Утверждение = ЮТест.ОжидаетЧто(Окружение)
		.Заполнено()
		.ИмеетТип("Структура")
		.Свойство("ВстроенныйЯзык").Равно("ru")
		.Свойство("ВебКлиент").Равно(Ложь)
		.Свойство("ВерсияПлатформы")
		.Свойство("ФайловаяБаза")
		.Свойство("ОперационнаяСистемаКлиент")
		.Свойство("АрхитектураКлиент")
		.Свойство("ОперационнаяСистемаСервер")
		.Свойство("АрхитектураСервер")
		.Свойство("ИнформационнаяСреда")
	;
#Если ТолстыйКлиентОбычноеПриложение Тогда
	Утверждение.Свойство("ОбычноеПриложение").Равно(Истина)
		.Свойство("ТолстыйКлиент").Равно(Истина);
#ИначеЕсли ТолстыйКлиентУправляемоеПриложение Тогда
	Утверждение.Свойство("ОбычноеПриложение").Равно(Ложь)
		.Свойство("ТолстыйКлиент").Равно(Истина);
#ИначеЕсли Клиент Тогда
	Утверждение.Свойство("ОбычноеПриложение").Равно(Ложь)
		.Свойство("ТолстыйКлиент").Равно(Ложь);
#КонецЕсли
	
КонецПроцедуры

Процедура ОписаниеТекущегоТеста() Экспорт
	
	Описание = ЮТест.ОписаниеТекущегоТеста();
	
	ЮТест.ОжидаетЧто(Описание)
		.Свойство("Имя").Равно("ОписаниеТекущегоТеста")
		.Свойство("Метод").Равно("ОписаниеТекущегоТеста")
		.Свойство("ПолноеИмяМетода").Равно("ОМ_ЮТест.ОписаниеТекущегоТеста")
		.Свойство("Режим").Заполнено()
		.Свойство("ДатаСтарта").Заполнено()
		.Свойство("Длительность").Равно(0)
		.Свойство("Статус").Равно("Исполнение")
		.Свойство("Параметры").ЭтоНеопределено()
		.Свойство("НомерВНаборе").Заполнено()
		.Свойство("Теги")
		.Свойство("НастройкиВыполнения")
		.Свойство("Зависимости")
		.Свойство("Ошибки")
	;
	
КонецПроцедуры

Процедура ОписаниеТекущегоТестовогоНабора() Экспорт
	
	Описание = ЮТест.ОписаниеТекущегоТестовогоНабора();
	
	ЮТест.ОжидаетЧто(Описание)
		.Свойство("Имя").Равно("ОсновнойНабор")
		.Свойство("Представление").Равно("ОсновнойНабор")
		.Свойство("Режим").Заполнено()
		.Свойство("Тесты").Содержит(ЮТест.Предикат().Реквизит("Имя").Равно("ОписаниеТекущегоТестовогоНабора"))
		.Свойство("ДатаСтарта").Заполнено()
		.Свойство("Длительность").Равно(0)
		.Свойство("Выполнять").ЭтоИстина()
		.Свойство("Теги")
		.Свойство("НастройкиВыполнения")
		.Свойство("Зависимости")
		.Свойство("Ошибки")
	;
	
КонецПроцедуры

Процедура ОписаниеТекущегоТестовогоМодуля() Экспорт
	
	Описание = ЮТест.ОписаниеТекущегоТестовогоМодуля();
	
	ЮТест.ОжидаетЧто(Описание)
		.Свойство("Метаданные.Имя").Равно("ОМ_ЮТест")
		.Свойство("НаборыТестов").НеЗаполнено()
		.Свойство("Теги")
		.Свойство("НастройкиВыполнения")
		.Свойство("Зависимости")
		.Свойство("Ошибки")
	;
	
КонецПроцедуры

#КонецОбласти
