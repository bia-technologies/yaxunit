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

Функция ТаблицыРавны(Данные1, Данные2) Экспорт
	
	Если Данные1.Количество() <> Данные2.Количество() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Данные1.Колонки.Количество() <> Данные2.Колонки.Количество() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Каждого Колонка Из Данные1.Колонки Цикл
		Если Данные2.Колонки.Найти(Колонка.Имя) = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли;
		
		Индекс = Данные1.Количество() - 1;
		Пока Индекс >= 0 Цикл
			Если НЕ ЮТСравнениеКлиентСервер.ЗначенияРавны(Данные1[Индекс][Колонка.Имя], Данные2[Индекс][Колонка.Имя]) Тогда
				Возврат Ложь;
			КонецЕсли;
			Индекс = Индекс - 1;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти
