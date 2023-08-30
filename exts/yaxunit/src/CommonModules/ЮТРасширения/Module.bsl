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

#Область СлужебныйПрограммныйИнтерфейс

Функция ГенераторыОтчетов() Экспорт
	
	Возврат МодулиПодсистемы("ЮТФормированиеОтчета");
	
КонецФункции

Функция ОбработчикиСобытий() Экспорт
	
	Серверные = Ложь;
	Клиентские = Ложь;
#Если Сервер Тогда
	Серверные = Истина;
#КонецЕсли

#Если Клиент Тогда
	Клиентские = Истина;
#КонецЕсли
	
	Возврат ЮТМетаданные.МодулиПодсистемы("ЮТОбработчикиСобытий", Серверные, Клиентские);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция МодулиПодсистемы(ИмяПодсистемы)
	
	ИменаМодулей = ЮТМетаданные.МодулиПодсистемы(ИмяПодсистемы);
	
	Модули = Новый Массив();
	
	Для Каждого ИмяМодуля Из ИменаМодулей Цикл
		
		Модуль = ЮТОбщий.Модуль(ИмяМодуля);
		Модули.Добавить(Модуль);
		
	КонецЦикла;
	
	Возврат Модули;
	
КонецФункции

#КонецОбласти
