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

// Тестовый модуль для ЮТПодражатель (базовый)

Процедура ИсполняемыеСценарии() Экспорт
    // Регистрация тестов
    ЮТТесты
        .ДобавитьТест("ГенерацияКомпании");
КонецПроцедуры

Процедура ГенерацияКомпании() Экспорт
    // Проверяем, что подражатель может сгенерировать компанию
    Компания = ЮТПодражатель.Компании().Случайная();
    ЮТест.ОжидаетЧто(Компания, "Компания должна быть сгенерирована").Заполнено();
    ЮТест.ОжидаетЧто(Компания).ИмеетСвойство("Наименование");
КонецПроцедуры
