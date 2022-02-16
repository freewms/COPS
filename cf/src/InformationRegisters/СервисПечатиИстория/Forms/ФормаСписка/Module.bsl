// @strict-types

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура Очистить(Команда)
	
	ОчиститьНаСервере();
	ОбновитьИнтерфейс();
	
КонецПроцедуры

&НаСервере
Процедура ОчиститьНаСервере()
	
	РегистрыСведений.СервисПечатиИстория.ОчиститьРегистр();
	
КонецПроцедуры

#КонецОбласти