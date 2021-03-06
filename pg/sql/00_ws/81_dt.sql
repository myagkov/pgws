/*

    Copyright (c) 2010, 2012 Tender.Pro http://tender.pro.

    This file is part of PGWS - Postgresql WebServices.

    PGWS is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    PGWS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with PGWS.  If not, see <http://www.gnu.org/licenses/>.

    Типы данных
*/

/* ------------------------------------------------------------------------- */
INSERT INTO dt (id, parent_id, code, anno) VALUES
  (1,   1,  'text',       'Текст')
, (2,   2,  'boolean',    'Да/Нет')
, (3,   3,  'numeric',    'Число')
, (4,   4,  'interval',   'Интервал')
, (5,   5,  'timestamp',  'Момент')
, (6,   6,  'time',       'Время')
, (7,   7,  'date',       'Дата')
, (8,   8,  'inet',       'ip адрес')
, (9,   9,  'real',       'Число')
, (11,  11, 'integer',    'Целое')
, (12,  12, 'smallint',   'Короткое целое')
, (13,  13, 'oid',        'OID')
, (14,  14, 'double',     'Длинное вещественное число')
, (15,  15, 'bigint',     'Длинное целое')
, (16,  16, 'json',       'Данные в формате JSON')
, (17,  17, 'uuid',       'Universally Unique IDentifier')
;
-- parent для массива хэшей, но они пока не поддерживаются DBD::Pg
-- INSERT INTO dt (id, parent_id, code, anno) VALUES (21, 21, 'composite', 'Структура');


/* ------------------------------------------------------------------------- */
INSERT INTO facet (id, code, anno) VALUES
  ( 1, 'length',         'Длина')
, ( 2, 'minLength',      'Мин. длина')
, ( 3, 'maxLength',      'Макс. длина')
, ( 4, 'pattern',        'Шаблон')
, ( 5, 'enumeration',    'Список значений')
, ( 6, 'whiteSpace',     'Обработка пробелов') --  (preserve|replace|collapse)
, ( 7, 'maxInclusive',   'Не больше')
, ( 8, 'maxExclusive',   'Меньше')
, ( 9, 'minExclusive',   'Больше')
, (10, 'minInclusive',   'Не меньше')
, (11, 'totalDigits',    'Количество знаков')
, (12, 'fractionDigits', 'Знаков дробной части')
;

INSERT INTO facet_dt_base (id, base_id) VALUES
  ( 1, 1)
, ( 2, 1)
, ( 3, 1)
, ( 6, 1)

, ( 7, 3)
, ( 8, 3)
, ( 9, 3)
, (10, 3)
, (11, 3)
, (12, 3)

, ( 7, 11)
, ( 8, 11)
, ( 9, 11)
, (10, 11)
, (11, 11)

, ( 7, 12)
, ( 8, 12)
, ( 9, 12)
, (10, 12)
, (11, 12)
;

-- parent для массива хэшей, но они пока не поддерживаются DBD::Pg
INSERT INTO facet_dt_base SELECT 4, id FROM dt WHERE id = parent_id; --  AND id <> dt_id('composite');

INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('boolean'), facet_id('pattern'), E'^([01tf]|on|off)$', 'только 0,1,t,f,on или off');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('numeric'), facet_id('pattern'), E'^(\\+|\\-)?(\\d)*(\\.\\d+)?$','[знак]целая часть[.дробная часть]');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('real'), facet_id('pattern'), E'^(\\+|\\-)?(\\d)*(\\.\\d+)?$','[знак]целая часть[.дробная часть]');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('integer'), facet_id('pattern'), E'^(\\+|\\-)?\\d+$', '[знак]цифры');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('smallint'), facet_id('pattern'), E'^(\\+|\\-)?\\d+$', '[знак]цифры');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('bigint'),  facet_id('pattern'), E'^(\\+|\\-)?\\d+$', '[знак]цифры');

INSERT INTO dt_facet VALUES (dt_id('oid'), facet_id('pattern'), E'^\d+$');

-- TODO: INSERT INTO dt_facet VALUES (dt_id('uuid'), facet_id('pattern'), E'????');

INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('date'), facet_id('pattern'), E'^\\d{1,2}\\.\\d{2}\\.\\d{4}$', 'ДД.ММ.ГГГГ');

-- INSERT INTO dt_facet VALUES (dt_id('integer'), facet_id('fractionDigits'), 0);
INSERT INTO dt_facet VALUES (dt_id('integer'), facet_id('minInclusive'), -2147483648);
INSERT INTO dt_facet VALUES (dt_id('integer'), facet_id('maxInclusive'), 2147483647);

