---
title: YaxUnit. Версия 23.05
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 23.05](https://github.com/bia-technologies/yaxunit/releases/tag/23.05)

## Новое в версии

### Тестовые данные

* Научили конструктор тестовых данных создавать данные в регистрах [#69](https://github.com/bia-technologies/yaxunit/pull/69)
* Реализовано удаление тестовых данных созданных на клиенте [#74](https://github.com/bia-technologies/yaxunit/pull/74)
* Добавлена возможность создания объекта без записи и формирование вариантов параметров [#86](https://github.com/bia-technologies/yaxunit/pull/86)
* Реализована поддержка параметров заполнения для функции "Фикция" в тестовых данных [#75](https://github.com/bia-technologies/yaxunit/pull/75)
* Сброс признака ОбменДанными.Загрузка после создании объекта через методы движка [#92](https://github.com/bia-technologies/yaxunit/pull/92) 
* Поддержка генератором тестовых данных создания группы [#90](https://github.com/bia-technologies/yaxunit/pull/90)
* Возможность создавать несколько конструкторов тестовых данных  [#55](https://github.com/bia-technologies/yaxunit/pull/55)
* В конструктор тестовых данных добавлен метод заполнения обязательных полей фиктивными данными [#93](https://github.com/bia-technologies/yaxunit/pull/93)

### Мокито

* Использование предикатов при указании параметров мокируемого метода [#98](https://github.com/bia-technologies/yaxunit/pull/98)
* Исправлена ошибка неправильного сравнение параметров при проверке вызовов Мокито [#76](https://github.com/bia-technologies/yaxunit/pull/76). Спасибо [@alexandr-yang](https://github.com/alexandr-yang)
* Исправлена ошибка подбора реакции Мокито [#62](https://github.com/bia-technologies/yaxunit/pull/62)

### Утверждения

* Утверждения для проверки таблиц информационной базы [#70](https://github.com/bia-technologies/yaxunit/pull/70)

### Запросы

* Расширение API для работы с запросами [#94](https://github.com/bia-technologies/yaxunit/pull/94)

### Прочее

* Добавлена картинка подсистемы 16*16 [#78](https://github.com/bia-technologies/yaxunit/pull/78). Спасибо [@petypen](https://github.com/petypen)
* Исправлены некоторые ошибки [#85](https://github.com/bia-technologies/yaxunit/pull/85). Спасибо [@potoyalo](https://github.com/potoyalo)
* Добавлена настройки выполнения на уровень модуля [#84](https://github.com/bia-technologies/yaxunit/pull/84)
