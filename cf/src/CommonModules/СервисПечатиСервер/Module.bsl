// @strict-types
#Область ПрограммныйИнтерфейс

// Получить структуру описания пакета документов
// 
// Возвращаемое значение:
//  см. НовыйЗапросаСервисаПечати
Функция НовыйПакетДокументов() Экспорт
	
	Возврат НовыйЗапросаСервисаПечати();
	
КонецФункции

// Процедура формирования пакета документов
// Используется при печати нескольких документов на нескольких принтерах за один вызов
//  
// Параметры:
//  ПакетДокументов - см. НовыйПакетДокументов
//  Документ - ТабличныйДокумент - Табличный документ для печати
//  Принтер - СправочникСсылка.Принтеры - принтер на котором должен быть напечатан документ
// Возвращаемое значение:
//  Число - Индекс в коллекции заданий печати по которому будет сформирован ответ
Функция ДобавитьДокументВПакет(ПакетДокументов, Документ, Принтер) Экспорт
									 	   
	Индекс = ПакетДокументов.Принтеры.Количество();
	ПакетДокументов.ЗаданияПоКлючам.Вставить(Индекс, Документ);
	ПакетДокументов.Принтеры.Добавить(Принтер);
		
	Возврат Индекс
		
КонецФункции

// Напечатать пакет документов
// 
// Параметры:
//  ПакетДокументов - см. ДобавитьДокументВПакет
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Описание результатов
//	 Ключ - Число - Индекс задания в коллекции задания печати см.ДобавитьЗаданиеВПакетЗаданийПечати
//	 Соответствие из КлючИЗначение - Описание результата выполнения печати
Функция НапечататьПакетДокументов(ПакетДокументов) Экспорт
	
	Возврат ОбработатьЗапрос(Перечисления.МетодыСервераПечати.НапечататьДокумент, ПакетДокументов);		

КонецФункции

// Напечатать документ
// 
// Параметры:
//  Документ - ТабличныйДокумент - Табличный документ для печати
//  Принтер - СправочникСсылка.Принтеры - принтер на котором должен быть напечатан документ
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Описание результата выполнения печати
Функция НапечататьДокумент(Документ, Принтер) Экспорт
	
	ПакетДокументов = НовыйЗапросаСервисаПечати();
	Индекс = ДобавитьДокументВПакет(ПакетДокументов, Документ, Принтер);
	
	Результат = ОбработатьЗапрос(Перечисления.МетодыСервераПечати.НапечататьДокумент, ПакетДокументов);
	
	Возврат Результат[Индекс]; 		

КонецФункции

// Напечатать тестовые страницы с генерацией средствами сервера печати
// 
// Параметры:
//  Принтеры - Массив из СправочникСсылка.Принтеры
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Описание результатов
//	 Ключ - Число - Индекс задания в коллекции задания печати см.ДобавитьЗаданиеВПакетЗаданийПечати
//	 Соответствие из КлючИЗначение - Описание результата выполнения команды  
Функция НапечататьТестовыеСтраницы(Принтеры) Экспорт
	
	ПараметрыМетода = НовыйЗапросаСервисаПечати();
	ПараметрыМетода.Принтеры = Принтеры;
	Возврат ОбработатьЗапрос(Перечисления.МетодыСервераПечати.НапечататьТестовуюСтраницу, ПараметрыМетода);

КонецФункции

// Получить состояние принтеров на сервере печати
// 
// Параметры:
//  Принтеры - Массив из СправочникСсылка.Принтеры
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Описание результатов
//	 Ключ - Число - Индекс задания в коллекции задания печати см.ДобавитьЗаданиеВПакетЗаданийПечати
//	 Соответствие из КлючИЗначение - Описание результата выполнения команды
Функция ПолучитьСостояниеПринтеров(Принтеры) Экспорт
	
	ПараметрыМетода = НовыйЗапросаСервисаПечати();
	ПараметрыМетода.Принтеры = Принтеры;
	Возврат ОбработатьЗапрос(Перечисления.МетодыСервераПечати.ПолучитьСостояниеПринтера, ПараметрыМетода);
		
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Получить состояние принтера по имени принтера и ссылке на сервере печати.
// Используется для отображения состояния на форме справочника принтеров
// 
// Параметры:
//  СерверПечати - СправочникСсылка.СерверыПечати
//  ИмяПринтера - Строка
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Описание результата выполнения команды
Функция ПолучитьСостояниеПринтера(СерверПечати, ИмяПринтера = Неопределено) Экспорт
	
	//TODO: Обработать с учетом изменения в возврате
	// Механизм в т.ч. для заполнения справочников принтеров
	Соединение = СервисПечатиПовтИсп.ПолучитьHTTPСоединениеДляСервераПечати(СерверПечати);
	ПараметрыМетода = Новый Соответствие;
	ПараметрыМетода.Вставить("command", "printers_info");
	Если ИмяПринтера <> Неопределено Тогда
		Задание = Новый Соответствие;
		Задание.Вставить("printer", ИмяПринтера);
		Задание.Вставить("id", 0);
		Массив = Новый Массив;
		Массив.Добавить(Задание);
		ПараметрыМетода.Вставить("printers", Массив);
	КонецЕсли;
	Метод = Перечисления.МетодыСервераПечати.ПолучитьСостояниеПринтера;
	ОписаниеРезультата = ВызватьМетодСервераПечати(Соединение, Метод, ПараметрыМетода);
	
	Возврат ОписаниеРезультата;

