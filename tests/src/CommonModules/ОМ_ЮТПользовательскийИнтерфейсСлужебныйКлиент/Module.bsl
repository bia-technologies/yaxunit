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

#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ДобавитьТест("ФильтрФайлаНастроек")
	;
	
КонецПроцедуры

// Проверяет корректность фильтра выбора файла настроек.
//
// Формат фильтра диалога выбора файла — "Описание|Маска". Без разделителя "|" диалог не
// отбирает файлы по маске, а при описании, равном маске, вместо человекочитаемого названия
// показывает саму маску (см. #659).
Процедура ФильтрФайлаНастроек() Экспорт
	
	Фильтр = ЮТПользовательскийИнтерфейсСлужебныйКлиент.ФильтрФайлаНастроек();
	ЧастиФильтра = СтрРазделить(Фильтр, "|", Ложь);
	
	ЮТест.ОжидаетЧто(ЧастиФильтра, "Фильтр выбора файла настроек (#659) должен содержать маску *.json")
		.Содержит("*.json");
	ЮТест.ОжидаетЧто(ЧастиФильтра[0], "Описание фильтра не должно совпадать с маской")
		.НеРавно("*.json");
	
КонецПроцедуры

#КонецОбласти
