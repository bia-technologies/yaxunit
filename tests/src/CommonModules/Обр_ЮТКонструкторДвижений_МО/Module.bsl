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
	
	ЮТТесты.ВТранзакции()
		.ДобавитьТест("Инициализировать")
		.ДобавитьТест("ДобавитьСтроку")
		.ДобавитьТест("Установить")
		.ДобавитьТест("Установить_Период")
		.ДобавитьТест("УстановитьРеквизиты")
		.ДобавитьТест("Фикция")
		.ДобавитьТест("ФикцияРеквизитов")
		.ДобавитьТест("ФикцияОбязательныхПолей")
		.ДобавитьТест("Записать_РегистрСведений")
		.ДобавитьТест("Записать_РегистрНакопления")
	;
	
КонецПроцедуры

Процедура Инициализировать() Экспорт
	
	// Создаем документ
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.ПриходТовара");
	
	// Инициализируем конструктор движений
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "ТоварныеЗапасы");
	
	// Проверяем, что конструктор инициализирован
	ЮТест.ОжидаетЧто(Конструктор, "Конструктор должен быть инициализирован")
		.НеРавно(Неопределено);
	
	// Проверяем, что данные конструктора пусты
	Данные = Конструктор.Данные();
	ЮТест.ОжидаетЧто(Данные, "Данные конструктора должны быть пустым массивом")
		.ИмеетТип("Массив")
		.Равно(Новый Массив);
	
	ЮТест.ОжидаетЧто(ЮТест.Данные())
		.Метод("КонструкторДвижений", ЮТКоллекции.ЗначениеВМассиве(Документ, "НесуществующийРегистр"))
		.ВыбрасываетИсключение("Документ " + Документ + " не делает движений по регистру ""НесуществующийРегистр""");
	
КонецПроцедуры

Процедура ДобавитьСтроку() Экспорт
	
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.РасходТовара");
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "Продажи");
	
	ЮТест.ОжидаетЧто(Конструктор)
		.Метод("ДобавитьСтроку").НеВыбрасываетИсключение();
	
	Данные = Конструктор.Данные();
	ЮТест.ОжидаетЧто(Данные)
		.Заполнено()
		.ИмеетТип("Массив")
		.ИмеетДлину(1)
		.Свойство(0)
			.ИмеетТип("Структура")
			.НеЗаполнено();
	
КонецПроцедуры

Процедура Установить() Экспорт
	
	МаксимальноеЧисло = 99999;
	
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.РасходТовара");
	Покупатель = ЮТест.Данные().СоздатьЭлемент("Справочники.Контрагенты");
	Сумма = ЮТест.Данные().СлучайноеПоложительноеЧисло(МаксимальноеЧисло);
	
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "Продажи");
	
	ЮТест.ОжидаетЧто(Конструктор)
		.Метод("Установить", ЮТКоллекции.ЗначениеВМассиве("Покупатель", Покупатель)).ВыбрасываетИсключение("Сначала необходимо добавить строку");
	
	Конструктор
		.ДобавитьСтроку()
		.Установить("Покупатель", Покупатель)
		.Установить("Сумма", Сумма);
	Данные = Конструктор.ДанныеСтроки();
	ЮТест.ОжидаетЧто(Данные)
		.Заполнено()
		.Свойство("Покупатель").Равно(Покупатель)
		.Свойство("Сумма").Равно(Сумма);
	
КонецПроцедуры

Процедура Установить_Период() Экспорт
	
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.РасходТовара");
	Период = ЮТест.Данные().СлучайнаяДата();
	
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "Продажи")
		.ДобавитьСтроку()
			.ФикцияРеквизитов("Покупатель, Сумма")
			.Установить("Период", Период);
	
	Данные = Конструктор.ДанныеСтроки();
	ЮТест.ОжидаетЧто(Данные, "Проверка данных записи")
		.Заполнено()
		.Свойство("Покупатель").Заполнено()
		.Свойство("Сумма").Заполнено()
		.Свойство("Период").Равно(Период);
	
	Конструктор.Записать();
	ЗаписиРегистра = ЮТЗапросы.ДвиженияДокумента(Документ, "Продажи");
	ЮТест.ОжидаетЧто(ЗаписиРегистра, "Проверка сформированных движений")
		.Заполнено()
		.ИмеетДлину(1)
		.Что(ЗаписиРегистра[0])
		.Свойство("Покупатель").Заполнено()
		.Свойство("Сумма").Заполнено()
		.Свойство("Период").Равно(Период);
	