INSERT INTO dt_facet VALUES (dt_id('smallint'), facet_id('minInclusive'), -32768);
INSERT INTO dt_facet VALUES (dt_id('smallint'), facet_id('maxInclusive'), 32767);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_id'), dt_id('integer'), 'Идентификатор');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_id32'), dt_id('smallint'), 'Идентификатор справочника');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_stamp'), dt_id('timestamp'), 'Момент времени с точностью до секунды');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('d_stamp'), facet_id('pattern')
, E'^\\d{1,2}\\.\\d{2}\\.\\d{4}(?: +| +/ +)\\d{2}:\\d{2}(:\\d{2})?$', 'ДД.ММ.ГГГГ ЧЧ:ММ[:СС]');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_rating'), dt_id('numeric'), 'Рейтинг компании');
INSERT INTO dt_facet VALUES (dt_id('d_rating'), facet_id('minInclusive'), -2);
INSERT INTO dt_facet VALUES (dt_id('d_rating'), facet_id('maxInclusive'), 2);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_sort'), dt_id('smallint'), 'Порядок сортировки');
INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_regexp'), dt_id('text'), 'Регулярное выражение');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_decimal_positive'), dt_id('numeric'), 'Вещественное > 0');
INSERT INTO dt_facet VALUES (dt_id('d_decimal_positive'), facet_id('minExclusive'), 0);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_id_positive'), dt_id('integer'), 'Целое > 0');
INSERT INTO dt_facet VALUES (dt_id('d_id_positive'), facet_id('minExclusive'), 0);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_decimal_non_neg'), dt_id('numeric'), 'Вещественное >= 0');
INSERT INTO dt_facet VALUES (dt_id('d_decimal_non_neg'), facet_id('minInclusive'), 0);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_sid'), dt_id('text'), 'Идентификатор сессии');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_zip'), dt_id('text'), 'Почтовый индекс');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('d_zip'), facet_id('pattern'), E'^[a-zA-Zа-яА-я0-9][a-zA-Zа-яА-я0-9 \-]{2,11}','index');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_text'), dt_id('text'), 'Текст');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_string'), dt_id('text'), 'Текстовая строка');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('d_string'), facet_id('pattern'), E'^[^\n]','NO CR');


INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_login'), dt_id('text'), 'Логин');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('d_login'), facet_id('pattern'), E'^[a-zA-Z0-9\\.+_@\\-]{5,}$','login');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_email'), dt_id('text'), 'Адрес email');
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('d_email'), facet_id('pattern'), E'(?:^$|^[^ ]+@[^ ]+\\.[^ ]{2,6}$)','your@email.ru');

INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_emails'), dt_id('text'), 'Список адресов email', true);
INSERT INTO dt_facet (id, facet_id, value, anno) VALUES (dt_id('d_emails'), facet_id('pattern'), E'(?:^$|^[^ ]+@[^ ]+\\.[^ ]{2,6}$)','your@email.ru');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_path'), dt_id('text'), 'Относительный путь');
INSERT INTO dt_facet VALUES (dt_id('d_path'), facet_id('pattern'), E'^(|[a-z\\d_][a-z\\d\\.\\-_/]+)$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_class'), dt_id('d_id32'), 'ID класса');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_non_neg_int'), dt_id('d_id'), 'Неотрицательное целое');
INSERT INTO dt_facet VALUES (dt_id('d_non_neg_int'), facet_id('minInclusive'), 0);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_cnt'), dt_id('d_non_neg_int'), 'Количество элементов');
INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_amount'), dt_id('numeric'), 'Количество товара');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_format'), dt_id('text'), 'Формат для printf');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_code'), dt_id('text'), 'Имя переменной');
INSERT INTO dt_facet VALUES (dt_id('d_code'), facet_id('pattern'), E'^[a-z\\d][a-z\\d\\.\\-_]*$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_code_arg'), dt_id('text'), 'Имя аргумента');
INSERT INTO dt_facet VALUES (dt_id('d_code_arg'), facet_id('pattern'), E'^[a-z\\d_][a-z\\d\\.\\-_]*$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_codei'), dt_id('text'), 'Имя переменной в любом регистре');
INSERT INTO dt_facet VALUES (dt_id('d_codei'), facet_id('pattern'), E'^[a-z\\d][a-z\\d\\.\\-_A-Z]*$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_code_like'), dt_id('text'), 'Шаблон имени переменной');
INSERT INTO dt_facet VALUES (dt_id('d_code_like'), facet_id('pattern'), E'^[a-z\\d\\.\\-_\\%]+$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_sub'), dt_id('text'), 'Имя внешнего метода');
INSERT INTO dt_facet VALUES (dt_id('d_sub'), facet_id('pattern'), E'^([a-z\\d][a-z\\d\\.\\-_]+)|([A-Z\\d][a-z\\d\\.\\-_\:A-Z]+)$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_lang'), ws.dt_id('text'), 'Идентификатор языка');
INSERT INTO dt_facet VALUES (dt_id('d_lang'), facet_id('pattern'), E'^(?:ru|en)$');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_errcode'), dt_id('text'), 'Код ошибки');
INSERT INTO dt_facet VALUES (dt_id('d_errcode'), facet_id('length'), 5);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_money'), dt_id('numeric'), 'Деньги');

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('t_hashtable'), 'Хэштаблица', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_hashtable'), 1, 'id',  dt_id('d_id32'), 'ID');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_hashtable'), 2, 'name', dt_id('text'), 'Название');

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_acl'), dt_id('d_id32'), 'Уровень доступа');
INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_acls'), dt_id('d_acl'), 'Массив уровней доступа', true);

