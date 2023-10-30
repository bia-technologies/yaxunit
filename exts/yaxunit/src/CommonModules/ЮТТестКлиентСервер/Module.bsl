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
// Содержит методы создания тестов и тестовых наборов
/////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возврщает идентификатор значения входного параметра по умолчанию.
//
// Возвращаемое значение:
//  Строка
//
// Примеры:
//
// ЮТТесты.ДобавитьТест("Тест1")
// 	.СПараметрами(
// 		ЮТТестКлиентСервер.ПараметрПоУмолчанию(),
// 		2); // Будет зарегистрирован один тест с параметрами <значение по умолчанию>, 2
//
Функция ПараметрПоУмолчанию() Экспорт
	
	Возврат "<[ЗначениеВходногоПараметраПоУмолчанию]>";
	
КонецФункции

#КонецОбласти