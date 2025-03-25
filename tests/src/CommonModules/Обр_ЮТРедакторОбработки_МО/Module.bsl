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
		.ДобавитьТест("ЗагрузитьШаблон")
		.ДобавитьТест("СформироватьОбработку")
	;
	
КонецПроцедуры

Процедура ЗагрузитьШаблон() Экспорт
	
	Редактор = Обработки.ЮТРедакторОбработки.Создать();
	Редактор.ЗагрузитьШаблон();
	ФайлыОбработки = Редактор.ФайлыОбработки();
	ЮТест.ОжидаетЧто(ФайлыОбработки)
		.ИмеетТип("Массив")
		.ИмеетДлину(8)
	;
	
КонецПроцедуры

Процедура СформироватьОбработку() Экспорт
	
	Редактор = Обработки.ЮТРедакторОбработки.Создать();
	Редактор.ЗагрузитьШаблон();
	Результат = Редактор.СформироватьОбработку();
	
	ЮТест.ОжидаетЧто(Результат)
		.ИмеетТип("ДвоичныеДанные")
	;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
