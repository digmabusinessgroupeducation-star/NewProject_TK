
Функция ReturnItogIN(Date1, Date2, SkladID)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ВернутьИтогиИН(Date1,Date2,SkladID);	
	
КонецФункции

Функция ReturnItogIN_v2(Date1, Date2, SkladID)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ВернутьИтоги_ПериодОбщИНВ(Date1,Date2,SkladID);
	
КонецФункции

Функция SetStatusZUPtoIN(ArrayINV, Status)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.УстановитьСтатусЗУП_Инв(ArrayINV, Status);
	
КонецФункции



Функция ReturnTableINAttika(Date1, Date2)
	Возврат ТК_ЗУП_РаботаWebСервиса.ВернутьСуммыИнкассации(Date1,Date2);
КонецФункции

Функция ReturnSaleAmounPeriod(Date1, Date2, SkladID, ExcludeID)
	Возврат ТК_ЗУП_РаботаWebСервиса.ВернутьПродажиПоСкладу(Date1,Date2,SkladID,ExcludeID);
КонецФункции

Функция ReturnSaleAmoun(Date, SkladID, ExcludeID = "")
	Возврат ТК_ЗУП_РаботаWebСервиса.ВернутьПродажиПоСкладу(Date,,SkladID, ExcludeID);
КонецФункции


Функция ReturnRestGoods(Date, GuidWarehouse)
	Возврат ТК_ЗУП_РаботаWebСервиса.ВозвратОстатковТоваровНаСкладе(Date,GuidWarehouse);
КонецФункции


Функция ReturnTablePK(Date, ManagerID,KontragentID, OrganizatsiyaID, DepartmentID, Regl, variant)
	Возврат ТК_БУХ_УУ_РаботаWebСервиса.ПодготовитьданныеДляОплат(Date,ManagerID,KontragentID,OrganizatsiyaID,DepartmentID,Regl,variant);
КонецФункции


Функция ReturnArrayDocuments(Date1, Date2, TypeDoc, OnlyPosted, GuidOrganization, GuidPartner, GuidDepartment)
	Возврат ТК_БУХ_РаботаWebСервиса.ВернутьМассивДокументов(Date1, Date2, TypeDoc, OnlyPosted, GuidOrganization, GuidPartner, GuidDepartment);
КонецФункции

Функция ReturnAppResult(NameApp, NameFunction, Parameters)
	
	Возврат ТК_ОбменДаннымиСервер.СформироватьПакетДанныхДопОбработки(NameApp, NameFunction, Parameters);	
	
КонецФункции



//Гамазин
Функция ReturnInnerContragents()
	
	Возврат ТК_БУХ_РаботаWebСервиса.ПолучитьМассивОКПОВнутреннихКонтрагентов();
	
КонецФункции

Функция GetKuratorObjects(GuidFL)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьМассивКодовОбъектовКуратора(GuidFL);
	
КонецФункции

Функция ReturnKeratorObjectsList()
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьТаблицуКураторовИОбъектов();
	
КонецФункции	

Функция GetGoodsTree()
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьДеревоНоменклатуры();
	
КонецФункции

Функция ReturnSalesGoodsFilter(StartDate, EndDate, TableOfParameters)

	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьПродажиПоПодразделениямСФильтром(StartDate, EndDate, TableOfParameters);
	
КонецФункции

Функция ReturnScanKPI(StartDate, EndDate, ScanType, Parameters)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьДанныеПоСканированиюТСД(StartDate, EndDate, ScanType, Parameters);
	
КонецФункции	

//окончание Гамазин

Функция ReturnTableAR(Date,KontragentID, OrganizatsiyaID, DepartmentID, Regl)
	Возврат ТК_БУХ_УУ_РаботаWebСервиса.ПодготовитьданныеДляОплатАренды(Date,KontragentID, OrganizatsiyaID,DepartmentID,Regl);
КонецФункции

Функция ReturnCommunalPayments(Date,Mode)
	Если Mode = 1 Тогда
		Возврат ТК_БУХ_РаботаWebСервиса.НачисленияПоКоммунальнымУслугам(Date);
	ИначеЕсли Mode = 2 Тогда
		Возврат ТК_БУХ_УУ_РаботаWebСервиса.НачисленияПоКоммунальнымУслугам(Date);
	КонецЕсли;
КонецФункции

Функция ReturnCheckList(Code)
	Возврат Справочники.ШаблоныАнкет.АнкетаКТочкеДляСтартСтопа(Code);
КонецФункции

Функция LoadingCheckList(Data)
	Результат = Документы.Анкета.ЗагрузитьАнкетуИзСтартСтоп(Data);
	Возврат Результат;
КонецФункции

Функция GetObjectsSchedule(ArrayCodeObj)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьГрафикиРаботыТТ(ArrayCodeObj);
	
КонецФункции

Функция GetObjectsDetailedSchedule(ArrayCodeObj)
	
	Возврат ТК_ЗУП_РаботаWebСервиса.ПолучитьДетальныеГрафикиРаботыТТ(ArrayCodeObj);
	
КонецФункции








