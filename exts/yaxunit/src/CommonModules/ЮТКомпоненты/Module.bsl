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

Функция Пауза() Экспорт
	
	Возврат ЮТКомпонентыСлужебный.СоздатьКомпоненту(ОписаниеКомпонентыПауза());
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОписаниеКомпонентыПауза() Экспорт
	
	Возврат ОписаниеКомпоненты("ОбщийМакет.ЮТYaxUnitAddIn", "YaxUnitAddin", "Sleep");
	
КонецФункции

Функция ОписаниеКомпоненты(ИмяМакета, ИмяКомпоненты, ИмяКласса)
	
	Описание = Новый Структура;
	Описание.Вставить("ИмяМакета", ИмяМакета);
	Описание.Вставить("ИмяКомпоненты", ИмяКомпоненты);
	Описание.Вставить("ИмяКласса", СтрШаблон("AddIn.%1.%2", ИмяКомпоненты, ИмяКласса));
	
	Возврат Новый ФиксированнаяСтруктура(Описание);
	
КонецФункции

#КонецОбласти
