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

///////////////////////////////////////////////////////////////////
// ПрограммныйИнтерфейс
// Экспортные процедуры и функции для прикладного использования 
/////////////////////////////////////////////////////////////////// 
#Область ПрограммныйИнтерфейс

Функция СсылкаСуществует(Знач Ссылка) Экспорт
	
	ИмяТаблицы = Ссылка.Метаданные().ПолноеИмя();
	
	ТекстЗапроса = СтрШаблон("ВЫБРАТЬ ПЕРВЫЕ 1 1 ИЗ %1 ГДЕ Ссылка = &Ссылка", ИмяТаблицы);
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Возврат НЕ Запрос.Выполнить().Пустой();
	
КонецФункции

Функция СоздатьКопию(Знач Значение) Экспорт
	
	Возврат ЗначениеИзСтрокиВнутр(ЗначениеВСтрокуВнутр(Значение));
	
КонецФункции

#КонецОбласти
