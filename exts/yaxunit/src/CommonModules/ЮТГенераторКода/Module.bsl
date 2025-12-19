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

// Параметры генерации кода.
// 
// Возвращаемое значение:
//  Структура - Параметры генерации кода:
// * ПропускатьПустыеЗначения - Булево - 
// * ИспользоватьПоиск - Булево - 
// * ИспользоватьПеременные - Булево - 
// * ИспользоватьКомментарии - Булево - 
Функция ПараметрыГенерацииКода() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("ПропускатьПустыеЗначения", Истина);
	Параметры.Вставить("ИспользоватьПоиск", Истина);
	Параметры.Вставить("ИспользоватьПеременные", Истина);
	Параметры.Вставить("ИспользоватьКомментарии", Истина);
	
	Возврат Параметры;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
