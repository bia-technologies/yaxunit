# Рекомендации

Модульные тесты - это инструмент разработчика улучшающий качества работы.

* Модульные тесты это код.
* Тесты идут совместно с доработками (при использовании git)
* Быстрый ответ
* Высокая скорость реализации и, соответственно, низкая стоимость. На проверку небольшой функции уходит всего несколько секунд. Изолированность юнитов позволяет проверять работоспособность нескольких модулей одновременно.
* Простота автоматизации. Unit тест исследует ответ кода на ввод данных и определенные действия. Он не требует проиграть сценарий взаимодействия конечного пользователя с новой функцией, поэтому автоматизация процесса не отнимает много сил и времени.

На больших и сложных проектах стопроцентного покрытия кода тестами достичь сложно. К тому же, это нерационально. Показатель 70–90% считается хорошим. Он позволяет выявить максимальное количество ошибок. Мы собрали несколько практических советов по увеличению процента покрытия кода:

* Пишите unit тест на каждый новый код сразу же.
* Используйте готовые решения – тестовые фреймворки.
* Создавайте тесты для проверки только одной функции.
* Используйте негативные тесты для проверки поведения программы в случае ввода неправильных данных.
* Используйте мутационные фреймворки с функцией изменения констант и условий для проверки качества unit тестов.
* Проверяйте тесты на стабильность.
* Следите за скоростью выполнения теста.


## Рекомендации по модульному тестированию с использованием YAxUnit

Кроме [общих рекомендаций](common-recommendations.md)

* Структура тестовых модулей: Модуль тестового набора должен соответствовать объекту решения, который он будет тестировать. Для этого мы предлагаем [схему наименования модулей](../getting-started/structure.md#схема-наименования-модулей)