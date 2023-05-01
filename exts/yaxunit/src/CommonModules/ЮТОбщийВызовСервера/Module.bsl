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

Функция ОписаниеТиповЛюбаяСсылка() Экспорт
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(
	"<TypeDescription xmlns=""http://v8.1c.ru/8.1/data/core"">
	|      <TypeSet xmlns:cc=""http://v8.1c.ru/8.1/data/enterprise/current-config"">cc:AnyRef</TypeSet>
	|</TypeDescription>");
	
	Возврат СериализаторXDTO.ПрочитатьXML(ЧтениеXML);

КонецФункции

Функция УстановленБезопасныйРежим() Экспорт
	
	Возврат БезопасныйРежим();
	
КонецФункции

Функция Менеджер(Знач Менеджер) Экспорт
	
	Если ТипЗнч(Менеджер) = Тип("Строка") Тогда
		Менеджер = ЮТОбщий.ВычислитьБезопасно(Менеджер);
	КонецЕсли;
	
	Возврат Менеджер;
	
КонецФункции

#КонецОбласти
