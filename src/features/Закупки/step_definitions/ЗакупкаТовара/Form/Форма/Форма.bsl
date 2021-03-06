﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ОстаткиТовараРавны(Парам01,Парам02)","ОстаткиТовараРавны","И Остатки Товара ""Первый товар"" равны ""2""");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И Остатки Товара "Первый товар" равны "2"
//@ОстаткиТовараРавны(Парам01,Парам02)
Процедура ОстаткиТовараРавны(НаименованиеТовара,Количество) Экспорт
	Остаток = ТекущиеОстаткиТовара(НаименованиеТовара); 
	
	Если Остаток <> Число(Количество) Тогда
		ВызватьИсключение "Остаток " + НаименованиеТовара + " равен " + Остаток;
	КонецЕсли;	
КонецПроцедуры


&НаСервере
Функция ТекущиеОстаткиТовара(НаименованиеТовара)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТоварыОстатки.Товар,
	               |	ТоварыОстатки.КоличествоОстаток
	               |ИЗ
	               |	РегистрНакопления.Товары.Остатки КАК ТоварыОстатки
	               |ГДЕ
	               |	ТоварыОстатки.Товар.Наименование = &Наименование";
	Запрос.УстановитьПараметр("Наименование",НаименованиеТовара);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.КоличествоОстаток;
	
КонецФункции	
//окончание текста модуля