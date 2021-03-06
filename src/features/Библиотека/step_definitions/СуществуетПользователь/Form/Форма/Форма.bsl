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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"СоздаетсяПользовательСИменемИСРольюИРольюБазовыеПрава(Парам01,Парам02)","СоздаетсяПользовательСИменемИСРольюИРольюБазовыеПрава","Тогда создается пользователь с именем ""ИмяПользователя"" и с ролью ""Роль"" и ролью БазовыеПрава");

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
//Тогда создается пользователь с именем "Имя пользователя" и с ролью "Роль" и ролью БазовыеПрава
//@СоздаетсяПользовательСИменемИСРольюИРольюБазовыеПрава(Парам01,Парам02)
Процедура СоздаетсяПользовательСИменемИСРольюИРольюБазовыеПрава(ИмяПользователя,Роль) Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	//ВызватьИсключение "Не реализовано.";
	
	РольПользователя = СтрЗаменить(Роль,"БезРоли","");
	ПроверитьИСоздатьАдминистратора();
	СоздатьПользователя(ИмяПользователя,РольПользователя);
	
КонецПроцедуры



&НаСервере
Процедура ПроверитьИСоздатьАдминистратора()
	
УстановитьПривилегированныйРежим (Истина);
 
ПользовательАдминистратор = ПользователиИнформационнойБазы.НайтиПоИмени("Администратор"); 
Если ПользовательАдминистратор = Неопределено Тогда
	
	ПользовательАдминистратор 			= ПользователиИнформационнойБазы.СоздатьПользователя();
	ПользовательАдминистратор.Имя 		= "Администратор";
	ПользовательАдминистратор.ПолноеИмя = "Администратор";
	ПользовательАдминистратор.Роли.Добавить(Метаданные.Роли.ПолныеПрава);
	ПользовательАдминистратор.Записать();
	
КонецЕсли;

УстановитьПривилегированныйРежим (Ложь);	
	
КонецПроцедуры	

&НаСервере
Процедура СоздатьПользователя(ИмяПользователя,Роль)

УстановитьПривилегированныйРежим (Истина);
 
ПользовательНовый = ПользователиИнформационнойБазы.НайтиПоИмени(ИмяПользователя); 
Если ПользовательНовый = Неопределено Тогда
	
	ПользовательНовый			 = ПользователиИнформационнойБазы.СоздатьПользователя();
	ПользовательНовый.Имя		 = ИмяПользователя;
	ПользовательНовый.ПолноеИмя	 = ИмяПользователя;
	
	Если НЕ ПустаяСтрока(Роль)  Тогда
		ПользовательНовый.Роли.Добавить(Метаданные.Роли[Роль]);
	КонецЕсли;	
	
	ПользовательНовый.Роли.Добавить(Метаданные.Роли.БазовыеПрава);
	ПользовательНовый.Записать();
	
Иначе
	
	Если НЕ ПустаяСтрока(Роль) И НЕ ПользовательНовый.Роли.Содержит(Метаданные.Роли[Роль]) Тогда
		ВызватьИсключение "Пользователь уже существует но роль ему не доступна" ;
	КонецЕсли;
	
КонецЕсли;

УстановитьПривилегированныйРежим (Ложь);	
	
	
	
КонецПроцедуры	

//окончание текста модуля