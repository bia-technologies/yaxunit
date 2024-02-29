---
title: YaxUnit. Версия 24.01
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 24.01](https://github.com/bia-technologies/yaxunit/releases/tag/24.01)

## Новое в версии

### Тестовые данные

* Добавить возможность передать дополнительные свойства и режим загрузки в методы СоздатьЭлемент и СоздатьДокумент [#181](https://github.com/bia-technologies/yaxunit/issues/181) Спасибо [@SeiOkami](https://github.com/SeiOkami)
* Конструктор тестовых данных. Добавить метод перехода с заполнения табличной части на объект [#167](https://github.com/bia-technologies/yaxunit/issues/167)
* Конструктор тестовых данных, добавить метод создания записи, который возвращает сам конструктор. [#243](https://github.com/bia-technologies/yaxunit/issues/243)

### Утверждения

* Новое утверждение `ОжидаетЧто(Объект).ИмеетМетод(ИмяМетода)` [#224](https://github.com/bia-technologies/yaxunit/issues/224)
* Добавить поддержку передачи значения по умолчанию [#207](https://github.com/bia-technologies/yaxunit/issues/207) Спасибо [@stolya](https://github.com/stolya)
* Утверждения. Добавить поддержку проверки форматированных строк [#199](https://github.com/bia-technologies/yaxunit/issues/199)
* Доработать утверждения ИБ для проверки строк неограниченной длины [#187](https://github.com/bia-technologies/yaxunit/issues/187)
* Добавить поддержку предикатов в Утверждения.Содержит И Утверждения.НеСодержит [#179](https://github.com/bia-technologies/yaxunit/issues/179)
* Утверждения для проверки исключений методов выполнять в транзакции [#172](https://github.com/bia-technologies/yaxunit/issues/172)
* Перевод утверждений на использование предикатов [#162](https://github.com/bia-technologies/yaxunit/issues/162)
* Сравнение табличных документов по содержимому [#36](https://github.com/bia-technologies/yaxunit/issues/36)

### Мокирование

* Мокито. Навести порядок с мокированием ссылочных объектов. [#231](https://github.com/bia-technologies/yaxunit/issues/231)
* Настройка мокирования. Сократить настройку мокирования цепочки вызовов одного метода. [#223](https://github.com/bia-technologies/yaxunit/issues/223)


### Прочее

* Поддержка англоязычных конфигураций [#238](https://github.com/bia-technologies/yaxunit/issues/238) Спасибо [@RichardTheLionJokes](https://github.com/RichardTheLionJokes)
* Вынести в ППИ метод получения свойства по по пути [#214](https://github.com/bia-technologies/yaxunit/issues/214)
* Добавить метод получения движений документа [#170](https://github.com/bia-technologies/yaxunit/issues/170)
* Сократить сообщение для сломанных тестов [#169](https://github.com/bia-technologies/yaxunit/issues/169)
* Небольшые правки [#165](https://github.com/bia-technologies/yaxunit/issues/165)
* Метод установки реквизита ссылки [#158](https://github.com/bia-technologies/yaxunit/issues/158)
* Проверка зависших транзакций [#143](https://github.com/bia-technologies/yaxunit/issues/143)

## Исправленные ошибки

### Запуск

* Ошибка при чтении параметров запуска [#241](https://github.com/bia-technologies/yaxunit/issues/241) Спасибо [@1cgh](https://github.com/1cgh)
* Добавить поддержку работу инструмента под не полноправным пользователем [#212](https://github.com/bia-technologies/yaxunit/issues/212) Спасибо [@stolya](https://github.com/stolya)
* Добавить возможность внутри тестов создавать внешнюю обработку по имени [#193](https://github.com/bia-technologies/yaxunit/issues/193) Спасибо [@SeiOkami](https://github.com/SeiOkami)
* Ошибка запуска тестов из файла настроек при запрещенных синхронных вызовах [#188](https://github.com/bia-technologies/yaxunit/issues/188)

### Мокирование

* Не работает мокирование методов обработки, при обучении через менеджер [#217](https://github.com/bia-technologies/yaxunit/issues/217)

### Тестовые данные

* Ошибка генерации случайного отрицательного числа без параметров [#211](https://github.com/bia-technologies/yaxunit/issues/211)

### CI

* Починить тесты движка для английской локали [#160](https://github.com/bia-technologies/yaxunit/issues/160)

### Прочее

* При поломке контекста движка в рамках теста возникает необработаная ошибка [#234](https://github.com/bia-technologies/yaxunit/issues/234)
