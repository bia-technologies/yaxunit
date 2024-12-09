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
	
	ЮТТесты.Тег("Мокирование")
		.ДобавитьТест("Конструктор")
		.ДобавитьТест("УстановитьТело")
	;
	
КонецПроцедуры

Процедура Конструктор() Экспорт
	
	Идентификатор = Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000001");
	ИдентификаторСообщенияЗапроса = Новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000002");
	
	Сообщение = ЮТест.Данные().СообщениеСервисаИнтеграции()
		.ДобавитьПараметр("Параметр", "Параметр")
		.ДатаОтправки(Дата(1, 1, 1))
		.ДатаУстаревания(Дата(2, 1, 1))
		.Идентификатор(Идентификатор)
		.ИдентификаторСообщенияЗапроса(ИдентификаторСообщенияЗапроса)
		.КодОтправителя("Sender")
		.КодПолучателя("Recipient")
		.РазмерТела(123);
	
	ЮТест.ОжидаетЧто(Сообщение)
		.Свойство("Параметры.Параметр").Равно("Параметр")
		.Свойство("ДатаОтправки").Равно(Дата(1, 1, 1))
		.Свойство("ДатаУстаревания").Равно(Дата(2, 1, 1))
		.Свойство("Идентификатор").Равно(Идентификатор)
		.Свойство("ИдентификаторСообщенияЗапроса").Равно(ИдентификаторСообщенияЗапроса)
		.Свойство("КодОтправителя").Равно("Sender")
		.Свойство("КодПолучателя").Равно("Recipient")
		.Свойство("РазмерТела").Равно(123);
	
КонецПроцедуры

Процедура УстановитьТело() Экспорт
	
	Описание = "Тело не установлено";
	Сообщение = ЮТест.Данные().СообщениеСервисаИнтеграции();
	ЮТест.ОжидаетЧто(Сообщение, Описание)
		.Метод("ПолучитьТелоКакПоток").НеВыбрасываетИсключение();
	ПотокПоТелу = Сообщение.ПолучитьТелоКакПоток();
	ЮТест.ОжидаетЧто(ПотокПоТелу, Описание + ". Проверка типа").ИмеетТип("Поток");
	Текст = Новый ЧтениеТекста(ПотокПоТелу, КодировкаТекста.UTF8);
	ЮТест.ОжидаетЧто(Текст.ПрочитатьСтроку(), Описание + ". Проверка пустого").ЭтоНеопределено();
	
	Описание = "Тело установлено из двоичных данных";
	Тело = "Тело";
	ДвоичныеДанные = ПолучитьДвоичныеДанныеИзСтроки(Тело);
	Сообщение = ЮТест.Данные().СообщениеСервисаИнтеграции()
		.УстановитьТелоКакДвоичныеДанные(ДвоичныеДанные);
	Текст = Новый ЧтениеТекста(Сообщение.ПолучитьТелоКакПоток(), КодировкаТекста.UTF8);
	ЮТест.ОжидаетЧто(Текст.ПрочитатьСтроку(), Описание)
		.Равно(Тело);
	
	Описание = "Тело установлено из строки";
	Сообщение = ЮТест.Данные().СообщениеСервисаИнтеграции()
		.УстановитьТелоКакСтроку(Тело);
	Текст = Новый ЧтениеТекста(Сообщение.ПолучитьТелоКакПоток(), КодировкаТекста.UTF8);
	ЮТест.ОжидаетЧто(Текст.ПрочитатьСтроку(), Описание)
		.Равно(Тело);
	
	Описание = "Тело установлено из JSON";
	Сообщение = ЮТест.Данные().СообщениеСервисаИнтеграции()
		.УстановитьТелоКакСтрокуJSON(Новый Массив());
	Текст = Новый ЧтениеТекста(Сообщение.ПолучитьТелоКакПоток(), КодировкаТекста.UTF8);
	ЮТест.ОжидаетЧто(Текст.ПрочитатьСтроку(), Описание)
		.Равно("[]");
	
КонецПроцедуры

#КонецОбласти
