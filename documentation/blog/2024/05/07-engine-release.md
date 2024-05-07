---
title: YaxUnit. Версия 24.04
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 24.04](https://github.com/bia-technologies/yaxunit/releases/tag/24.04)

## Новое в версии

### Тестовые данные

* [NEW] Метод `УстановитьСсылкуНового` в конструкторе объектов [#310](https://github.com/bia-technologies/yaxunit/issues/310), спасибо [@alexandr-yang](https://github.com/alexandr-yang)
* Удаление тестовых данных без учета прав [#309](https://github.com/bia-technologies/yaxunit/issues/309), спасибо [@goodwinvu](https://github.com/goodwinvu)

### Зависимости

* [NEW] Зависимости тестов [#314](https://github.com/bia-technologies/yaxunit/issues/314)
* [NEW] Добавить возможность указывать рабочий каталог в параметрах запуска [#313](https://github.com/bia-technologies/yaxunit/issues/313)
* [NEW] Зависимости тестов. Фабрика XDTO [#322](https://github.com/bia-technologies/yaxunit/issues/322)

Подробнее о зависимостях вы можете узнать из [документации](/docs/features/dependencies)

### Прочее

* Рефакторинг механизма событий [#315](https://github.com/bia-technologies/yaxunit/issues/315)  
  Добавлена возможность создавать обработчики событий за пределами расширения движка, подробнее в [документации](docs/features/events)
* Добавлен шаблон PR

## Исправленные ошибки

* [Bug]: Не работает формат выбода ошибки HTML на Mac [#319](https://github.com/bia-technologies/yaxunit/issues/319), спасибо [@alexandr-yang](https://github.com/alexandr-yang)
* Мелкие исправления в документации [#320](https://github.com/bia-technologies/yaxunit/issues/320), спасибо [@alexandr-yang](https://github.com/alexandr-yang)
* [Bug]: Некорректное время результатов тестов в отчете формата allure, спасибо [@AlexPCRus](https://github.com/AlexPCRus)
