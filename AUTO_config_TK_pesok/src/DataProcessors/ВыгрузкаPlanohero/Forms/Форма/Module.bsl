
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаТекущиеДанные;
	
	МодукльОбъекта = РеквизитФормыВЗначение("Объект");
	
	СтруктураДанных = МодукльОбъекта.Инициализация(Ложь);
	
	Для Каждого строкаДанных Из СтруктураДанных.Начало Цикл
		строка = НачальныеДанные.Добавить();
		ЗаполнитьЗначенияСвойств(строка,строкаДанных);		
	КонецЦикла;
	
	НачальныеДанные.Сортировать("Порядок");
	
	Для Каждого строкаДанных Из СтруктураДанных.Продолжение Цикл
		строка = ТекущиеДанные.Добавить();
		ЗаполнитьЗначенияСвойств(строка,строкаДанных);		
	КонецЦикла;
	
	//	Для Каждого строкаДанных Из МодукльОбъекта.СтруктураДанных Цикл
	//	строка = ТекущиеДанные.Добавить();
	//	ЗаполнитьЗначенияСвойств(строка,строкаДанных);		
	//КонецЦикла;
	
	
	ТекущиеДанные.Сортировать("Порядок");
	
	ЗначениеВДанныеФормы(МодукльОбъекта.АктивныеСклады,Объект.АктивныеСклады);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаСервере
