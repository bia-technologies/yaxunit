//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2022 BIA-Technologies Limited Liability Company
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

#Если НЕ (ТонкийКлиент ИЛИ ВебКлиент) Тогда

&Вместо("СохраненныеБезопасныеДанные")
Функция ЮТСохраненныеБезопасныеДанные(Владелец, Знач Ключи) Экспорт
	
	// Собираем параметры в массив
	ПараметрыМетода = Мокито.МассивПараметров(Владелец, Ключи);
	
	// Отправляем данные на анализ
	ПрерватьВыполнение = Ложь;
	Результат = Мокито.АнализВызова(Справочники.ИсточникиДанных, "СохраненныеБезопасныеДанные", ПараметрыМетода, ПрерватьВыполнение);
	
	// Обрабатываем результат анализа
	Если НЕ ПрерватьВыполнение Тогда
		Возврат ПродолжитьВызов(Владелец, Ключи);
	Иначе
		Возврат Результат;
	КонецЕсли;
	
КонецФункции

#КонецЕсли
