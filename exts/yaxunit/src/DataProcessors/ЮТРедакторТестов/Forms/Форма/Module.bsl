//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
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

#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
//	Данные = ПолучитьОбщийМакет("ЮТMonacoEditor");
//	ЧтениеZip = Новый ЧтениеZipФайла(Данные.ОткрытьПотокДляЧтения);
//	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
//	ЧтениеZip.Извлечь(ЧтениеZip.Элементы[0], ИмяВременногоФайла);
//	Данные = Новый ДвоичныеДанные(ИмяВременногоФайла);
//	УдалитьФайлы(ИмяВременногоФайла);
//	
//	EditorURL = ПолучитьНавигационнуюСсылкуИнформационнойБазы() + "/" + ПоместитьВоВременноеХранилище(Данные, УникальныйИдентификатор);
	EditorURL = "/home/alko/develop/open-source/yaxunit-console/dist/index.html";
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиКомандФормы

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
