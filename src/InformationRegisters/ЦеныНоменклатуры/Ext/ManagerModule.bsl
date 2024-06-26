﻿#Область ПрограммныйИнтерфейс

// Параметры:
//  номенклатураСсылка - СправочникСсылка.Номенклатура
//  период - Дата, МоментВремени, Граница
// Возвращаемое значение:
//  - Число - Актуальная цена `номенклатуры` на `период`
//  - Неопределено
Функция ПолучитьЦенуНоменклатуры(Знач номенклатураСсылка, Знач период) Экспорт
    запрос = Новый Запрос;
    запрос.УстановитьПараметр("Период", период);
    запрос.УстановитьПараметр("Номенклатура", номенклатураСсылка);
    запрос.Текст =
        "ВЫБРАТЬ
        |	ЦеныНоменклатурыСрезПоследних.Сумма КАК Сумма
        |ИЗ
        |	РегистрСведений.ЦеныНоменклатуры.СрезПоследних(&Период, Номенклатура = &Номенклатура) КАК ЦеныНоменклатурыСрезПоследних
        |";

    результатЗапроса = запрос.Выполнить();
    Если результатЗапроса.Пустой() Тогда
        Возврат Неопределено;
    КонецЕсли;

    таблицаЦен = результатЗапроса.Выгрузить();
    Возврат таблицаЦен[0].Сумма;
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс
