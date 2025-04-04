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

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты.Тег("Мокирование")
		.ДобавитьТест("Заголовки")
		.ДобавитьТест("КодСостояния")
		.ДобавитьТест("Тело")
	;
	
КонецПроцедуры

Процедура Заголовки() Экспорт
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Заголовок1", "Значение1");
	Заголовки.Вставить("Заголовок2", "Значение2");
	
	HTTPОтвет = ЮТест.Данные().HTTPОтвет()
		.ДобавитьЗаголовки(Заголовки)
		.ДобавитьЗаголовок("Заголовок3", "Значение3")
	;
	
	ЮТест.ОжидаетЧто(HTTPОтвет)
		.Свойство("Headers").ИмеетТип("Соответствие").ИмеетДлину(3)
		.Свойство("Headers.Заголовок1").Равно("Значение1")
		.Свойство("Headers.Заголовок2").Равно("Значение2")
		.Свойство("Headers.Заголовок3").Равно("Значение3")
		.Свойство("Заголовки").ИмеетТип("Соответствие").ИмеетДлину(3)
		.Свойство("Заголовки.Заголовок1").Равно("Значение1")
		.Свойство("Заголовки.Заголовок2").Равно("Значение2")
		.Свойство("Заголовки.Заголовок3").Равно("Значение3")
	;
	
КонецПроцедуры

Процедура КодСостояния() Экспорт
	
	КодСостояния = 267; // Сомнительно, но окэй
	
	HTTPОтвет = ЮТест.Данные().HTTPОтвет().УстановитьКодСостояния(КодСостояния);
	
	ЮТест.ОжидаетЧто(HTTPОтвет)
		.Свойство("StatusCode").Равно(КодСостояния)
		.Свойство("КодСостояния").Равно(КодСостояния)
	;
	
КонецПроцедуры

Процедура Тело() Экспорт
	
	Тело = "Тело";
	ДвоичныеДанные = ПолучитьДвоичныеДанныеИзСтроки(Тело);
	
	Описание = "Тело установлено из строки";
	HTTPОтвет = ЮТест.Данные().HTTPОтвет().УстановитьТело(ДвоичныеДанные);
	
	ЮТест
		.ОжидаетЧто(HTTPОтвет.GetBodyAsBinaryData(), Описание + ". Получение двоичных данных (ENG)").Равно(ДвоичныеДанные)
		.Что(HTTPОтвет.GetBodyAsString(), Описание + ". Получение строки (ENG)").Равно(Тело)
		.Что(HTTPОтвет.GetBodyAsString("UTF-8"), Описание + ". Получение строки UTF-8 (ENG)").Равно(Тело)
		.Что(HTTPОтвет.GetBodyAsStream(), Описание + ". Получение потока (ENG)").ИмеетТип("Поток")
		.Что(HTTPОтвет.GetBodyFileName(), Описание + ". Получение имени файла (ENG)").ЭтоНеопределено()
		.Что(HTTPОтвет.ПолучитьТелоКакДвоичныеДанные(), Описание + ". Получение двоичных данных (RU)").Равно(ДвоичныеДанные)
		.Что(HTTPОтвет.ПолучитьТелоКакСтроку(), Описание + ". Получение строки (RU)").Равно(Тело)
		.Что(HTTPОтвет.ПолучитьТелоКакСтроку("UTF-8"), Описание + ". Получение строки UTF-8 (RU)").Равно(Тело)
		.Что(HTTPОтвет.ПолучитьТелоКакПоток(), Описание + ". Получение потока (RU)").ИмеетТип("Поток")
		.Что(HTTPОтвет.ПолучитьИмяФайлаТела(), Описание + ". Получение имени файла (RU)").ЭтоНеопределено()
	;
	
	Описание = "Тело установлено из двоичных данных";
	HTTPОтвет = ЮТест.Данные().HTTPОтвет().УстановитьТело(Тело);
	
	ЮТест
		.ОжидаетЧто(HTTPОтвет.GetBodyAsBinaryData(), Описание + ". Получение двоичных данных (ENG)").Равно(ДвоичныеДанные)
		.Что(HTTPОтвет.GetBodyAsString(), Описание + ". Получение строки (ENG)").Равно(Тело)
		.Что(HTTPОтвет.GetBodyAsString("UTF-8"), Описание + ". Получение строки UTF-8 (ENG)").Равно(Тело)
		.Что(HTTPОтвет.GetBodyAsStream(), Описание + ". Получение потока (ENG)").ИмеетТип("Поток")
		.Что(HTTPОтвет.GetBodyFileName(), Описание + ". Получение имени файла (ENG)").ЭтоНеопределено()
		.Что(HTTPОтвет.ПолучитьТелоКакДвоичныеДанные(), Описание + ". Получение двоичных данных (RU)").Равно(ДвоичныеДанные)
		.Что(HTTPОтвет.ПолучитьТелоКакСтроку(), Описание + ". Получение строки (RU)").Равно(Тело)
		.Что(HTTPОтвет.ПолучитьТелоКакСтроку("UTF-8"), Описание + ". Получение строки UTF-8 (RU)").Равно(Тело)
		.Что(HTTPОтвет.ПолучитьТелоКакПоток(), Описание + ". Получение потока (RU)").ИмеетТип("Поток")
		.Что(HTTPОтвет.ПолучитьИмяФайлаТела(), Описание + ". Получение имени файла (RU)").ЭтоНеопределено()
	;
	
	Описание = "Тело установлено из файла";
	ИмяФайла = ПолучитьИмяВременногоФайла("txt");
	ДвоичныеДанные.Записать(ИмяФайла);
	HTTPОтвет = ЮТест.Данные().HTTPОтвет().УстановитьИмяФайлаТела(ИмяФайла);
	
	ЮТест
		.ОжидаетЧто(HTTPОтвет.GetBodyAsBinaryData(), Описание + ". Получение двоичных данных (ENG)").ЭтоНеопределено()
		.Что(HTTPОтвет.GetBodyAsString(), Описание + ". Получение строки (ENG)").ЭтоНеопределено()
		.Что(HTTPОтвет.GetBodyAsString("UTF-8"), Описание + ". Получение строки UTF-8 (ENG)").ЭтоНеопределено()
		.Что(HTTPОтвет.GetBodyAsStream(), Описание + ". Получение потока (ENG)").ИмеетТип("ФайловыйПоток")
		.Что(HTTPОтвет.GetBodyFileName(), Описание + ". Получение имени файла (ENG)").Равно(ИмяФайла)
		.Что(HTTPОтвет.ПолучитьТелоКакДвоичныеДанные(), Описание + ". Получение двоичных данных (RU)").ЭтоНеопределено()
		.Что(HTTPОтвет.ПолучитьТелоКакСтроку(), Описание + ". Получение строки (RU)").ЭтоНеопределено()
		.Что(HTTPОтвет.ПолучитьТелоКакСтроку("UTF-8"), Описание + ". Получение строки UTF-8 (RU)").ЭтоНеопределено()
		.Что(HTTPОтвет.ПолучитьТелоКакПоток(), Описание + ". Получение потока (RU)").ИмеетТип("ФайловыйПоток")
		.Что(HTTPОтвет.ПолучитьИмяФайлаТела(), Описание + ". Получение имени файла (RU)").Равно(ИмяФайла)
	;
	
КонецПроцедуры

#КонецОбласти
