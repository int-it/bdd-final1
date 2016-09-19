﻿#encoding: utf-8
#language: ru
@tree

Функционал: Продажа товара
	Как Продавец
	Я хочу Оформлять продажу в 1с
	Чтобы вести учет проданных товаров
	
Контекст:

	Дано есть 1с
		Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И еще нет ни одного документа "Продажа"	
	И создан товар
		И еще нет ни одного элемента в справочнике "Товары"
		Тогда Создание товара

Сценарий: Оформление документа продажа
	Когда я создаю документ Покупка
		Когда В панели разделов я выбираю "Продажи"
		И     Я нажимаю кнопку командного интерфейса "Документы продажи"
		И     Я нажимаю кнопку командного интерфейса "Продажа"
		Тогда открылось окно "Документ продажа (создание)"


	И выбираю товар
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я нажимаю кнопку выбора у реквизита "Товар"
		Тогда открылось окно "Список товаров"
		И     В форме "Товары" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Документ продажа (создание) *"
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "10,00"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "2,00"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Сумма"
		И     В форме "Документ продажа (создание) *" в ТЧ "Товары" я завершаю редактирование строки
		И     я нажимаю на кнопку "Записать"
		Тогда элемент формы с именем "Номер" стал равен "000000001"
		И     я нажимаю на кнопку "Провести и закрыть"
	Тогда данные о продаже сохраняются в 1с
		Тогда создан документ "Продажа" с номером "000000001"
	
