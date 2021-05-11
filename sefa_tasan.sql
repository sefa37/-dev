create database vize;
use vize;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";





DROP TABLE IF EXISTS departman;
CREATE TABLE IF NOT EXISTS departman (
  deparmanid int(11) NOT NULL AUTO_INCREMENT,
  doktorid int(11) NOT NULL,
  hastaid int(11) NOT NULL,
  randevuid int(11) NOT NULL,
  departmanad varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (deparmanid),
  KEY doktorid (doktorid,hastaid,randevuid),
  KEY hastaid (hastaid),
  KEY randevuid (randevuid)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;



INSERT INTO departman (deparmanid, doktorid, hastaid, randevuid, departmanad) VALUES
(1, 1, 1, 1, 'Kalp damar'),
(2, 1, 1, 1, 'Noroloji');


DROP TABLE IF EXISTS doktor;
CREATE TABLE IF NOT EXISTS doktor (
  Doktorid int(11) NOT NULL AUTO_INCREMENT,
  Doktorad varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  Doktorsoyad varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  Brans varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  Referansno int(20) NOT NULL,
  Randevuid int(20) NOT NULL,
  PRIMARY KEY (Doktorid),
  KEY Randevuid (Randevuid)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;


INSERT INTO doktor (Doktorid, Doktorad, Doktorsoyad, Brans, Referansno, Randevuid) VALUES
(1, 'Mehmet', 'Parlak', 'Kardiyoloji', 10, 1),
(2, 'Ahmet', 'ışık', 'Noroloji', 10, 1);



DROP TABLE IF EXISTS hasta;
CREATE TABLE IF NOT EXISTS hasta (
  Hastaid int(11) NOT NULL AUTO_INCREMENT,
  Hastaad varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  Hastasoyad varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  Hastatc varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  dogumtarihi date NOT NULL,
  tel varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (Hastaid)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;


INSERT INTO hasta (Hastaid, Hastaad, Hastasoyad, Hastatc, dogumtarihi, tel) VALUES
(1, 'Ahmet', 'çelik', '1234567897', '2001-07-13', '546789454'),
(2, 'Mehmet', 'Çelik', '1234567898', '2000-09-12', '5467894541'),
(3, 'Fatma', 'Çelik', '1234567898', '2001-05-20', '5467894541');





DROP TABLE IF EXISTS randevu;
CREATE TABLE IF NOT EXISTS randevu (
  randevuid int(11) NOT NULL AUTO_INCREMENT,
  hastaid int(11) NOT NULL,
  randevutarihi date NOT NULL,
  PRIMARY KEY (randevuid),
  KEY hastaid (hastaid)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;



INSERT INTO randevu (randevuid, hastaid, randevutarihi) VALUES
(1, 1, '2021-05-12'),
(2, 1, '2021-05-13');



DROP TABLE IF EXISTS tahlil;
CREATE TABLE IF NOT EXISTS tahlil (
  Tahlilid int(11) NOT NULL AUTO_INCREMENT,
  Tahliltür varchar(250) COLLATE utf8_turkish_ci NOT NULL,
  hastaid int(11) NOT NULL,
  doktorid int(11) NOT NULL,
  deparmanid int(11) NOT NULL,
  sonuç text COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (Tahlilid),
  KEY hastaid (hastaid,doktorid,deparmanid),
  KEY deparmanid (deparmanid),
  KEY doktorid (doktorid)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;


INSERT INTO tahlil (Tahlilid, Tahliltür, hastaid, doktorid, deparmanid, sonuç) VALUES
(1, 'Kan Tahlili', 1, 1, 1, 'Temiz'),
(2, 'Kan Tahlili', 1, 1, 1, 'Kanda mikrop var');

-- --------------------------------------------------------



DROP TABLE IF EXISTS tani;
CREATE TABLE IF NOT EXISTS tani (
  Taniid int(11) NOT NULL AUTO_INCREMENT,
  Doktorid int(11) NOT NULL,
  Hastaid int(11) NOT NULL,
  tanıtarihi date NOT NULL,
  tahlilid int(11) NOT NULL,
  deparmanid int(11) NOT NULL,
  tedavi text COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (Taniid),
  KEY Hastaid (Hastaid),
  KEY tahlilid (tahlilid,deparmanid),
  KEY deparmanid (deparmanid),
  KEY Doktorid (Doktorid)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;



INSERT INTO tani (Taniid, Doktorid, Hastaid, tanıtarihi, tahlilid, deparmanid, tedavi) VALUES
(1, 1, 1, '2021-05-11', 1, 1, 'Herhangi bir tedaviye gerek görülmedi'),
(2, 1, 1, '2021-05-11', 1, 1, 'Antibiyotik tedavisi');


ALTER TABLE departman
  ADD CONSTRAINT departman_ibfk_1 FOREIGN KEY (doktorid) REFERENCES doktor (Doktorid) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT departman_ibfk_2 FOREIGN KEY (hastaid) REFERENCES hasta (Hastaid) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT departman_ibfk_3 FOREIGN KEY (randevuid) REFERENCES randevu (randevuid) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE doktor
  ADD CONSTRAINT doktor_ibfk_1 FOREIGN KEY (Randevuid) REFERENCES randevu (randevuid) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE randevu
  ADD CONSTRAINT randevu_ibfk_1 FOREIGN KEY (hastaid) REFERENCES hasta (Hastaid) ON DELETE CASCADE ON UPDATE CASCADE;



ALTER TABLE tahlil
  ADD CONSTRAINT tahlil_ibfk_1 FOREIGN KEY (deparmanid) REFERENCES departman (deparmanid) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT tahlil_ibfk_2 FOREIGN KEY (hastaid) REFERENCES hasta (Hastaid) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT tahlil_ibfk_3 FOREIGN KEY (doktorid) REFERENCES doktor (Doktorid) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE tani
  ADD CONSTRAINT tani_ibfk_1 FOREIGN KEY (Hastaid) REFERENCES hasta (Hastaid),
  ADD CONSTRAINT tani_ibfk_2 FOREIGN KEY (deparmanid) REFERENCES departman (deparmanid) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT tani_ibfk_3 FOREIGN KEY (tahlilid) REFERENCES tahlil (Tahlilid) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT tani_ibfk_4 FOREIGN KEY (Doktorid) REFERENCES doktor (Doktorid) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

select *from departman;


