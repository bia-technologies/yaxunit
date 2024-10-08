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
		.ДобавитьТест("ДобавитьСтроку")
		.ДобавитьТест("СтрокаСимволов")
		.ДобавитьТест("СравнитьВерсии")
		.ДобавитьТест("УникальныеСтроки")
		.ДобавитьТест("СоответствуетШаблону")
	;
	
КонецПроцедуры

Процедура ДобавитьСтроку() Экспорт
	
	Варианты = ЮТест.Варианты("Исходная, Дополнение, Разделитель, Результат")
		.Добавить("1", "2", "+", "1+2")
		.Добавить("", "2", "+", "2")
		.Добавить("1", "", "+", "1")
		.Добавить(Неопределено, "2", "+", "2")
		.Добавить("1", "2", Неопределено, "12")
		.СписокВариантов();
	
	Для Каждого Вариант Из Варианты Цикл
		
		Результат = ЮТСтроки.ДобавитьСтроку(Вариант.Исходная, Вариант.Дополнение, Вариант.Разделитель);
		
		Сообщение = СтрШаблон("ДобавитьСтроку(%1, %2, %3)", Вариант.Исходная, Вариант.Дополнение, Вариант.Разделитель);
		ЮТест.ОжидаетЧто(Результат, Сообщение).Равно(Вариант.Результат);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СтрокаСимволов() Экспорт
	
	Варианты = ЮТест.Варианты("Символ, Количество, Результат")
		.Добавить("1", 1, "1")
		.Добавить("12", 0, "")
		.Добавить("12", 2, "1212")
		.СписокВариантов();
		
	Для Каждого Вариант Из Варианты Цикл
		
		Результат = ЮТСтроки.СтрокаСимволов(Вариант.Символ, Вариант.Количество);
		ЮТест.ОжидаетЧто(Результат, СтрШаблон("%1 * %2", Вариант.Символ, Вариант.Количество))
			.Равно(Вариант.Результат);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СравнитьВерсии() Экспорт
	
	Варианты = ЮТест.Варианты("Версия1, Версия2, Результат")
		.Добавить("1", "1", 0)
		.Добавить("1.2.3.4", "1.3", -1)
		.Добавить("1.2.3", "1.2", 1)
		.Добавить("1.2.3.999", "1.2.3.1", 1)
		.Добавить("1.2.3.1", "1.2.3.999", -1)
		.СписокВариантов();
		
	Для Каждого Вариант Из Варианты Цикл
		
		Результат = ЮТСтроки.СравнитьВерсии(Вариант.Версия1, Вариант.Версия2);
		ЮТест.ОжидаетЧто(Результат, СтрШаблон("%1 и %2", Вариант.Версия1, Вариант.Версия2))
			.Равно(Вариант.Результат);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура УникальныеСтроки() Экспорт
	
	Вход = СтрРазделить("Раз,раз, раз,проверка", ",");
	
	ЮТест.ОжидаетЧто(ЮТСтроки.УникальныеСтроки(Вход))
		.Содержит("Раз")
		.НеСодержит("раз")
		.Содержит(" раз")
		.Содержит("проверка")
		.ИмеетДлину(3);
	
КонецПроцедуры

Процедура СоответствуетШаблону() Экспорт
	
	Строка = "123321";
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*23321"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "12332*"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "1*32*"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "1*"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*1"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "1*1"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "2*"))
		.ЭтоЛожь();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*2"))
		.ЭтоЛожь();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*21*"))
		.ЭтоЛожь();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*33*"))
		.ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТСтроки.СоответствуетШаблону(Строка, "*3*3*"))
		.ЭтоЛожь();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
