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

*/
-- 20_pkg.sql - Таблицы для компиляции и установки пакетов
/* ------------------------------------------------------------------------- */


/* ------------------------------------------------------------------------- */
CREATE TABLE compile_errors (
  data    TEXT
  , stamp TIMESTAMP DEFAULT current_timestamp
  , usr   TEXT DEFAULT current_user
  , ip    INET DEFAULT inet_client_addr()
);

COMMENT ON TABLE compile_errors IS 'Ошибки компиляции';

/* ------------------------------------------------------------------------- */
CREATE TABLE pkg_log (
  id            INTEGER PRIMARY KEY
  , code        TEXT NOT NULL DEFAULT 'ws'
  , ver         TEXT NOT NULL DEFAULT '000'
  , op          CHAR(1) DEFAULT '+'
  , log_name    TEXT
  , user_name   TEXT
  , ssh_client  TEXT
  , usr         TEXT DEFAULT current_user
  , ip          INET DEFAULT inet_client_addr()
  , stamp       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE pkg_log IS 'Журнал изменений пакетов PGWS';

CREATE SEQUENCE pkg_id_seq;
ALTER TABLE pkg_log ALTER COLUMN id SET DEFAULT NEXTVAL('pkg_id_seq');

/* ------------------------------------------------------------------------- */
CREATE TABLE pkg (
  id            INTEGER NOT NULL UNIQUE
  , code        TEXT PRIMARY KEY -- для REFERENCES
  , ver         TEXT
  , op          CHAR(1) DEFAULT '+'
  , log_name    TEXT
  , user_name   TEXT
  , ssh_client  TEXT
  , usr         TEXT DEFAULT current_user
  , ip          INET DEFAULT inet_client_addr()
  , stamp       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE pkg IS 'Актуальные пакеты PGWS';


/* ------------------------------------------------------------------------- */
