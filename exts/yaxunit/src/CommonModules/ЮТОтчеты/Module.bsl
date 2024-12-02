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

#Область ПрограммныйИнтерфейс

Функция СвойстваAllure() Экспорт
	
	Свойства = Новый Структура;
	
	Свойства.Вставить("Идентификатор", "testCaseId");
	Свойства.Вставить("Описание", "description");
	Свойства.Вставить("ОписаниеHTML", "descriptionHtml");
	Свойства.Вставить("Критичность", "severity");
	Свойства.Вставить("Владелец", "owner");
	
	Возврат Свойства;
	
КонецФункции

#КонецОбласти