КонецФункции

// Обработчик восстановления параметров JSON.
// 
// Параметры:
//   Свойство - Строка
//   Значение - Число
//   ДополнительныеПараметры - Произвольный
//   
// Возвращаемое значение:
//   НовоеЗначение - Произвольный - Описание JSON в виде объектов 1С
Функция JSONВосстановление(Знач Свойство, Значение, ДополнительныеПараметры) Экспорт

	НовоеЗначение = Неопределено;

	Если Свойство = "job-id" Тогда
		НовоеЗначение = Строка(Формат(Значение, "ЧРГ=; ЧГ=;"));
	Иначе
		НовоеЗначение = Значение;
	КонецЕсли;

	Возврат НовоеЗначение;

КонецФункции

// JSONEncode.
// 
// Параметры:
//  Значение - Соответствие из КлючИЗначение - Значение
// 
// Возвращаемое значение:
//  Строка - Строка в нотации JSON
Функция JSONEncode(Значение) Экспорт

	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Значение);

	Возврат ЗаписьJSON.Закрыть();
	;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Получить соответствие принтеров их описаниям
// 
// Параметры:
//  Принтеры - Массив из СправочникСсылка.Принтеры
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение:
//    * Ключ - СправочникСсылка.Принтеры
//	  * Значение - см. НовыйПараметрыПринтера
Функция ПолучитьОписаниеПринтеров(Принтеры)

	ОписаниеПринтеров = Новый Соответствие;

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Принтеры.СерверПечати КАК СерверПечати,
	|	Принтеры.Ссылка КАК Принтер,
	|	Принтеры.ИмяНаСервереПечати КАК ИмяПринтера,
	|	Принтеры.ФорматБумаги.Ширина КАК ШиринаСтраницы,
	|	Принтеры.ФорматБумаги.Высота КАК ВысотаСтраницы,
	|	Принтеры.ОриентацияСтраницы КАК ОриентацияСтраницы
	|ИЗ
	|	Справочник.Принтеры КАК Принтеры
	|ГДЕ
	|	Принтеры.Ссылка В (&Принтеры)";
	Запрос.УстановитьПараметр("Принтеры", Принтеры);
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Выборка.Следующий() Цикл
			ПараметрыПринтера = НовыйПараметрыПринтера();
			ЗаполнитьЗначенияСвойств(ПараметрыПринтера, Выборка);
			ОписаниеПринтеров.Вставить(Выборка.Принтер, ПараметрыПринтера);
	КонецЦикла;

	Возврат ОписаниеПринтеров;

КонецФункции

