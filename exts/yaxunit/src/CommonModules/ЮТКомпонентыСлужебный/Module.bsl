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

Функция СоздатьКомпоненту(ОписаниеКомпоненты) Экспорт
	
	ПодключитьКомпоненту(ОписаниеКомпоненты.ИмяМакета, ОписаниеКомпоненты.ИмяКомпоненты, Истина);
	Возврат Новый (ОписаниеКомпоненты.ИмяКласса);
	
КонецФункции

Функция ПодключитьКомпоненту(ИмяМакета, ИмяКомпоненты, Кэшировать) Экспорт
	
	Если Кэшировать Тогда
		Возврат ЮТПовторногоИспользования.ПодключитьКомпоненту(ИмяМакета, ИмяКомпоненты)
	КонецЕсли;
	
#Если ТонкийКлиент Тогда
	Если НЕ ПодключитьВнешнююКомпоненту(ИмяМакета, ИмяКомпоненты) Тогда
		УстановитьВнешнююКомпоненту(ИмяМакета);
	Иначе
		Возврат Истина;
	КонецЕсли;
#КонецЕсли
	Возврат ПодключитьВнешнююКомпоненту(ИмяМакета, ИмяКомпоненты);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
