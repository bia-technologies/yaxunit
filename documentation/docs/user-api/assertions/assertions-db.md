---
tags: [Getting started, Asserts, DB]
---

# Утверждения для проверки данных информационной базы

Большая часть тестируемых методов так или иначе оставляет свой след в базе, создает или изменяет записи в ИБ.

Для проверки правильности работы метода нам необходимо проверить, что изменилось в базе. В этом могут помочь утверждения проверяющие записи ИБ.

Доступ к утверждениям обеспечивает метод `ЮТест.ОжидаетЧтоТаблицаБазы`, который возвращает инициализированный модуль `ЮТУтвержденияИБ`, реализующий работу с утверждениями для ИБ.

Утверждения позволяют проверить наличие и отсутствие записей по различным условиям, для задания условий используются [предикаты](../predicates.md)

```bsl
	ЮТест.ОжидаетЧтоТаблицаБазы("Справочник.Товары")
		.НеСодержитЗаписи(); // В базе нет товаров
	ЮТест.ОжидаетЧтоТаблицаБазы("Справочник.Товары")
		.СодержитЗаписи(); // В базе есть товары
	ЮТест.ОжидаетЧтоТаблицаБазы("Справочник.Товары")
		.СодержитЗаписи(ЮТест.Предикат() // В базе есть товары определенного поставщика
			.Реквизит("Поставщик").Равно(ДанныеСправочника.Поставщик));
	ЮТест.ОжидаетЧтоТаблицаБазы("РегистрСведений.КурсыВалют")
		.НеСодержитЗаписи(ЮТест.Предикат() // Курс валюты не установлен
			.Реквизит("Валюта").Равно(ДанныеРегистра.Валюта)
			.Реквизит("Период").БольшеИлиРавно(ДанныеРегистра.Период));
```

## Доступные методы

* `СодержитЗаписи` - проверяет наличие записей по условиям
* `НеСодержитЗаписи` - проверяет отсутствие записей по условиям
* `СодержитЗаписиСНаименованием` - проверяет наличие в таблице записей с указанным наименованием
* `СодержитЗаписиСКодом` - проверяет наличие в таблице записей с указанным кодом
* `СодержитЗаписиСНомером` - проверяет наличие в таблице записей с указанным номером
* `НеСодержитЗаписиСНаименованием` - проверяет отсутствие в таблице записей с указанным наименованием
* `НеСодержитЗаписиСКодом` - проверяет отсутствие в таблице записей с указанным кодом
* `НеСодержитЗаписиСНомером` - проверяет отсутствие в таблице записей с указанным номером

:::tip

[Предлагайте](https://github.com/bia-technologies/yaxunit/issues) и [добавляйте](https://github.com/bia-technologies/yaxunit/pulls) свои утверждения

:::