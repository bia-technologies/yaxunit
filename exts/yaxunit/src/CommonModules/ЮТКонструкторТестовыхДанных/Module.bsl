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

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

// Инициализирует конструктор тестовых данных
// 
// Параметры:
//  Менеджер - Строка - Имя менеджера. Примеры: Справочники.Товары, Документы.ПриходТоваров
// 
// Возвращаемое значение:
//  ОбщийМодуль - Конструктор
Функция Инициализировать(Менеджер) Экспорт
	
	Контекст = НовыйКонтекстКонструктора(Менеджер);
	ЮТКонтекст.УстановитьЗначениеКонтекста(КлючКонтекста(), Контекст);
	
	Возврат ЮТКонструкторТестовыхДанных;
	
КонецФункции

// Устанавливает значение реквизита создаваемого объекта.
// Если метод вызывается после вызова см. ТабличнаяЧасть, то устанавливается значение реквизита строки табличной части 
// 
// Параметры:
//  ИмяРеквизита - Строка - Имя реквизита объекта или табличной части
//  Значение - Произвольный - Значение реквизита объекта или табличной части
// 
// Возвращаемое значение:
//  ОбщийМодуль - Конструктор
Функция Установить(ИмяРеквизита, Значение) Экспорт
	
	Контекст = Контекст();
	
	Если ЗначениеЗаполнено(Контекст.ТекущаяТабличнаяЧасть) Тогда
		ТекущаяЗапись = ДанныеСтроки();
	Иначе
		ТекущаяЗапись = Контекст.Данные;
	КонецЕсли;
	
	ТекущаяЗапись.Вставить(ИмяРеквизита, Значение);
	
	Возврат ЮТКонструкторТестовыхДанных;
	
КонецФункции

// Устанавливает фиктивное значение реквизита создаваемого объекта.
// Если метод вызывается после вызова см. ТабличнаяЧасть, то устанавливается значение реквизита строки табличной части.
// 
// На основании менеджера и имени реквизита вычисляется тип реквизита. На основании типа генерируется фиктивное значение.
// 
// * Для примитивных значение генерируется случайное значение
// * Для ссылочных типов создается новый объект
// * Для перечислений (в том числе системных) выбирается случайно значение перечисления
// 
// Параметры:
//  ИмяРеквизита - Строка - Имя реквизита объекта или табличной части
//  Реквизиты - Структура - Значения реквизитов заполнения создаваемого объекта базы
//            - Неопределено
// 
// Возвращаемое значение:
//  ОбщийМодуль - Конструктор
Функция Фикция(ИмяРеквизита, Реквизиты = Неопределено) Экспорт
	
	Контекст = Контекст();
	
	Если ЗначениеЗаполнено(Контекст.ТекущаяТабличнаяЧасть) Тогда
		ОписаниеРеквизита = Контекст.Метаданные.ТабличныеЧасти[Контекст.ТекущаяТабличнаяЧасть][ИмяРеквизита];
		ТекущаяЗапись = ДанныеСтроки();
	Иначе
		ОписаниеРеквизита = Контекст.Метаданные.Реквизиты[ИмяРеквизита];
		ТекущаяЗапись = Контекст.Данные;
	КонецЕсли;
	
	Значение = ЮТТестовыеДанныеСлужебный.Фикция(ОписаниеРеквизита.Тип);
	ТекущаяЗапись.Вставить(ИмяРеквизита, Значение);
	
	Возврат ЮТКонструкторТестовыхДанных;
	
КонецФункции

// Переключает конструктор на заполнение табличной части объекта
// 
// Параметры:
//  ИмяТабличнойЧасти - Строка - Имя табличной части
// 
// Возвращаемое значение:
//  ОбщийМодуль - Конструктор
Функция ТабличнаяЧасть(ИмяТабличнойЧасти) Экспорт
	
	Контекст = Контекст();
	Контекст.ТекущаяТабличнаяЧасть = ИмяТабличнойЧасти;
	Контекст.Данные.Вставить(ИмяТабличнойЧасти, Новый Массив());
	
	Возврат ЮТКонструкторТестовыхДанных;
	
КонецФункции

// Добавляет новую строку табличной части объекта
// 
// Возвращаемое значение:
//  ОбщийМодуль - Конструктор
Функция ДобавитьСтроку() Экспорт
	
	Контекст = Контекст();
	
	Запись = Новый Структура();
	ДанныеТабличнойЧасти(Контекст).Добавить(Запись);
	
	Возврат ЮТКонструкторТестовыхДанных;
	
КонецФункции

// Устанавливает дополнительное свойство объекта
// 
// Параметры:
//  ИмяСвойства - Строка - Имя дополнительного свойства
//  Значение - Произвольный - Значение дополнительного свойства
// 
// Возвращаемое значение:
//  ОбщийМодуль - Конструктор
Функция УстановитьДополнительноеСвойство(ИмяСвойства, Значение) Экспорт
	
	Контекст = Контекст();
	Контекст.ДополнительныеСвойства.Вставить(ИмяСвойства, Значение);
	
	Возврат ЮТКонструкторТестовыхДанных;
	
