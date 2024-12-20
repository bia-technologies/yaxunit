# Вариативность выполнения тестов

Вариативность выполнения тестов — это мощная возможность, которая позволяет выполнять один и тот же тест (алгоритм проверки) с различными наборами входных данных. Это упрощает написание и поддержку тестов, а также повышает их эффективность за счет автоматизации проверки различных сценариев.

## Параметризированные тесты

Параметризированные тесты позволяют разработчикам определять тестовые сценарии, которые будут выполняться с разными наборами параметров.
Это особенно полезно для проверки функциональности, которая зависит от входных данных, таких как различные типы значений, структуры данных, справочники и другие объекты.

### Синтаксис и использование

Для создания параметризированного теста необходимо:

1. **Определить тестовый сценарий**: Создать процедуру, которая будет выполнять тест. Эта процедура должна принимать параметры, которые будут передаваться при каждом вызове теста.
2. **Добавить тест в список исполняемых сценариев**: Использовать метод [`.ДобавитьТест()`](/api/ЮТТесты#добавитьтест) для добавления тестового сценария в список исполняемых тестов.
3. **Указать параметры для каждого вызова теста**: Использовать метод [`.СПараметрами()`](/api/ЮТТесты#спараметрами) для передачи набора параметров, с которыми будет выполняться тест.

### Пример использования

```bsl
Процедура ИсполняемыеСценарии() Экспорт

    Массив = ЮТКоллекции.ЗначениеВМассиве(1, 2, "3");
    Структура = Новый Структура("Строка, Число, Массив", "1", 1, Массив);
    
    ЮТТесты
        .ДобавитьТест("ЗначенияРавны")
            .СПараметрами(1, 1, Истина)
            .СПараметрами("1", 1, Ложь)
            .СПараметрами("1", 1, Ложь)
            .СПараметрами(Массив, Массив, Истина)
            .СПараметрами(Массив, ЮТКоллекции.ЗначениеВМассиве(1, 2, 3), Ложь)
            .СПараметрами(Структура, Структура, Истина)
            .СПараметрами(Структура, Новый Структура("Строка, Число, Массив", "1", 1, "Массив"), Ложь)
    ;
    
КонецПроцедуры

Процедура ЗначенияРавны(Значение1, Значение2, ОжидаемыйРезультат) Экспорт

    Результат = ЮТСравнениеСлужебныйКлиентСервер.ЗначенияРавны(Значение1, Значение2);
    ЮТест.ОжидаетЧто(Результат)
        .Равно(ОжидаемыйРезультат);

КонецПроцедуры
```

#### Пояснение к примеру

1. **Процедура `ИсполняемыеСценарии`**:
   * В этой процедуре создаются массив и структура, которые будут использоваться в качестве параметров для тестов.
   * Тестовый сценарий `ЗначенияРавны` добавляется в список исполняемых тестов с помощью метода [`.ДобавитьТест()`](/api/ЮТТесты#добавитьтест).
   * Для каждого вызова теста указываются различные параметры с помощью метода [`.СПараметрами()`](/api/ЮТТесты#спараметрами). Каждый набор параметров включает два значения для сравнения и ожидаемый результат сравнения.

2. **Процедура `ЗначенияРавны`**:
   * Это тестовый сценарий, который принимает три параметра: `Значение1`, `Значение2` и `ОжидаемыйРезультат`.
   * Внутри процедуры проверяется, равны ли `Значение1` и `Значение2`, используя метод `ЮТСравнениеСлужебныйКлиентСервер.ЗначенияРавны()`.
   * Результат сравнения передается в метод `ЮТест.ОжидаетЧто()`, который проверяет, что результат сравнения соответствует `ОжидаемыйРезультат`.

## Варианты выполнения тестов

**Варианты выполнения тестов** позволяют динамически формировать различные сценарии выполнения внутри одного теста. Это упрощает создание и поддержку тестов, а также повышает их эффективность за счет проверки различных вариантов входных данных и условий.

### Возможности

* **Определение вариантов:**
  * Варианты выполнения могут быть определены с помощью метода [`ЮТест.Варианты()`](/api/ЮТКонструкторВариантов), который принимает строку с именами параметров и результатов.
  * Для каждого варианта можно добавить набор значений параметров и ожидаемых результатов с помощью метода [`.Добавить()`](/api/ЮТКонструкторВариантов#добавить).
  * Можно добавить варианты всех возможных значений используя метод [`ДобавитьКомбинации()`](/api/ЮТКонструкторВариантов#добавитькомбинации). Он автоматически создает все возможные комбинации значений для указанных параметров, упрощая проверку различных сценариев входных данных. Для каждой комбинации значений создается отдельный вариант выполнения теста.
  * Поддерживаются различные типы данных параметров и результатов: строки, числа, даты, булевы значения, ссылки на объекты метаданных, типы данных и т.д.

### Пример использования вариантов выполнения

```bsl
Процедура Менеджер() Экспорт

    Варианты = ЮТест.Варианты("Параметр, Результат")
        .Добавить("Справочник.Товары", Справочники.Товары)
        .Добавить("Справочники.Товары", Справочники.Товары)
        .Добавить(Справочники.Товары, Справочники.Товары)
        .Добавить(Справочники.Товары.ПустаяСсылка(), Справочники.Товары)
        .Добавить(Тип("СправочникМенеджер.Товары"), Справочники.Товары)
        .Добавить(Тип("СправочникСсылка.Товары"), Справочники.Товары)
        .Добавить(ЮТМетаданные.ОписаниеОбъектаМетаданных("Справочник.Товары"), Справочники.Товары)
        .Добавить("РегистрыНакопления.Взаиморасчеты", РегистрыНакопления.Взаиморасчеты)
    ;

    Для Каждого Вариант Из Варианты.СписокВариантов() Цикл
        
        Описание = СтрШаблон("%1 (%2)", Вариант.Параметр, ТипЗнч(Вариант.Параметр));
        ЮТест.ОжидаетЧто(ЮТОбщий.Менеджер(Вариант.Параметр), Описание)
            .Равно(Вариант.Результат);
        
    КонецЦикла;

КонецПроцедуры
```

#### Пояснение к примеру использования вариантов выполнения

1. **Определение вариантов:**
    * Создается объект `Варианты` с помощью метода [`ЮТест.Варианты()`](/api/ЮТКонструкторВариантов), который определяет два параметра: `Параметр` и `Результат`.
    * Для каждого варианта выполнения добавляется набор значений параметров и ожидаемых результатов с помощью метода [`.Добавить()`](/api/ЮТКонструкторВариантов#добавить).
2. **Использование вариантов в тесте:**
    * В цикле `Для Каждого Вариант Из Варианты.СписокВариантов() Цикл` происходит перебор всех вариантов выполнения.
    * Для каждого варианта формируется описание с помощью функции `СтрШаблон()`, которое будет использоваться при возникновении ошибки.
    * Вызывается метод `ЮТОбщий.Менеджер()` с параметром `Вариант.Параметр` и проверяется, что результат равен `Вариант.Результат` с помощью метода `ЮТест.ОжидаетЧто().Равно()`.

### Пример использования комбинаций значений параметров

```bsl
Процедура ФормированиеДокумента() Экспорт

    // Получаем все значения перечислений для видов операций и видов контрагентов
    ВидыОпераций = ЗначенияПеречисления(Перечисление.ВидыОперацийДокумента);
    ВидыКонтрагентов = ЗначенияПеречисления(Перечисление.ВидыКонтрагентов);

    // Создаем варианты выполнения, добавляя все возможные комбинации значений
    Варианты = ЮТест.Варианты("ВидОперации, ВидКонтрагента")
        .ДобавитьКомбинации(ВидыОпераций, ВидыКонтрагентов);

    // Перебираем все варианты выполнения
    Для Каждого Вариант Из Варианты.СписокВариантов() Цикл
        
        // Формируем описание текущего варианта
        Описание = СтрШаблон("Вид операции: %1; вид контрагента: %2", Вариант.ВидОперации, Вариант.ВидКонтрагента);

        // Выполняем проверку документа с текущими значениями параметров
        Результат = ПроверитьДокумент(Вариант.ВидОперации, Вариант.ВидКонтрагента);

        // Проверяем, что результат проверки является истиной
        ЮТест.ОжидаетЧто(Результат, Описание)
            .ЭтоИстина();
        
    КонецЦикла;
    
КонецПроцедуры
```

#### Пояснение к примеру использования комбинаций значений параметров

1. **Получение значений перечислений:**
    * Создаются массивы значений для двух перечислений: `ВидыОпераций` и `ВидыКонтрагентов`.
2. **Генерация комбинаций значений параметров:**
    * Метод [`ДобавитьКомбинации()`](/api/ЮТКонструкторВариантов#добавитькомбинации) добавляет все возможные комбинации значений этих перечислений в объект `Варианты`.
3. **Перебор вариантов выполнения:**
    * В цикле `Для Каждого Вариант Из Варианты.СписокВариантов() Цикл` происходит перебор всех сгенерированных комбинаций.
4. **Формирование описания и проверка результата:**
    * Для каждого варианта формируется описание с помощью функции `СтрШаблон()`.
    * Вызывается функция `ПроверитьДокумент()` с параметрами `Вариант.ВидОперации` и `Вариант.ВидКонтрагента`, и проверяется, что результат является истиной с помощью метода `ЮТест.ОжидаетЧто().ЭтоИстина()`.

## Различия в подходах и кейсах использования

* Параметризированные тесты являются предпочитаемым вариантом
  * Для каждой комбинации значений параметров формируется отдельная запись отчет, в котором указываются использованные значения параметров и результаты проверки.
  * Падения теста на одном из вариантов не влияет на другие.
  * Каждая комбинация выполняется как полноценный отдельный тест.

## Преимущества использования вариативности в тестах

* **Универсальность**: Один тест может проверять множество различных сценариев, что уменьшает количество кода и упрощает поддержку.
* **Гибкость**: Легко добавлять новые сценарии, просто передавая новые параметры.
* **Повторяемость**: Тесты могут быть легко повторены с разными наборами данных, что улучшает покрытие тестами.

## Заключение

Параметризированные тесты и варианты — это мощные инструменты для автоматизации и упрощения процесса модульного тестирования в 1С:Предприятии. Использование этих возможностей позволяет разработчикам создавать более гибкие и надежные тесты, которые могут быть легко адаптированы к различным сценариям и условиям.
