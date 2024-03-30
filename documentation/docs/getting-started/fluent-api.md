# Текучий интерфейс

Большая часть публичной функциональности тестового движка YAxUnit реализована с использование [`текучих выражений (Fluent interface)`](https://ru.wikipedia.org/wiki/Fluent_interface)

Основная цель их использования - улучшение читаемости кода и упрощение работы с движком. Текучие выражения хорошо зарекомендовали себя и широко применяются в других языках (примеры: [C#: builder pattern](https://metanit.com/sharp/patterns/6.1.php), [java: stream-api](https://javarush.com/groups/posts/2203-stream-api), [php: dsl](https://ru.hexlet.io/courses/php-object-oriented-design/lessons/fluent-interface/theory_unit), [C#: tests assertions](https://fluentassertions.com/introduction), [1С: текучие утверждения](https://habr.com/ru/articles/260013/), [1С: Элемент](https://its.1c.ru/db/pubelementlang/content/18/hdoc), [1С: объектная модель запроса](https://infostart.ru/1c/articles/1991009/)).
Текучие выражения - это цепочка методов, объединенных одним контекстом, который они настраивают/обрабатывают. Он упрощает множественные вызовы методов одного и того же объекта.
Например:

```bsl title="Создание документа с использованием текучих выражений"
    Документ = ЮТест.Данные().КонструкторОбъекта(Документы.ПриходТовара)
        .Установить("Поставщик", Поставщик)       // Устанавливает значение реквизита документа.
        .Фикция("Дата")                           // Генерирует случайную дату.
        .Фикция("Номер")                          // Генерирует случайный номер.
        .Фикция("Склад")                          // Создает "пустышку" склада.
        .Фикция("Валюта")                         // Создает "пустышку" валюты.
        .ТабличнаяЧасть("Товары")                 // Переключает контекст на работу с табличной частью "Товары".
            .ДобавитьСтроку()                     // Добавляет строку табличной части.
            .Фикция("Товар", Новый Структура("Поставщик", Поставщик)) // Создает "пустышку" товары от конкретного поставщика.
            .Фикция("Цена")                       // Генерирует случайную цену.
        .Провести();
```

```bsl title="Проверка документа с использованием текучих выражений"
    ЮТест.ОжидаетЧто(Документ)
        .Свойство("Дата").Заполнено()             // Проверяет, что дата документа заполнена.
        .Свойство("Номер").Заполнено()            // Проверяет, что номер документа заполнен.
        .Свойство("Склад").Заполнено()            // Проверяет, что склад документа заполнен.
        .Свойство("Валюта").Заполнено()           // Проверяет, что валюта документа заполнена.
        .Свойство("Товары").ИмеетДлину(1)         // Проверяет, что табличная часть "Товары" имеет длину 1.
        .Свойство("Товары[0].Товар").Заполнено()  // Проверяет, что товар из первой строки заполнен
        .Свойство("Товары[0].Товар.Поставщик").Равно(Поставщик); // и имеет поставщика, равного нужному
```

Примеры выше можно было бы реализовать без использования текучих выражений, например:

```bsl title="Создание документа с заполнением случайных значений"
Документ = Документы.ПриходТовара.СоздатьДокумент();
Документ.Поставщик = Поставщик;
Документ.Дата = ЮТест.Данные().СлучайнаяДата();
Документ.Номер = ЮТест.Данные().СлучайнаяСтрока();
Документ.Склад = ЮТест.Данные().Фикция(Тип("СправочникСсылка.Склад"));
Документ.Валюта = ЮТест.Данные().Фикция(Тип("СправочникСсылка.Валюты"));

СтрокаТовары = Документ.Товары.Добавить();
СтрокаТовары.Товар = ЮТест.Данные().Фикция(Тип("СправочникСсылка.Товары"), Новый Структура("Поставщик", Поставщик));
СтрокаТовары.Цена = ЮТест.Данные().СлучайноеПоложительноеЧисло();

Документ.Записать(РежимЗаписиДокумента.Проведение);
Ссылка = Документ.Ссылка;
```

```bsl title="Или вариант используя конструктора, но без цепочки вызовов"
Конструктор = ЮТест.Данные().КонструкторОбъекта(Документы.ПриходТовара);
Конструктор.Установить("Поставщик", Поставщик);
Конструктор.Фикция("Дата");
Конструктор.Фикция("Номер");
Конструктор.Фикция("Склад");
Конструктор.Фикция("Валюта");
Конструктор.ТабличнаяЧасть("Товары");
Конструктор.ДобавитьСтроку();
Конструктор.Фикция("Товар", Новый Структура("Поставщик", Поставщик));
Конструктор.Фикция("Цена");
Документ = Конструктор.Провести();
```

Первый вариант (с использованием текучих выражений) не содержит "служебного" кода (обращения к документу или конструктору), таким образом концентрация полезного кода выше, меньше отвлекающих факторов и больше акцент на то, что действительно важно.

Но при этом текучие выражения имеют и ряд минусов:

* Проблема с отладкой, нельзя поставить точку внутри цепочки, только проход по шагам.
* Не работает контекстная подсказка в конфигураторе (хотя она и так редко работает).
* Необходимость привычки и использовать "правильное" форматирование (отступы).

## Принцип работы текучих выражений в YAxUnit

Текучие выражения работают за счет передачи контекста между вызовами, достигается это тем, что объект, реализующий интерфейс текучих выражений:

* хранит внутри себя контекст(состояние)
* возвращает сам себя из методов
* или новый объект, передав в него текущий контекст.

В языках, поддерживающих ООП, под каждый текучий интерфейс создается свой класс, хранящий контекст и предоставляющий необходимый API. В 1С это можно реализовать в виде набора обработок.
Таким образом в YAxUnit созданы:

* Конструктор объектов информационной базы, `ЮТест.Данные().КонструкторОбъекта`.
* Конструктор объектов XDTO, `ЮТест.Данные().КонструкторОбъектаXDTO`.
* Эмулятор выборки данных ADO.RecordSet, `ЮТест.Данные().ADORecordSet`.
* Эмулятор запроса к http сервису, `ЮТест.Данные().HTTPСервисЗапрос`.

А есть, другая часть API построенная на текучих выражения, она реализуется через общие модули и хранение состояния в глобальном контексте.  
Общие модули позволяют, в отличии от обработок:

* создавать API доступный и на клиенте, и на сервере
* избежать дублирования кода, который приводи к расхождению логики api
* не захламлять контекстную подсказку свойствами обработки (или формы для клиента)
* оптимизировать время работы (нет затрат на создание обработок)

Дополнительно, так как контекст глобальный, не обязательно передавать объект, чтобы получить доступ к настроенному контексту.  
Например:

* При регистрации теста, информация о тестах никуда не возвращается, движок, после вызова метода `ИсполняемыеСценарии`, просто считывает результат из глобального контекста.
* Или настройки мокито, выполненные в методе теста сразу же доступны в методах других модулей (перехватываемых).