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

#Если Сервер Тогда

#Область ОписаниеПеременных

//@skip-check object-module-export-variable
Var HTTPMethod Export;
//@skip-check object-module-export-variable
Var BaseURL Export;
//@skip-check object-module-export-variable
Var Headers Export;
//@skip-check object-module-export-variable
Var RelativeURL Export;
//@skip-check object-module-export-variable
Var URLParameters Export;
//@skip-check object-module-export-variable
Var QueryOptions Export;

Var Body;

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Возвращает тело как двоичные данные.
// 
// Возвращаемое значение:
//  ДвоичныеДанные - Тело
Function GetBodyAsBinaryData() Export
	
	BodyType = TypeOf(Body);
	
	If Body = Undefined Then
		Return GetBinaryDataFromBase64String("");
	ElsIf BodyType = Type("BinaryData") Then
		Return Body;
	ElsIf BodyType = Type("String") Then
		Return GetBinaryDataFromString(Body);
	EndIf;
	
EndFunction

// Возвращает тело как поток.
// 
// Возвращаемое значение:
//  Поток - Тело
Function GetBodyAsStream() Export
	
	Return GetBodyAsBinaryData().OpenStreamForRead();
	
EndFunction

// Возвращает тело как строку.
// 
// Параметры:
//  Encoding - КодировкаТекста, Строка - Кодировка
// 
// Возвращаемое значение:
//  Строка - Тело
Function GetBodyAsString(Encoding = Undefined) Export
	
	BodyType = TypeOf(Body);
	
	If Body = Undefined Then
		Return "";
	ElsIf BodyType = Тип("BinaryData") Then
		Return GetStringFromBinaryData(Body, Encoding);
	ElsIf BodyType = Тип("String") Then
		Return Body;
	EndIf;
	
EndFunction

// Устанавливает тело как двоичные данные.
// При получении тела в другом формате происходит конвертация
// 
// Параметры:
//  Data - ДвоичныеДанные
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function УстановитьТелоКакДвоичныеДанные(Data) Export
	
	Body = Data;
	Return ThisObject;
	
EndFunction

// Устанавливает тело как строку.
// При получении тела в другом формате происходит конвертация
// 
// Параметры:
//  String - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function УстановитьТелоКакСтроку(String) Export
	
	Body = String;
	Return ThisObject;
	
EndFunction

// Устанавливает тело как строку JSON.
// Сериализует переданный объект в строку JSON и сохраняет в тело
// При получении тела в другом формате происходит конвертация
// 
// Параметры:
//  Data - Произвольный
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function УстановитьТелоКакСтрокуJSON(Data) Export
	
	JSONWriter = Новый JSONWriter();
	JSONWriter.SetString();
	WriteJSON(JSONWriter, Data);
	
	Body = JSONWriter.Close();
	
	Return ThisObject;
	
EndFunction

// Добавляет заголовок.
// 
// Параметры:
//  HeaderName - Строка
//  Value - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function ДобавитьЗаголовок(HeaderName, Value) Export
	
	Headers.Insert(HeaderName, Value);
	Return ThisObject;
	
EndFunction

// Добавляет параметр запроса.
// 
// Параметры:
//  ParameterName - Строка
//  Value - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function ДобавитьПараметрЗапроса(ParameterName, Value) Export
	
	QueryOptions.Insert(ParameterName, Value);
	Return ThisObject;
	
EndFunction

// Добавляет параметр URL.
// 
// Параметры:
//  ParameterName - Строка
//  Value - Строка
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function ДобавитьПараметрURL(ParameterName, Value) Export
	
	URLParameters.Insert(ParameterName, Value);
	Return ThisObject;
	
EndFunction

// Устанавливает HTTP метод
// 
// Параметры:
//  Value - Строка - Имя http метода
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function Метод(Value) Export
	
	HTTPMethod = Value;
	Return ThisObject;
	
EndFunction

// Устанавливает базовый URL.
// 
// Параметры:
//  Value - Строка - базовый URL
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function БазовыйURL(Value) Export
	
	BaseURL = Value;
	Return ThisObject;
	
EndFunction

// Устанавливает относительный URL.
// 
// Параметры:
//  Value - Строка - относительный URL
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPServiceRequest - Мок
Function ОтносительныйURL(Value) Export
	
	RelativeURL = Value;
	Return ThisObject;
	
EndFunction

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура Initialize()
	
	HTTPMethod = "GET";
	BaseURL = "";
	Headers = New Map();
	RelativeURL = "";
	URLParameters = New Map();
	QueryOptions = New Map();
	
КонецПроцедуры

#КонецОбласти

#Область Инициализация

Initialize();

#КонецОбласти

#КонецЕсли