// Обработать запрос службы печати
// 
// Параметры:
//  Метод - ПеречислениеСсылка.МетодыСервераПечати
//  ПараметрыМетода - см. НовыйЗапросаСервисаПечати
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Описание результатов
//	 Ключ - СправочникСсылка.Принтеры
//	 Значение - Описание результата
Функция ОбработатьЗапрос(Метод, ПараметрыМетода)
					
	ОписаниеПринтеров = ПолучитьОписаниеПринтеров(ПараметрыМетода.Принтеры);
	
	//TODO: Переделать параметры из питона на соответствие для всех методов!
	ПараметрыМетодаЗапроса = Новый Соответствие;
	Если Метод = Перечисления.МетодыСервераПечати.НапечататьДокумент Тогда
		ПараметрыМетодаЗапроса.Вставить("command", "print_jobs");
	ИначеЕсли Метод = Перечисления.МетодыСервераПечати.ЗапуститьПринтер Тогда
		ПараметрыМетодаЗапроса.Вставить("command", "printers_enable");
	ИначеЕсли Метод = Перечисления.МетодыСервераПечати.ОстановитьПринтер Тогда
		ПараметрыМетодаЗапроса.Вставить("command", "printers_disable");
	ИначеЕсли Метод = Перечисления.МетодыСервераПечати.НапечататьТестовуюСтраницу Тогда
		ПараметрыМетодаЗапроса.Вставить("command", "print_test_page");
	ИначеЕсли Метод = Перечисления.МетодыСервераПечати.ПолучитьСостояниеПринтера Тогда
		ПараметрыМетодаЗапроса.Вставить("command", "printers_info");
	Иначе
		ВызватьИсключение("Неизвестный метод сервиса печати");
	КонецЕсли;
	
	Индекс = 0;
	ЗапросыПоСерверамПечати = Новый Соответствие;
	СоединенияПоСерверамПечати = Новый Соответствие;
	Для Каждого Принтер Из ПараметрыМетода.Принтеры Цикл
		СерверПечати = ОписаниеПринтеров[Принтер].СерверПечати;
		Если ЗапросыПоСерверамПечати[СерверПечати] = Неопределено Тогда
			//TODO: Попробовать собрать данные одним запросом в т.ч. по серверам печати
			Соединение = СервисПечатиПовтИсп.ПолучитьHTTPСоединениеДляСервераПечати(СерверПечати);
			СоединенияПоСерверамПечати.Вставить(СерверПечати,Соединение);
			ЗапросыПоСерверамПечати.Вставить(СерверПечати, Новый Массив);
		КонецЕсли;
		
		Задание = Новый Соответствие();
		Задание.Вставить("printer", ОписаниеПринтеров[Принтер].ИмяПринтера);
		Задание.Вставить("id", Строка(Индекс));
		Если Метод = Перечисления.МетодыСервераПечати.НапечататьДокумент Тогда
			Документ = ПодготовитьДокументКОтправкеНаСерверПечати(ПараметрыМетода.ЗаданияПоКлючам[Индекс], 
																  ОписаниеПринтеров[Принтер]);
			Задание.Вставить("doc", Документ);
			Задание.Вставить("name", ТекущаяДатаСеанса());
		КонецЕсли;
		ЗапросыПоСерверамПечати[СерверПечати].Добавить(Задание);
		Индекс = Индекс + 1;
	КонецЦикла;
	
	Результат = Новый Соответствие;
	Для Каждого Запрос Из ЗапросыПоСерверамПечати Цикл
		Если Метод = Перечисления.МетодыСервераПечати.НапечататьДокумент Тогда
			ПараметрыМетодаЗапроса.Вставить("jobs", Запрос.Значение);
		Иначе	 
			ПараметрыМетодаЗапроса.Вставить("printers", Запрос.Значение);
		КонецЕсли;
		ОписаниеРезультата = ВызватьМетодСервераПечати(СоединенияПоСерверамПечати[Запрос.Ключ], 
													   Метод, 
													   ПараметрыМетодаЗапроса);
		Если ОписаниеРезультата = Неопределено Тогда
			Для Каждого ЭлементРезультата Из Запрос.Значение Цикл
				Результат.Вставить(ЭлементРезультата["id"], Неопределено);
			КонецЦикла
		Иначе
			Для Каждого ЭлементРезультата Из ОписаниеРезультата Цикл
				Результат.Вставить(ЭлементРезультата["id"], ЭлементРезультата["data"]);	
			КонецЦикла;
		КонецЕсли;

	КонецЦикла;

	Если СервисПечатиПовтИсп.ЗаписыватьИсторию() Тогда
		РегистрыСведений.СервисПечатиИстория.ЗарегистрироватьСобытие(Метод, Результат, ПараметрыМетода.Принтеры);
	КонецЕсли;
	Возврат Результат;

КонецФункции

// JSONDecode.
// 
// Параметры:
//  Содержимое - Строка - строка в нотации JSON
// 
// Возвращаемое значение:
//  Произвольный - JSONDecode
Функция JSONDecode(Содержимое)

	Массив = Новый Массив;
	Массив.Добавить("job-id");
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(Содержимое);
	Результат = ПрочитатьJSON(ЧтениеJSON, Истина, , , "JSONВосстановление", СервисПечатиСервер, , Массив);
	ЧтениеJSON.Закрыть();

	Возврат Результат;

КонецФункции

