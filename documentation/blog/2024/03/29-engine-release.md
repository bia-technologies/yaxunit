---
title: YaxUnit. Версия 24.03
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 24.03](https://github.com/bia-technologies/yaxunit/releases/tag/24.03)

## Новое в версии

### Документация

* Переписана вся [документация](https://bia-technologies.github.io/yaxunit/)
* Включить поиск по документации [#289](https://github.com/bia-technologies/yaxunit/issues/289)

### Тестовые данные

* Добавить методы генерации случайной даты [#269](https://github.com/bia-technologies/yaxunit/issues/269)
* Добавить конструктор объектов для XDTO [#271](https://github.com/bia-technologies/yaxunit/issues/271)
* Метод `ЮТКонструкторТестовыхДанныхСлужебный.Фикция` не работает для общих реквизитов [#218](https://github.com/bia-technologies/yaxunit/issues/218)
* Добавить метод в КонструкторОбъекта для установки реквизитов по коллекции [#249](https://github.com/bia-technologies/yaxunit/issues/249)
* Поддержка записи в режиме обмен данными загрузка для регистров из конструктора объекта [#270](https://github.com/bia-technologies/yaxunit/issues/270)

### Утверждения

* Добавить утверждение/предикат `ВСписке` [#283](https://github.com/bia-technologies/yaxunit/issues/283)

### Прочее

* Добавить возможность задавать разные описания для тестов с параметрами [#276](https://github.com/bia-technologies/yaxunit/issues/276)
* Сбор лога выполнения теста [#282](https://github.com/bia-technologies/yaxunit/issues/282)

## Исправленные ошибки

* Падает с ошибкой создание элемента справочника с настройкой `ОбменДаннымиЗагрузка = Истина` [#273](https://github.com/bia-technologies/yaxunit/issues/273)
* При повторном запуске упавшего теста из Предприятия реального вызова не происходит [#248](https://github.com/bia-technologies/yaxunit/issues/248)
* Исправить описания устаревших методов, чтобы EDT их подсвечивала. [#304](https://github.com/bia-technologies/yaxunit/issues/304)

## Важно

Выполнен **рефакторинг** модулей YAxUnit для физического разделения публичного и служебного программного интерфейса.  
Попытался по максимуму сохранить обратную совместимость.
