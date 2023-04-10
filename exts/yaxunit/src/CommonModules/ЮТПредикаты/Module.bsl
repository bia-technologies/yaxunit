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

// Инициализирует конструктор предиката
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Инициализировать() Экспорт
	
	ЮТКонтекст.УстановитьЗначениеКонтекста(КлючКонтекста(), НовыйКонтекст());
	Возврат ЮТПредикаты;
	
КонецФункции

// Устанавливает имя реквизита и все последующие проверки будут относится к нему.
// 
// Параметры:
//  ИмяРеквизита - Строка - Имя реквизита
//               - Число - Индекс коллекции
//               - Произвольный - Ключ соответствия
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Реквизит(ИмяРеквизита) Экспорт
	
	Контекст().ИмяРеквизита = ИмяРеквизита;
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий равенство объекта (свойства) указанному значению
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Равно(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().Равно, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий не равенство объекта (свойства) указанному значению
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция НеРавно(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().НеРавно, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий заполненость объекта (свойства)
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Заполнено() Экспорт
	
	ДобавитьПредикат(Выражения().Заполнено, Неопределено);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что объект (свойств) не заполнено
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Пусто() Экспорт
	
	ДобавитьПредикат(Выражения().НеЗаполнено, Неопределено);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (свойства) больше указанного
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Больше(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().Больше, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (свойства) больше или равно указанному
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция БольшеИлиРавно(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().БольшеРавно, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (свойства) меньше указанного
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Меньше(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().Меньше, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (свойства) меньше или равно указанному
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция МеньшеИлиРавно(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().МеньшеРавно, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (свойства) имеет укананный тип
// 
// Параметры:
//  Тип - Тип
//      - ОписаниеТипов
//      - Строка - Имя типа
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция ИмеетТип(Тип) Экспорт
	
	ДобавитьПредикат(Выражения().ИмеетТип, Тип);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (свойства) имеет тип отличный от указанного
// 
// Параметры:
//  Тип - Тип
//      - ОписаниеТипов
//      - Строка - Имя типа
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция ИмеетТипОтличныйОт(Тип) Экспорт
	
	ДобавитьПредикат(Выражения().НеИмеетТип, Тип);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, длину/размер значение объекта (свойства) на равенство указанному значению
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция ИмеетДлину(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().ИмеетДлину, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, длину/размер значение объекта (свойства) на не равенство указанному значению
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция ИмеетДлинуОтличнуюОт(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().НеИмеетДлину, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (реквизита) содержит вложенное свойство
// 
// Параметры:
//  ИмяСвойства - Строка - Имя свойства
//              - Число - Индекс коллекции
//              - Произвольный - Ключ соответствия
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция ИмеетСвойство(ИмяСвойства) Экспорт
	
	ДобавитьПредикат(Выражения().ИмеетСвойство, ИмяСвойства);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (реквизита) не содержит вложенное свойство
// 
// Параметры:
//  ИмяСвойства - Строка - Имя свойства
//              - Число - Индекс коллекции
//              - Произвольный - Ключ соответствия
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция НеИмеетСвойства(ИмяСвойства) Экспорт
	
	ДобавитьПредикат(Выражения().НеИмеетСвойство, ИмяСвойства);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (реквизита) содержит указанное значение
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция Содержит(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().Содержит, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Добавляет предикат, проверяющий, что значение объекта (реквизита) не содержит указанное значение
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - Этот модуль для замыкания
Функция НеСодержит(Значение) Экспорт
	
	ДобавитьПредикат(Выражения().НеСодержит, Значение);
	Возврат ЮТПредикаты;
	
КонецФункции

// Возвращает набор сформированных утверждений.
// Рекомендуется использовать этот метод, если планируется отложенная проверка предактов. Например, вы хотитет сформировать два набору предактов
// и проверять их в зависимости от условия.
// 
// Метод копирует настроенный набор утверждений в массив и возвращает его, таким образом сохраняется состояние, которое можно передавать дальше.
//  
// Возвращаемое значение:
//  Массив из см. ЮТФабрика.ВыражениеПредиката - Набор предикатов
Функция Получить() Экспорт
	
	Возврат ЮТОбщий.СкопироватьМассив(Контекст().Предикаты);
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныеПроцедурыИФункции

Функция Выражения() Экспорт
	
	Выражения = Новый Структура;
	Выражения.Вставить("Равно", "Равно");
	Выражения.Вставить("НеРавно", "НеРавно");
	Выражения.Вставить("Заполнено", "Заполнено");
	Выражения.Вставить("НеЗаполнено", "НеЗаполнено");
	Выражения.Вставить("Больше", "Больше");
	Выражения.Вставить("БольшеРавно", "БольшеРавно");
	Выражения.Вставить("Меньше", "Меньше");
	Выражения.Вставить("МеньшеРавно", "МеньшеРавно");
	Выражения.Вставить("ИмеетТип", "ИмеетТип");
	Выражения.Вставить("НеИмеетТип", "НеИмеетТип");
	Выражения.Вставить("ИмеетДлину", "ИмеетДлину");
	Выражения.Вставить("НеИмеетДлину", "НеИмеетДлину");
	Выражения.Вставить("ИмеетСвойство", "ИмеетСвойство");
	Выражения.Вставить("НеИмеетСвойство", "НеИмеетСвойство");
	Выражения.Вставить("Содержит", "Содержит");
	Выражения.Вставить("НеСодержит", "НеСодержит");
	
	Возврат Новый ФиксированнаяСтруктура(Выражения);
	
КонецФункции

// Контекст.
// 
// Возвращаемое значение:
//  см. НовыйКонтекст
Функция Контекст()
	
	Возврат ЮТКонтекст.ЗначениеКонтекста(КлючКонтекста());
	
КонецФункции

Функция КлючКонтекста()
	
	Возврат "Предикаты";
	
КонецФункции

// Новый контекст.
// 
// Возвращаемое значение:
//  Структура - Новый контекст:
// * Предикаты - Массив из см. Предикат-
// * ТекущийЭлемент - см. Предикат
// * ИмяРеквизита - Строка
Функция НовыйКонтекст()
	
	Описание = Новый Структура();
	Описание.Вставить("Предикаты", Новый Массив());
	Описание.Вставить("ТекущийЭлемент");
	Описание.Вставить("ИмяРеквизита");
	
	Возврат Описание;
	
КонецФункции

Процедура ДобавитьПредикат(ВидСравнения, Значение)
	
	Контекст = Контекст();
	
	Предикат = ЮТФабрика.ВыражениеПредиката(ВидСравнения, Контекст.ИмяРеквизита, Значение);
	Контекст.Предикаты.Добавить(Предикат);
	
КонецПроцедуры

#КонецОбласти
