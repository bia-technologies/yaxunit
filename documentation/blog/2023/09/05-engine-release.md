---
title: YaxUnit. Версия 23.08
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 23.08](https://github.com/bia-technologies/yaxunit/releases/tag/23.08)

## Новое в версии

### Тестовые данные

* Загрузка данных из табличного документа или таблицы markdown [#133](https://github.com/bia-technologies/yaxunit/issues/133), [документация](https://bia-technologies.github.io/yaxunit/docs/features/test-data/#%D0%B7%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%BA%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85-%D0%B8%D0%B7-%D0%BC%D0%B0%D0%BA%D0%B5%D1%82%D0%BE%D0%B2). Спасибо [@dlyubanevich](https://github.com/dlyubanevich)
* Добавить возможность указывать тип фикции [#121](https://github.com/bia-technologies/yaxunit/issues/121)
* Добавить возможность получать случайное значение перечисления [#132](https://github.com/bia-technologies/yaxunit/issues/132)
* Тестовые данные, добавить метод СлучайныйИдентификатор [#102](https://github.com/bia-technologies/yaxunit/issues/102)

### Утверждения

* Добавить в ассерты и предикаты поддержку проверки по регулярному выражению [#138](https://github.com/bia-technologies/yaxunit/issues/138). Спасибо [@Daabramov](https://github.com/Daabramov)

### Прочее

* Запуск и перезапуск тестов из предприятия [#49](https://github.com/bia-technologies/yaxunit/issues/49), [документация](https://bia-technologies.github.io/yaxunit/docs/yaxunit-ui)
* Пауза [#136](https://github.com/bia-technologies/yaxunit/issues/136)
* Унифицированный механизм подключения внешних компонент - тихая установка, работа с отключенными синхронными вызовами.

### CI

* Github CI, реализовано автотестирование движка под windows и linux [#142](https://github.com/bia-technologies/yaxunit/pull/142)
* Вывод лога выполнения тестирования в консоль [#144](https://github.com/bia-technologies/yaxunit/issues/144)

## Исправленные ошибки

### Прочее

* Подтягиваются глобальные общие модули [#148](https://github.com/bia-technologies/yaxunit/pull/148). Спасибо [@SeiOkami](https://github.com/SeiOkami)
* Исправлены выявленные ошибки [#130](https://github.com/bia-technologies/yaxunit/pull/130). Спасибо [@potoyalo](https://github.com/potoyalo)