КонецПроцедуры

Процедура УстановитьРеквизиты() Экспорт
	
	МаксимальноеЧисло = 99999;
	
	// Создаем документ и контрагента
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.РасходТовара");
	Контрагент = ЮТест.Данные().СоздатьЭлемент("Справочники.Контрагенты");
	Сумма = ЮТест.Данные().СлучайноеПоложительноеЧисло(МаксимальноеЧисло);
	Количество = ЮТест.Данные().СлучайноеПоложительноеЧисло(МаксимальноеЧисло);
	
	// Инициализируем конструктор движений
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "Продажи")
		.ДобавитьСтроку().УстановитьРеквизиты(Новый Структура);
	
	ЮТест.ОжидаетЧто(Конструктор.ДанныеСтроки()).НеЗаполнено();
	
	// Добавляем строку и устанавливаем реквизиты
	ЗначенияРеквизитов = Новый Структура("Покупатель, Сумма", Контрагент, Сумма);
	Конструктор.УстановитьРеквизиты(ЗначенияРеквизитов);
	
	ЗначенияРеквизитов = Новый Структура("Количество", Количество);
	Конструктор.УстановитьРеквизиты(ЗначенияРеквизитов);
	
	// Получаем данные строки
	Данные = Конструктор.ДанныеСтроки();
	
	// Проверяем, что реквизиты установлены корректно
	ЮТест.ОжидаетЧто(Данные)
		.Заполнено("Данные конструктора должны быть заполнены структурой")
		.ИмеетТип("Структура")
		.Свойство("Покупатель").Равно(Контрагент, "Контрагент должен совпадать")
		.Свойство("Сумма").Равно(Сумма, "Сумма должна быть равна " + Сумма)
		.Свойство("Количество").Равно(Количество, "Количество должна быть равна " + Количество);
	
КонецПроцедуры

Процедура Фикция() Экспорт
	
	// Создаем документ
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.ПриходТовара");
	
	// Инициализируем конструктор движений
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "ТоварныеЗапасы");
	
	// Добавляем строку и устанавливаем фиктивное значение реквизита
	Конструктор.ДобавитьСтроку().Фикция("Товар");
	
	// Получаем данные строки
	Данные = Конструктор.ДанныеСтроки();
	
	// Проверяем, что реквизит "Номенклатура" заполнен
	ЮТест.ОжидаетЧто(Данные, "Данные строки должны быть заполнены")
		.Заполнено()
		.Свойство("Товар")
			.Заполнено("Номенклатура должна быть заполнена")
			.ИмеетТип("СправочникСсылка.Товары");
	
	// Проверяем, что метод выбрасывает исключение
	МассивПараметров = ЮТКоллекции.ЗначениеВМассиве("НесуществующийРеквизит");
	ЮТест.ОжидаетЧто(Конструктор)
		.Метод("Фикция", МассивПараметров)
		.ВыбрасываетИсключение("`РегистрНакопления.ТоварныеЗапасы` не содержит реквизит `НесуществующийРеквизит`");
	
КонецПроцедуры

Процедура ФикцияРеквизитов() Экспорт
	
	// Создаем документ
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.ПриходТовара");
	
	// Инициализируем конструктор движений
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "ТоварныеЗапасы");
	
	// Добавляем строку и устанавливаем фиктивные значения реквизитов
	Конструктор.ДобавитьСтроку().ФикцияРеквизитов("Товар, Склад, Количество");
	
	// Получаем данные строки
	Данные = Конструктор.ДанныеСтроки();
	
	// Проверяем, что все реквизиты заполнены
	ЮТест.ОжидаетЧто(Данные, "Данные строки должны быть заполнены")
		.Заполнено()
		.Свойство("Товар")
			.Заполнено("Товар должн быть заполнен")
			.ИмеетТип("СправочникСсылка.Товары")
		.Свойство("Склад")
			.Заполнено("Склад должен быть заполнен")
			.ИмеетТип("СправочникСсылка.Склады")
		.Свойство("Количество")
			.Заполнено("Количество должено быть заполнено")
			.ИмеетТип("Число");
	
	// Проверяем, что при указании несуществующих реквизитов выбрасывается исключение
	МассивПараметров = ЮТКоллекции.ЗначениеВМассиве("Несуществующий1");
	ЮТест.ОжидаетЧто(Конструктор)
		.Метод("ФикцияРеквизитов", МассивПараметров)
		.ВыбрасываетИсключение("`РегистрНакопления.ТоварныеЗапасы` не содержит реквизит `Несуществующий1`");
	