// Вызвать метод сервера печати.
// 
// Параметры:
//  Соединение - HTTPСоединение
//  Метод - ПеречислениеСсылка.МетодыСервераПечати
//  ПараметрыМетода - Соответствие из КлючИЗначение - набор параметров для вызова метода
// 
// Возвращаемое значение:
// 	Соответствие из КлючИЗначение:
//	 * Ключ - Строка
//	 * Значение - Произвольный
Функция ВызватьМетодСервераПечати(Соединение, Метод, ПараметрыМетода)

	ДанныеЗапросаСтрокой = JSONEncode(ПараметрыМетода);

	HTTPЗапрос = Новый HTTPЗапрос;
	HTTPЗапрос.Заголовки.Вставить("Content-Type", "application/json");
	HTTPЗапрос.УстановитьТелоИзСтроки(ДанныеЗапросаСтрокой);
	Попытка
		Результат = Соединение.ВызватьHTTPМетод("POST", HTTPЗапрос);
	Исключение
		ЗаписьЖурналаРегистрации("1CUPS", УровеньЖурналаРегистрации.Ошибка,
			Метаданные.Перечисления.МетодыСервераПечати, Метод, ОписаниеОшибки());
		Возврат Неопределено;
	КонецПопытки;

	ДанныеОтветаСтрокой = Результат.ПолучитьТелоКакСтроку(КодировкаТекста.UTF8);
	КодОтвета = Результат.КодСостояния;

	Если КодОтвета <> 200 Тогда
		ЗаписьЖурналаРегистрации("1CUPS", УровеньЖурналаРегистрации.Ошибка,
			Метаданные.Перечисления.МетодыСервераПечати, Метод, ДанныеОтветаСтрокой);
		Возврат Неопределено;
	КонецЕсли;

	Возврат JSONDecode(ДанныеОтветаСтрокой);

КонецФункции

// Сформировать задание печати в нотации сервера печати
// 
// Параметры:
//  Документ - ТабличныйДокумент
//  ПараметрыПринтера - см. НовыйПараметрыПринтера
//  
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - Задача для печати в нотации, пригодной к сериализации JSON
Функция ПодготовитьДокументКОтправкеНаСерверПечати(Документ, ПараметрыПринтера)
	
	ПотокВПамяти = Новый ПотокВПамяти();
				
	Если Документ.Автомасштаб Тогда
		//@skip-check variable-value-type
		ПараметрыОриентации = ОриентацияСтраницы.Портрет;
		Если ПараметрыПринтера.ОриентацияСтраницы = Перечисления.ОриентацияСтраницы.Альбомная Тогда
			ПараметрыОриентации = ОриентацияСтраницы.Ландшафт;
		КонецЕсли; 
		Документ.ВысотаСтраницы = ПараметрыПринтера.ВысотаСтраницы;
		Документ.ШиринаСтраницы = ПараметрыПринтера.ШиринаСтраницы;
		Документ.РазмерСтраницы = "Custom";
		//@skip-check statement-type-change
		Документ.ОриентацияСтраницы = ПараметрыОриентации;
		Документ.Автомасштаб = Истина;
		Документ.ПолеСверху  = 0;
		Документ.ПолеСправа  = 0;
		Документ.ПолеСлева   = 0;
		Документ.ПолеСнизу   = 0;
	КонецЕсли;
	
	//@skip-check invocation-parameter-type-intersect
	Документ.Записать(ПотокВПамяти, ТипФайлаТабличногоДокумента.PDF);
	ДвоичныеДанные = ПотокВПамяти.ЗакрытьИПолучитьДвоичныеДанные();
	
	Возврат Base64Строка(ДвоичныеДанные);

КонецФункции

// Описание параметров принтера.
// 
// Возвращаемое значение:
//  Структура - Описание параметров принтера:
//  * ВысотаСтраницы - Число - Высота бумаги принтера
//  * ШиринаСтраницы - Число - Ширина бумаги принтера
//  * ОриентацияСтраницы - ПеречислениеСсылка.ОриентацияСтраницы - Ориентация страницы принтера
//  * СерверПечати - СправочникСсылка.СерверыПечати - Сервер печати принтера
//  * ИмяПринтера - Строка - Имя принтера на сервере печати
Функция НовыйПараметрыПринтера()
	
		СтруктураПараметровПринтера = Новый Структура;
		СтруктураПараметровПринтера.Вставить("ВысотаСтраницы", 0);
		СтруктураПараметровПринтера.Вставить("ШиринаСтраницы", 0);
		СтруктураПараметровПринтера.Вставить("ОриентацияСтраницы", Перечисления.ОриентацияСтраницы.ПустаяСсылка());
		СтруктураПараметровПринтера.Вставить("СерверПечати", Справочники.СерверыПечати.ПустаяСсылка());
		СтруктураПараметровПринтера.Вставить("ИмяПринтера", "");
		
		Возврат СтруктураПараметровПринтера;

КонецФункции

// Получить структуру описания параметров метода запроса на сервер печати
// 
// Возвращаемое значение:
//  Структура - Описание пакета заданий печати:
//  * Принтеры - Массив из СправочникСсылка.Принтеры
//  * ЗаданияПоКлючам - Соответствие из КлючИЗначение:
//   ** Ключ - Число - Индекс в массиве принтеров
//   ** Значение - ТабличныйДокумент - документ, который надо напечатать
Функция НовыйЗапросаСервисаПечати()
	
	Структура = Новый Структура;
	Структура.Вставить("Принтеры", Новый Массив);
	Структура.Вставить("ЗаданияПоКлючам", Новый Соответствие);
	
	Возврат Структура;
	
КонецФункции

#КонецОбласти