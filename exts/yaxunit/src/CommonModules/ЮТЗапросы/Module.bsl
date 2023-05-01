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

#Область ПрограммныйИнтерфейс

Функция ОписаниеЗапроса() Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("ИмяТаблицы", "");
	Описание.Вставить("ВыбираемыеПоля", Новый Структура);
	Описание.Вставить("КоличествоЗаписей", Неопределено);
	Описание.Вставить("Условия", Новый Массив());
	Описание.Вставить("ЗначенияПараметров", Новый Структура());
	
	Возврат Описание;
	
КонецФункции

Функция РезультатЗапроса(ОписаниеЗапроса) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

Функция РезультатПустой(ОпиасниеЗапроса) Экспорт
	
	Возврат ЮТЗапросыВызовСервера.РезультатПустой(ОпиасниеЗапроса);
	
КонецФункции

Функция РезультатНеПустой(ОпиасниеЗапроса) Экспорт
	
	Возврат НЕ ЮТЗапросыВызовСервера.РезультатПустой(ОпиасниеЗапроса);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
