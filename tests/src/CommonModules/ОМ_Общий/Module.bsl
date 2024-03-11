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
		.ДобавитьТест("Пауза")
		.ДобавитьТест("ВывестиВКонсоль")
		.ДобавитьСерверныйТест("Менеджер")
		.ДобавитьТест("ЗначениеСвойства")
		;
	
КонецПроцедуры

Процедура Пауза() Экспорт
	
	Начало = ТекущаяУниверсальнаяДатаВМиллисекундах();
	ЮТОбщий.Пауза(1);
	ЮТОбщий.Пауза(1);
	ЮТОбщий.Пауза(1);
	Дельта = ТекущаяУниверсальнаяДатаВМиллисекундах() - Начало;
	
	ЮТест.ОжидаетЧто(Дельта)
		.МеждуИсключаяГраницы(3000, 3200);
	
КонецПроцедуры

Процедура ВывестиВКонсоль() Экспорт
	
	ЮТОбщий.ВывестиВКонсоль(ТекущаяДата());
	
КонецПроцедуры

#Если Сервер Тогда
Процедура Менеджер() Экспорт
	
	Варианты = ЮТест.Варианты("Параметр, Результат")
		.Добавить("Справочник.Товары", Справочники.Товары)
		.Добавить("Справочники.Товары", Справочники.Товары)
		.Добавить(Справочники.Товары, Справочники.Товары)
		.Добавить(Справочники.Товары.ПустаяСсылка(), Справочники.Товары)
		.Добавить(Тип("СправочникМенеджер.Товары"), Справочники.Товары)
		.Добавить(Тип("СправочникСсылка.Товары"), Справочники.Товары)
		.Добавить(ЮТМетаданные.ОписаниеОбъектаМетаданных("Справочник.Товары"), Справочники.Товары)
		.Добавить("РегистрыНакопления.Взаиморасчеты", РегистрыНакопления.Взаиморасчеты)
		;
	
	Для Каждого Вариант Из Варианты.СписокВариантов() Цикл
		
		Описание = СтрШаблон("%1 (%2)", Вариант.Параметр, ТипЗнч(Вариант.Параметр));
		ЮТест.ОжидаетЧто(ЮТОбщий.Менеджер(Вариант.Параметр), Описание)
			.Равно(Вариант.Результат);
		
	КонецЦикла;
	
КонецПроцедуры
#КонецЕсли

Процедура ЗначениеСвойства() Экспорт
	
	Массив = ЮТКоллекции.ЗначениеВМассиве(1, 2, 3);
	Структура = Новый Структура("Число, Массив", 1, Массив);
	
	Варианты = ЮТест.Варианты("Значение, Свойство, Результат")
		.Добавить(Массив, 0, 1)
		.Добавить(Массив, -1, 3)
		.Добавить(Массив, "[0]", 1)
		.Добавить(Массив, 1, 2)
		.Добавить(Структура, "Число", 1)
		.Добавить(Структура, "Массив[0]", 1)
		;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
