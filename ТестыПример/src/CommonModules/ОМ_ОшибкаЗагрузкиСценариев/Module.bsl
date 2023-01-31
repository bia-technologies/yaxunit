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
// Набор тестов для общего модуля СтроковыеФункцииКлиентСервер
///////////////////////////////////////////////////////////////////////////////// 

/////////////////////////////////////////////////////////////////////////////////
// Набор стандартных методов тестового модуля
/////////////////////////////////////////////////////////////////////////////////

#Область ТестыAPI

// ИсполняемыеСценарии
// 	Сервисный метод для получения списка тестовых методов
// Параметры:
// 	ДополнительныеПараметры - Структура - Дополнительные параметры, используемые при формировании списка тестов
// Возвращаемое значение:
// 	Массив - Имена методов тестов
Процедура ИсполняемыеСценарии(ДополнительныеПараметры = Неопределено) Экспорт
	
	Возврат; // TODO Реанимировать после реализации проброса доп параметров
	// Добавление теста в тестовый набор по умолчанию с указанием представления теста
	ЮТТесты.ДобавитьТест("ТестовыйМетод3", "Тестовый метод 3");
	// Добавление теста для клиента в тестовый набор по умолчанию
	ЮТТесты.ТестКлиент("ТестовыйМетод4");
	// Добавление теста для клиента в тестовый набор по умолчанию
	ЮТТесты.ТестСервер("ТестовыйМетод4");
	
	ЮТТесты.ТестовыйНабор("ТестовыйНабор")
		.ДобавитьТест("ТестовыйМетод")
		.ДобавитьТест("ТестовыйМетод2")
		.ДобавитьТест("ТестовыйМетод5", , "Тег1");
	
	// Создание тестового набора со списком тегов
	ЮТТесты.ТестовыйНабор("Тестовый набор 2", "Тег1, Тег2")
	
	// Добавление теста в созданный тестовый набор с указанием тегов, которые будут объединены с тегами набора
	.ДобавитьТест("ТестовыйМетод6", , "Тег5, Тег6");
	
	ВызватьИсключение "Ошибка загрузки сценариев";
	
КонецПроцедуры

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Реализация тестов
/////////////////////////////////////////////////////////////////////////////////

#Область Тесты

#КонецОбласти
