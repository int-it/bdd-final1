﻿#encoding: utf-8
#language: ru
@tree
@ExportScenarios

Функционал: Продажа товара
	Как Оператор
	Я хочу создавать новые товары 
	Чтобы не выписывать товар вручную и экономить время 
	
Контекст:

	Дано есть 1с
		Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И еще нет ни одного элемента в справочнике "Товары"	

Сценарий: Создание товара
	Когда В панели разделов я выбираю "Главное"
	Когда В панели разделов я выбираю "НСИ"
	И     Я нажимаю кнопку командного интерфейса "Список товаров"
	Тогда открылось окно "Список товаров"
	И     я нажимаю на кнопку "Создать"
	Тогда открылось окно "Товары (создание)"
	И     в поле "Наименование" я ввожу текст "Первый товар"
	И     я нажимаю на кнопку "Записать и закрыть"
	Тогда таблица формы с именем "Список" стала равной:
	| 'Наименование' |
	| 'Первый товар' |