INSERT INTO dt (code, parent_id, anno) VALUES (pg_cs('d_bitmask'), dt_id('d_id32'), 'Битовая маска');

INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_booleana'), dt_id('boolean'), 'Массив boolean', true);
INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_texta'), dt_id('text'), 'Массив text', true);
INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_id32a'), dt_id('d_id32'), 'Массив d_id32', true);
INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_codea'), dt_id('d_code'), 'Массив d_code', true);

INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_ida'), dt_id('d_id'), 'Массив d_id', true);
INSERT INTO dt (code, parent_id, anno, is_list) VALUES (pg_cs('d_moneya'), dt_id('d_money'), 'Массив d_money', true);

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('z_uncache'), 'Аргументы функций cache_uncache', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_uncache'), 1, 'code', dt_id('text'), 'код метода');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_uncache'), 2, 'key', dt_id('text'), 'ключ кэша');

/*
  -- RESERVED
INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('z_cache_reset'), 'Аргументы функций cache_reset', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_cache_reset'), 1, 'keys', dt_id('text'), 'ключи');
*/

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('z_acl_check'), 'Аргументы функций acl_check', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_acl_check'), 1, '_sid', dt_id('text'), 'ID сессии');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_acl_check'), 2, 'class_id', dt_id('d_class'), 'ID класса');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_acl_check'), 3, 'action_id', dt_id('d_id32'), 'ID акции');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_acl_check'), 4, 'id', dt_id('d_id'), 'ID объекта');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_acl_check'), 5, 'id1', dt_id('d_id'), 'ID1 объекта');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_acl_check'), 6, 'id2', dt_id('text'), 'ID2 объекта');

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('z_store_get'), 'Аргументы функций store_get', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_store_get'), 1, 'path',   dt_id('d_path'), 'ID данных');

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('z_store_set'), 'Аргументы функций store_set', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_store_set'), 1, 'path',   dt_id('d_path'), 'ID данных');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('z_store_set'), 2, 'data',   dt_id('text'), 'данные');

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('t_page_info'), 'Параметры страницы', true);

INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 1, 'req', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 2, 'code', dt_id('d_code'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 3, 'up_code', dt_id('d_code'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 4, 'class_id', dt_id('d_class'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 5, 'action_id', dt_id('d_id32'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 6, 'sort', dt_id('d_sort'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 7, 'uri', dt_id('d_regexp'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 8, 'tmpl', dt_id('d_path'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 9, 'name', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 10, 'uri_re', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_page_info'), 11, 'uri_fmt', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno, is_list) VALUES (dt_id('t_page_info'), 12, 'args', dt_id('text'), '', true);

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('t_pg_proc_info'), 'Параметры хранимой процедуры', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 1, 'schema', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 2, 'name', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 3, 'anno', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 4, 'rt_oid', dt_id('oid'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 5, 'rt_name', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 6, 'is_set', dt_id('boolean'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 7, 'args', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_pg_proc_info'), 8, 'args_pub', dt_id('text'), '');

INSERT INTO dt (code, anno, is_complex) VALUES (pg_cs('t_acl_check'), 'Результат проверки ACL', true);
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_acl_check'), 1, 'value', dt_id('integer'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_acl_check'), 2, 'id', dt_id('integer'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_acl_check'), 3, 'code', dt_id('text'), '');
INSERT INTO dt_part (id, part_id, code, parent_id, anno) VALUES (dt_id('t_acl_check'), 4, 'name', dt_id('text'), '');

/* ------------------------------------------------------------------------- */
