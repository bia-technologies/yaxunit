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

// @strict-types

#Область ПрограммныйИнтерфейс

// Локализация.
//
// Возвращаемое значение:
//  Строка - Возвращает текущую установленную локализацию
Функция Локализация() Экспорт
	Возврат ЮТПодражательСлужебный.Контекст().Локализация;
КонецФункции

// Устанавливает локализацию подражателя
// В дальнейшем используется для получения списка словарей с указанной локализацией
// Параметры:
//  КодЯзыка - Строка - Код языка
Процедура УстановитьЛокализацию(КодЯзыка) Экспорт
	ЮТПодражательСлужебный.Контекст().Локализация = КодЯзыка;
КонецПроцедуры

#Область Реализации

Функция Люди() Экспорт
	Возврат ЮТПодражатель_Люди;
КонецФункции

Функция Компании() Экспорт
	Возврат ЮТПодражатель_Компании;
КонецФункции

Функция Банки() Экспорт
	Возврат ЮТПодражатель_Банки;
КонецФункции

#КонецОбласти

#КонецОбласти
