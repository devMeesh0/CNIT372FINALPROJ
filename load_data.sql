/* 
* CNIT 372 
* The following code is used to create tables that sqldeveloper can then be used on to import data into the
* tables from the csv files included in this repository.
*/


CREATE TABLE COMMENTS (
    commentid NUMBER(10),
    videoid VARCHAR2(255),
    commentcontent NVARCHAR2(1000),
    likes NUMBER(15,2),
    sentiment NUMBER(15,2)
);


/*
* Formatting for the publishedat field is as follows: YYYY-MM-DD
*/
CREATE TABLE VIDEOSTATS (
    recordid NUMBER(10),
    title VARCHAR2(255),
    videoid VARCHAR2(255),
    publishedat DATE,
    keyword VARCHAR2(20),
    likes NUMBER(20,2),
    comments NUMBER(20,2),
    views NUMBER(20,2)
);


/* When importing data into this table, place the following columns into the available columns box:
Unemployment rate
longitude
latitude
gross tertiary education enrollment*/
CREATE TABLE GLOBALSTATS (
    rank VARCHAR2(20),
    youtuber VARCHAR2(100),
    subscribers VARCHAR2(20),
    videoveiws VARCHAR2(20),
    category VARCHAR2(100),
    title VARCHAR2(255),
    uploads VARCHAR2(20),
    country VARCHAR2(20),
    abbrevcountry VARCHAR2(5),
    channeltype VARCHAR2(50),
    videoviewsrank VARCHAR2(20),
    countryrank VARCHAR2(20),
    channeltyperank VARCHAR2(20),
    views30days VARCHAR2(20),
    lowestmonthlyearnings VARCHAR2(20),
    highestmonthlyearnings VARCHAR2(20),
    lowestyearlyearnings VARCHAR2(20),
    highestyearlyearnings VARCHAR2(20),
    subs30days VARCHAR2(20),
    yearcreated VARCHAR2(20),
    monthcreated VARCHAR2(15),
    datecreated VARCHAR2(20),
    grosstertiaryenrollment NUMBER(10,2),
    population VARCHAR2(20),
    unemploymentrate NUMBER(10,2),
    urbanpop VARCHAR2(20),
    latitude NUMBER(10,10),
    longitude NUMBER(10,10)
);


DROP TABLE COMMENTS;

DROP TABLE GLOBALSTATS;

DROP TABLE VIDEOSTATS;