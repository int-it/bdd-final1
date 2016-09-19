﻿#encoding: utf-8
#language: ru
@tree

Функционал: Закупка товара
	Как оператор
	Я хочу Оформлять закупку в 1с
	Чтобы вести учет закупленных товаров
	
Контекст:

	Дано есть 1с
		Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И еще нет ни одного документа "Покупка"
	И создан товар
		И еще нет ни одного элемента в справочнике "Товары"
		Тогда Создание товара

Сценарий: Создание документа Покупка
	Когда я создаю документ Покупка
		Когда В панели разделов я выбираю "Закупки"
		И     Я нажимаю кнопку командного интерфейса "Документы покупки"
		И     Я нажимаю кнопку командного интерфейса "Покупка"
		Тогда открылось окно "Документ покупка (создание)"


	И выбираю товар
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я нажимаю кнопку выбора у реквизита "Товар"
		Тогда открылось окно "Список товаров"
		И     В форме "Товары" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Документ покупка (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "10,00"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "2,00"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Сумма"
		И     В форме "Документ покупка (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И     я нажимаю на кнопку "Записать"
		Тогда элемент формы с именем "Номер" стал равен "000000001"
		И     я нажимаю на кнопку "Провести и закрыть"
	Тогда данные о покупке сохраняются в 1с
		Тогда создан документ "Покупка" с номером "000000001"
	
