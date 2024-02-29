---
title: YaxUnit. Версия 23.07
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 23.07](https://github.com/bia-technologies/yaxunit/releases/tag/23.07)

## Новое в версии

### Тестовые данные

* Faker for YaxUnit (Генерация валидных бизнес), [#88](https://github.com/bia-technologies/yaxunit/issues/88), [#80](https://github.com/bia-technologies/yaxunit/issues/80). Спасибо [@Daabramov](https://github.com/Daabramov)

### Запросы

* Добавлены новые методы модуля ЮТЗапросы, [#122](https://github.com/bia-technologies/yaxunit/pull/122). Спасибо [@potoyalo](https://github.com/potoyalo)

### Прочее

* Переопределение обработчиков событий тестового модуля, [#124](https://github.com/bia-technologies/yaxunit/pull/124). Спасибо [@potoyalo](https://github.com/potoyalo)
* Необязательное значение дополнительного свойства  [#106](https://github.com/bia-technologies/yaxunit/pull/106). Спасибо [@alexandr-yang](https://github.com/alexandr-yang)
* В репозиторий добавлена конфигурация для прогона тестов, [#123](https://github.com/bia-technologies/yaxunit/pull/123)

## Исправленные ошибки

### Мокито

* Исправлена ошибка определения предикатов при обучении, [#108](https://github.com/bia-technologies/yaxunit/issues/108). Спасибо [@dlyubanevich](https://github.com/dlyubanevich)
* Исправлена ошибка анализа количества вызовов мокируемого метода, [#118](https://github.com/bia-technologies/yaxunit/pull/118)
* Исправлена ошибка при мокировании метода вызываемого при установке параметров сеанса, [#116](https://github.com/bia-technologies/yaxunit/issues/116)

### Утверждения

* Исправлена ошибка проверки равенства значения соответствия, если ключом соответствия является не строка, [#114](https://github.com/bia-technologies/yaxunit/issues/114). Спасибо [@alexandr-yang](https://github.com/alexandr-yang)