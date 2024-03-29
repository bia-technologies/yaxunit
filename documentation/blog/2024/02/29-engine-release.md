---
title: YaxUnit. Версия 24.02
authors: alkoleft
tags: [releases, yaxunit]
---

[Release 24.02](https://github.com/bia-technologies/yaxunit/releases/tag/24.02)

## Новое в версии

### Тестовые данные

* Добавлен метод генерации случайного номера телефона [#175](https://github.com/bia-technologies/yaxunit/issues/175)
* Добавлен метод для получения случайного значения предопределенных данных [#246](https://github.com/bia-technologies/yaxunit/issues/246)
* Внесен метод генерации случайного значения по описанию типов в публичный интерфейс. [#250](https://github.com/bia-technologies/yaxunit/issues/250)

### Утверждения

* Метод утверждений ИмеетДлину не выводит в тексте ошибки фактическую длину (размер) [#203](https://github.com/bia-technologies/yaxunit/issues/203)

### Мокирование

* Добавить методы для мокирования ADO.RecordSet [#222](https://github.com/bia-technologies/yaxunit/issues/222)

### Запуск

* Добавить запуск выделенных тестов в обработке запуска тестов по Ctrl+Enter [#251](https://github.com/bia-technologies/yaxunit/issues/251). Спасибо [@1cgh](https://github.com/1cgh)

### Отчет о тестировании

* Отчет в формате allure [#255](https://github.com/bia-technologies/yaxunit/issues/255)

## Исправленные ошибки

* Если в ИсполняемыеСценарии выпадает ошибка, то тесты просто не определяются и ошибка нигде не отображается [#198](https://github.com/bia-technologies/yaxunit/issues/198)
* Использование метода ЮТест.Пропустить влечет запись кода 1 (ошибка) в файл с результатом проверки [#216](https://github.com/bia-technologies/yaxunit/issues/216)
* Добавить DataProcessor.ЮТHTTPServiceRequest в подсистему ЮТМокирование [#247](https://github.com/bia-technologies/yaxunit/issues/247)
* Метод в ВТранзакции() на уровне теста не работает корректно. Код не выполняется в транзакции. [#253](https://github.com/bia-technologies/yaxunit/issues/253)
* Не корректно работает цепочка загрузок из макета [#266](https://github.com/bia-technologies/yaxunit/issues/266)
