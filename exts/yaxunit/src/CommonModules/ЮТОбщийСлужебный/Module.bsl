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

#Область СлужебныйПрограммныйИнтерфейс

// Вычисляет хеш по алгоритму md5.
//
// Параметры:
//  Данные - Строка, ДвоичныеДанные - Данные, для которых необходимо вычислить хеш
//
// Возвращаемое значение:
//  Строка
Функция ХешMD5(Данные) Экспорт
	
	Возврат ЮТОбщийСлужебныйВызовСервера.ХешMD5(Данные);
	
КонецФункции

// Создает массив с переданными значениями
// 
// Параметры:
//  ЗначениеПоУмолчанию - Произвольный - Значение, подставляемое для пропущенных параметров
//  Значение1 - Произвольный
//  Значение2 - Произвольный
//  Значение3 - Произвольный
//  Значение4 - Произвольный
//  Значение5 - Произвольный
//  Значение6 - Произвольный
//  Значение7 - Произвольный
//  Значение8 - Произвольный
//  Значение9 - Произвольный
//  Значение10 - Произвольный
// 
// Возвращаемое значение:
//  Массив из Произвольный - Массив переданных значений
//@skip-check method-too-many-params
// BSLLS:NumberOfOptionalParams-off
// BSLLS:NumberOfParams-off
// BSLLS:DuplicateStringLiteral-off
Функция ЗначениеВМассивеПоУмолчанию(ЗначениеПоУмолчанию,
									Значение1,
									Значение2 = "_!%*",
									Значение3 = "_!%*",
									Значение4 = "_!%*",
									Значение5 = "_!%*",
									Значение6 = "_!%*",
									Значение7 = "_!%*",
									Значение8 = "_!%*",
									Значение9 = "_!%*",
									Значение10 = "_!%*") Экспорт
	
	ФлагПустогоЗначения = "_!%*";
	Значения = Неопределено;
	
	Для Инд = - 10 По - 1 Цикл
		
		//@skip-check server-execution-safe-mode
		Значение = Вычислить("Значение" + ( - Инд)); // BSLLS:ExecuteExternalCodeInCommonModule-off
		
		Если Значение = ФлагПустогоЗначения И Значения = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Если Значения = Неопределено Тогда
			Значения = Новый Массив(- Инд);
		КонецЕсли;
		
		Если Значение = ФлагПустогоЗначения Тогда
			Значение = ЗначениеПоУмолчанию;
		КонецЕсли;
		
		Значения[ - Инд - 1] = Значение;
		
	КонецЦикла;
	
	Возврат Значения;
	
КонецФункции
// BSLLS:DuplicateStringLiteral-on
// BSLLS:NumberOfParams-on
// BSLLS:NumberOfOptionalParams-on

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
