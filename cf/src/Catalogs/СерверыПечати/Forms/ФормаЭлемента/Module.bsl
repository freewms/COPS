// @strict-types

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьНаименование(ЭтаФорма, "");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СерверОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ОбновитьНаименование(Элемент, Текст);
	//Автоматически не обновляется значение самого поля
	ДанныеВыборка = Новый СписокЗначений();
	ДанныеВыборка.Добавить(Текст);
		
КонецПроцедуры

&НаКлиенте
Процедура ПортОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ОбновитьНаименование(Элемент, Текст);
	//Автоматически не обновляется значение самого поля
	ДанныеВыборка = Новый СписокЗначений();
	ДанныеВыборка.Добавить(Текст);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьНаименование(Элемент, Текст)
	
	ТекущееНаименование = Объект.Наименование;
	ТекущееНаименованиеПоШаблону = СтрШаблон("%1:%2",Объект.Сервер,Формат(Объект.Порт,"ЧРГ=; ЧГ=;"));
	Если ТекущееНаименование = ТекущееНаименованиеПоШаблону Или ТекущееНаименование = "" Тогда
		Если Элемент = Элементы.Порт Тогда
			НовоеНаименование = СтрШаблон("%1:%2",Объект.Сервер,Текст);
		ИначеЕсли Элемент = Элементы.Сервер Тогда
			НовоеНаименование = СтрШаблон("%1:%2",Текст,Формат(Объект.Порт,"ЧРГ=; ЧГ=;"));
		Иначе
			НовоеНаименование = ТекущееНаименование;
		КонецЕсли;
		Объект.Наименование = НовоеНаименование;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