Процедура ВыгрузитьДанныеНаСервере()
	МодукльОбъекта = РеквизитФормыВЗначение("Объект");
	МодукльОбъекта.ВыгрузитьДанные(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьДанные(Команда)
	ВыгрузитьДанныеНаСервере();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОчиститьТаблицыНаСервере(Набор,ИмяТаблицы)
	Если Набор Тогда
		Набор = ВнешниеИсточникиДанных.PlanoHeroAttika.Таблицы[ИмяТаблицы].СоздатьНаборЗаписей();
		Набор.Записать();
		//ИначеЕсли ИмяТаблицы = "dbo_shopmarkerm2m" ИЛИ ИмяТаблицы = "dbo_assortment" ИЛИ ИмяТаблицы = "dbo_productinventory" Тогда
		//	Набор = ВнешниеИсточникиДанных.PlanoHeroAttika.Таблицы[ИмяТаблицы].СоздатьНаборЗаписей();
		//	Набор.Записать();
	Иначе
		Запрос = Новый Запрос;
		Запрос.Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"ВЫБРАТЬ
		|	Таблица.Ссылка КАК Ссылка
		|ИЗ
		|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.%1 КАК Таблица",
		ИмяТаблицы);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект().Удалить();
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТаблицы(Команда)
	Для Каждого строкаДанных Из НачальныеДанные Цикл
		Если строкаДанных.Вкл Тогда
			ОчиститьТаблицыНаСервере(строкаДанных.Набор,строкаДанных.ИмяТаблицы);
			строкаДанных.Вкл = Ложь;
		КонецЕсли;
	КонецЦикла;
	Для Каждого строкаДанных Из ТекущиеДанные Цикл
		Если строкаДанных.Вкл И НЕ строкаДанных.ИмяОбъекта = "" Тогда
			ОчиститьТаблицыНаСервере(строкаДанных.Набор,строкаДанных.ИмяТаблицы);
			строкаДанных.Вкл = Ложь;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ВыгрузитьНачальныеДанныеНаСервере()
	МодукльОбъекта = РеквизитФормыВЗначение("Объект");
	Для Каждого строкаДанных Из НачальныеДанные Цикл
		Если строкаДанных.Вкл Тогда
			МодукльОбъекта.ВыгрузитьНачальныеДанные(строкаДанных);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьНачальныеДанные(Команда)
	ВыгрузитьНачальныеДанныеНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура Документы()
	
	Документы = "ВЫБРАТЬ
	|	""dbo_supplierrefund"" КАК Поле1,
	|	dbo_supplierrefund.Ссылка КАК Ссылка,
	|	dbo_supplierrefund.id КАК id,
	|	dbo_supplierrefund.code КАК code,
	|	dbo_supplierrefund.created_at КАК created_at,
	|	dbo_supplierrefund.supplier_id КАК supplier_id,
	|	dbo_supplierrefund.shop_id КАК shop_id,
	|	dbo_supplierrefund.staff_id КАК staff_id,
	|	dbo_supplierrefund.note КАК note,
	|	dbo_supplierrefund.Представление КАК Представление,
	|	NULL КАК purchase_id,
	|	NULL КАК shop_sender_id,
	|	NULL КАК shop_receiver_id,
	|	NULL КАК type_id,
	|	NULL КАК expire_date,
	|	NULL КАК name,
	|	NULL КАК is_discount,
	|	NULL КАК cost,
	|	NULL КАК date_from,
	|	NULL КАК date_to
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_supplierrefund КАК dbo_supplierrefund
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_receive"",
	|	dbo_receive.Ссылка,
	|	dbo_receive.id,
	|	dbo_receive.code,
	|	dbo_receive.created_at,
	|	dbo_receive.supplier_id,
	|	dbo_receive.shop_id,
	|	dbo_receive.staff_id,
	|	NULL,
	|	dbo_receive.Представление,
	|	dbo_receive.purchase_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_receive КАК dbo_receive
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_relocate"",
	|	dbo_relocate.Ссылка,
	|	dbo_relocate.id,
	|	dbo_relocate.code,
	|	dbo_relocate.created_at,
	|	NULL,
	|	NULL,
	|	dbo_relocate.staff_id,
	|	NULL,
	|	dbo_relocate.Представление,
	|	NULL,
	|	dbo_relocate.shop_sender_id,
	|	dbo_relocate.shop_receiver_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_relocate КАК dbo_relocate
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_incoming"",
	|	dbo_incoming.Ссылка,
	|	dbo_incoming.id,
	|	dbo_incoming.code,
	|	dbo_incoming.created_at,
	|	NULL,
	|	dbo_incoming.shop_id,
	|	dbo_incoming.staff_id,
	|	NULL,
	|	dbo_incoming.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_incoming КАК dbo_incoming
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_loss"",
	|	dbo_loss.Ссылка,
	|	dbo_loss.id,
	|	dbo_loss.code,
	|	dbo_loss.created_at,
	|	NULL,
	|	dbo_loss.shop_id,
	|	dbo_loss.staff_id,
	|	dbo_loss.note,
	|	dbo_loss.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_loss.type_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_loss КАК dbo_loss
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_pricedocument"",
	|	dbo_pricedocument.Ссылка,
	|	dbo_pricedocument.id,
	|	dbo_pricedocument.code,
	|	dbo_pricedocument.created_at,
	|	NULL,
	|	NULL,
	|	dbo_pricedocument.staff_id,
	|	dbo_pricedocument.note,
	|	dbo_pricedocument.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_pricedocument.type_id,
	|	dbo_pricedocument.expire_date,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_pricedocument КАК dbo_pricedocument
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_promotion"",
	|	dbo_promotion.Ссылка,
	|	dbo_promotion.id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_promotion.note,
	|	dbo_promotion.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_promotion.type_id,
	|	NULL,
	|	dbo_promotion.name,
	|	dbo_promotion.is_demo,
	|	dbo_promotion.adv_cost,
	|	dbo_promotion.date_from,
	|	dbo_promotion.date_to
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_promotion КАК dbo_promotion
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_purchase"",
	|	dbo_purchase.Ссылка,
	|	dbo_purchase.id,
	|	dbo_purchase.code,
	|	dbo_purchase.created_at,
	|	dbo_purchase.supplier_id,
	|	dbo_purchase.shop_id,
	|	dbo_purchase.staff_id,
	|	NULL,
	|	dbo_purchase.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_purchase КАК dbo_purchase";
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура Справочники()
	
	Справочники = "ВЫБРАТЬ
	|	""dbo_brand"" КАК Таблица,
	|	dbo_brand.Ссылка КАК Ссылка,
	|	dbo_brand.id КАК id,
	|	dbo_brand.name КАК name,
	|	NULL КАК parent_id,
	|	NULL КАК is_active,
	|	NULL КАК marker_id,
	|	NULL КАК product_id,
	|	NULL КАК is_regular,
	|	dbo_brand.Представление КАК Представление,
	|	NULL КАК shop_id,
	|	NULL КАК code,
	|	NULL КАК phone,
	|	NULL КАК address,
	|	NULL КАК article,
	|	NULL КАК barcode,
	|	NULL КАК category_id,
	|	NULL КАК brand_id,
	|	NULL КАК producer_id,
	|	NULL КАК deleted,
	|	NULL КАК width,
	|	NULL КАК height,
	|	NULL КАК depth,
	|	NULL КАК weight,
	|	NULL КАК height_compression_coef,
	|	NULL КАК width_compression_coef,
	|	NULL КАК depth_compression_coef,
	|	NULL КАК is_loose,
	|	NULL КАК image,
	|	NULL КАК group_id,
	|	NULL КАК opened_at,
	|	NULL КАК latitude,
	|	NULL КАК longitude,
	|	NULL КАК area,
	|	NULL КАК type_id,
	|	NULL КАК modified_at
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_brand КАК dbo_brand
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_producer"",
	|	dbo_producer.Ссылка,
	|	dbo_producer.id,
	|	dbo_producer.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_producer.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_producer КАК dbo_producer
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_staff"",
	|	dbo_staff.Ссылка,
	|	dbo_staff.id,
	|	dbo_staff.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_staff.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_staff КАК dbo_staff
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_losstype"",
	|	dbo_losstype.Ссылка,
	|	dbo_losstype.id,
	|	dbo_losstype.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_losstype.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_losstype КАК dbo_losstype
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_supplierbonustype"",
	|	dbo_supplierbonustype.Ссылка,
	|	dbo_supplierbonustype.id,
	|	dbo_supplierbonustype.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_supplierbonustype.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_supplierbonustype КАК dbo_supplierbonustype
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_promotiontype"",
	|	dbo_promotiontype.Ссылка,
	|	dbo_promotiontype.id,
	|	dbo_promotiontype.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_promotiontype.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_promotiontype КАК dbo_promotiontype
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_shopgroup"",
	|	dbo_shopgroup.Ссылка,
	|	dbo_shopgroup.id,
	|	dbo_shopgroup.name,
	|	dbo_shopgroup.parent_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shopgroup.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_shopgroup КАК dbo_shopgroup
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_terminal"",
	|	dbo_terminal.Ссылка,
	|	dbo_terminal.id,
	|	dbo_terminal.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_terminal.Представление,
	|	dbo_terminal.shop_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_terminal КАК dbo_terminal
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_supplier"",
	|	dbo_supplier.Ссылка,
	|	dbo_supplier.id,
	|	dbo_supplier.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_supplier.Представление,
	|	NULL,
	|	dbo_supplier.code,
	|	dbo_supplier.phone,
	|	dbo_supplier.address,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_supplier КАК dbo_supplier
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_category"",
	|	dbo_category.Ссылка,
	|	dbo_category.id,
	|	dbo_category.name,
	|	dbo_category.parent_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_category.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_category КАК dbo_category
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_product"",
	|	dbo_product.Ссылка,
	|	dbo_product.id,
	|	dbo_product.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_product.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_product.article,
	|	dbo_product.barcode,
	|	dbo_product.category_id,
	|	dbo_product.brand_id,
	|	dbo_product.producer_id,
	|	dbo_product.deleted,
	|	dbo_product.width,
	|	dbo_product.height,
	|	dbo_product.depth,
	|	dbo_product.weight,
	|	dbo_product.height_compression_coef,
	|	dbo_product.width_compression_coef,
	|	dbo_product.depth_compression_coef,
	|	dbo_product.is_loose,
	|	dbo_product.image,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_product КАК dbo_product
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_shop"",
	|	dbo_shop.Ссылка,
	|	dbo_shop.id,
	|	dbo_shop.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shop.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shop.address,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shop.group_id,
	|	dbo_shop.opened_at,
	|	dbo_shop.latitude,
	|	dbo_shop.longitude,
	|	dbo_shop.area,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_shop КАК dbo_shop
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_pricetype"",
	|	dbo_pricetype.Ссылка,
	|	dbo_pricetype.id,
	|	dbo_pricetype.name,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_pricetype.is_regular,
	|	dbo_pricetype.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_pricetype КАК dbo_pricetype
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_assortmenttype"",
	|	dbo_assortmenttype.Ссылка,
	|	dbo_assortmenttype.id,
	|	dbo_assortmenttype.name,
	|	NULL,
	|	dbo_assortmenttype.is_active,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_assortmenttype.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_assortmenttype КАК dbo_assortmenttype
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_shopmarker"",
	|	dbo_shopmarker.Ссылка,
	|	dbo_shopmarker.id,
	|	dbo_shopmarker.name,
	|	dbo_shopmarker.parent_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shopmarker.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_shopmarker КАК dbo_shopmarker
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_shopmarkerm2m"",
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shopmarkerm2m.marker_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_shopmarkerm2m.shop_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_shopmarkerm2m КАК dbo_shopmarkerm2m
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_productmarker"",
	|	dbo_productmarker.Ссылка,
	|	dbo_productmarker.id,
	|	dbo_productmarker.name,
	|	dbo_productmarker.parent_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_productmarker.Представление,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_productmarker КАК dbo_productmarker
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_productmarkerm2m"",
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_productmarkerm2m.marker_id,
	|	dbo_productmarkerm2m.product_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_productmarkerm2m КАК dbo_productmarkerm2m
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""dbo_assortment"",
	|	NULL,
	|	dbo_assortment.id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_assortment.product_id,
	|	NULL,
	|	NULL,
	|	dbo_assortment.shop_id,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	NULL,
	|	dbo_assortment.type_id,
	|	dbo_assortment.modified_at
	|ИЗ
	|	ВнешнийИсточникДанных.PlanoHeroAttika.Таблица.dbo_assortment КАК dbo_assortment
	|
	|УПОРЯДОЧИТЬ ПО
	|	Таблица";
	
КонецПроцедуры
#КонецОбласти


//сервер nielsenbis
//база PlanoHeroAttika
//пользователь для 1С: planoheroattika1c
//пароль: Wh@V1D@1tG4S

//Driver={SQL Server}; Server=nielsenbis; Database=PlanoHeroAttika;