КонецПроцедуры

Процедура ФикцияОбязательныхПолей() Экспорт
	
	// Создаем документ
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.РасходТовара");
	
	// Инициализируем конструктор движений
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "ТоварныеЗапасы");
	
	// Добавляем строку и заполняем обязательные поля фиктивными значениями
	Конструктор.ДобавитьСтроку().ФикцияОбязательныхПолей();
	
	// Получаем данные строки
	Данные = Конструктор.ДанныеСтроки();
	
	// Получаем список обязательных полей из метаданных
	ОбязательныеПоля = ЮТКоллекции.ЗначениеВМассиве("Товар", "Склад");
	
	// Проверяем, что все обязательные поля заполнены
	Утверждение = ЮТест.ОжидаетЧто(Данные);
	Для Каждого Поле Из ОбязательныеПоля Цикл
		Утверждение.Свойство(Поле)
			.Заполнено();
	КонецЦикла;
	
КонецПроцедуры

Процедура Записать_РегистрСведений() Экспорт
	
	МаксимальноеЧисло = 99999;
	
	// Создаем документ "УстановкаЦен"
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.УстановкаЦен");
	Товар = ЮТест.Данные().СоздатьЭлемент("Справочники.Товары");
	ВидыЦены = ЮТест.Данные().СоздатьЭлемент("Справочники.ВидыЦен");
	Цена = ЮТест.Данные().СлучайноеПоложительноеЧисло(МаксимальноеЧисло);
	
	// Инициализируем конструктор движений для регистра сведений "ЦеныТоваров"
	Конструктор = ЮТест.Данные().КонструкторДвижений(Документ, "ЦеныТоваров");
	// Добавляем строку и заполняем необходимые реквизиты
	Конструктор.ДобавитьСтроку().УстановитьРеквизиты(Новый Структура("Товар, ВидЦен, Цена", Товар, ВидыЦены, Цена));
	
	// Записываем движения
	Конструктор.Записать();
	
	// Проверяем, что движения были записаны в регистр сведений
	ЮТест.ОжидаетЧтоТаблицаБазы("РегистрСведений.ЦеныТоваров")
		.СодержитЗаписи(ЮТест.Предикат()
			.Реквизит("Регистратор").Равно(Документ));
	
	// Получаем записи регистра движений документа
	ЗаписиРегистра = ЮТЗапросы.ДвиженияДокумента(Документ, "ЦеныТоваров");
	
	// Проверяем, что движения были записаны в регистр сведений
	ЮТест.ОжидаетЧто(ЗаписиРегистра)
		.Заполнено()
		.ИмеетДлину(1)
		.Свойство("[0].Регистратор").Равно(Документ)
		.Свойство("[0].Товар").Равно(Товар)
		.Свойство("[0].ВидЦен").Равно(ВидыЦены)
		.Свойство("[0].Цена").Равно(Цена)
	;
	
КонецПроцедуры

Процедура Записать_РегистрНакопления() Экспорт
	
	// Создаем документ
	Документ = ЮТест.Данные().СоздатьДокумент("Документы.РасходТовара");
	
	// Инициализируем конструктор движений
	ЮТест.Данные().КонструкторДвижений(Документ, "ТоварныеЗапасы")
		.ДобавитьСтроку()
		.ФикцияРеквизитов("Товар, Склад, Количество")
		.Записать();
	
	ЮТест.ОжидаетЧтоТаблицаБазы("РегистрНакопления.ТоварныеЗапасы")
		.СодержитЗаписи(ЮТест.Предикат()
			.Реквизит("Регистратор").Равно(Документ));
	
КонецПроцедуры

#КонецОбласти