КонецФункции

// Возвращает данные текущей строки табличной части объекта
// 
// Возвращаемое значение:
//  Структура - Данные строки
//  Неопределено - Если заполняется объект
Функция ДанныеСтроки() Экспорт
	
	Контекст = Контекст();
	
	Если ПустаяСтрока(Контекст.ТекущаяТабличнаяЧасть) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ДанныеТабличнойЧасти = ДанныеТабличнойЧасти(Контекст);
	
	Если ДанныеТабличнойЧасти.Количество() Тогда
		Возврат ДанныеТабличнойЧасти[ДанныеТабличнойЧасти.ВГраница()];
	Иначе
		ВызватьИсключение "Сначала необходимо добавить строку табличной части";
	КонецЕсли;
	
КонецФункции

// Возвращает данные создаваемого объекта
// 
// Возвращаемое значение:
//  Структура - Данные объекта
Функция ДанныеОбъекта() Экспорт
	
	Контекст = Контекст();
	Возврат Контекст.Данные;
	
КонецФункции

// Создает новый объект и возвращает его или ссылку.
// 
// Важно, после создания данные не очищаются, поэтому многократный вызов метода создаст множество объектов.
// Если вы хотите создать полностью новый объект, необходимо по-новой инициировать конструктор.
// 
// Параметры:
//  ВернутьОбъект - Булево - Вернуть объект вместо ссылки
// 
// Возвращаемое значение:
//  Произвольный - Созданный объект или ссылка на него
Функция Записать(ВернутьОбъект = Ложь) Экспорт
	
	Контекст = Контекст();
	
	ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
	ПараметрыЗаписи.ДополнительныеСвойства = Контекст.ДополнительныеСвойства;
	
	Возврат ЮТТестовыеДанныеВызовСервера.СоздатьЗапись(Контекст.Менеджер, Контекст.Данные, ПараметрыЗаписи, ВернутьОбъект);
	
КонецФункции

// Создает и проводит новый документ и возвращает его или ссылку.
// 
// Параметры:
//  ВернутьОбъект - Булево - Вернуть объект вместо ссылки
// 
// Важно, после создания данные не очищаются, поэтому многократный вызов метода создать множество объектов.
// Если вы хотите создать полностью новый объект, необходимо по-новой инициировать конструктор.
// 
// Возвращаемое значение:
//  Произвольный - Созданный объект или ссылка на него
Функция Провести(ВернутьОбъект = Ложь) Экспорт
	
	Контекст = Контекст();
	
	ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
	ПараметрыЗаписи.ДополнительныеСвойства = Контекст.ДополнительныеСвойства;
	ПараметрыЗаписи.РежимЗаписи = РежимЗаписиДокумента.Проведение;
	
	Возврат ЮТТестовыеДанныеВызовСервера.СоздатьЗапись(Контекст.Менеджер, Контекст.Данные, ПараметрыЗаписи, ВернутьОбъект);
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныеПроцедурыИФункции

// Контекст.
// 
// Возвращаемое значение:
//  см. НовыйКонтекстКонструктора
Функция Контекст()
	
	Возврат ЮТКонтекст.ЗначениеКонтекста(КлючКонтекста());
	
КонецФункции

// Новый контекст конструктора.
// 
// Параметры:
//  Менеджер - Произвольный
// 
// Возвращаемое значение:
//  Структура - Новый контекст конструктора:
//  * Менеджер - Произвольный
//  * Данные - Структура
//  * Метаданные - см. ЮТМетаданные.ОписаниеОбъектМетаданных
//  * ТекущаяТабличнаяЧасть - Строка -
//  * ДополнительныеСвойства - Структура
Функция НовыйКонтекстКонструктора(Менеджер)
	
	Контекст = Новый Структура("Менеджер, Данные, Метаданные", Менеджер, Новый Структура());
	Контекст.Вставить("Менеджер", Менеджер);
	Контекст.Вставить("Данные", Новый Структура());
	Контекст.Вставить("Метаданные", ЮТМетаданные.ОписаниеОбъектМетаданных(Менеджер));
	Контекст.Вставить("ТекущаяТабличнаяЧасть", "");
	Контекст.Вставить("ДополнительныеСвойства", Новый Структура());
	
	Возврат Контекст;
	
КонецФункции

Функция КлючКонтекста()
	
	Возврат "КонструкторТестовыхДанных";
	
КонецФункции

Функция ДанныеТабличнойЧасти(Контекст)
	
	Возврат Контекст.Данные[Контекст.ТекущаяТабличнаяЧасть];
	
КонецФункции

#КонецОбласти
