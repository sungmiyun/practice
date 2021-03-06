
--------------------------------------------------------
--  DDL for Sequence SEQ_MEMBER  ???? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_MEMBER"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_BOARD ?Խù? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_BOARD"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_BOARD_FILE ???? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_BOARD_FILE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_COMMENT ???? ?????? 
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_COMMENT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_COURSE ?ڽ???õ ?? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_COURSE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_FILE ???? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_FILE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 81 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PRODUCT ??ǰ?? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_PRODUCT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PRO_REPLY ??ǰ?? ???? ??????
--------------------------------------------------------

   CREATE SEQUENCE  "ZARA"."SEQ_PRO_REPLY"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BOARD
--------------------------------------------------------

  CREATE TABLE "ZARA"."BOARD" 
   (   "BNO" NUMBER, 
   "MEM_NO" VARCHAR2(30 BYTE), 
   "TITLE" VARCHAR2(50 BYTE), 
   "CONTENT" VARCHAR2(500 BYTE), 
   "CATEGORY" VARCHAR2(50 BYTE), 
   "CREATE_AT" DATE, 
   "UPDATE_AT" DATE, 
    "DELETE_AT" DATE,
    "DEL_YN" char(2),
   "HIT" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
-----------------------------------------F---------------
--  DDL for Table COMMENTS
--------------------------------------------------------

  CREATE TABLE "ZARA"."COMMENTS" 
   (   "CNO" NUMBER(*,0), 
   "BNO" NUMBER(*,0), 
   "MEM_ID" VARCHAR2(20 BYTE), 
   "CONTENT" VARCHAR2(500 BYTE), 
   "CREATE_AT" DATE, 
   "UPDATE_AT" DATE,
    "parent_no" number,
    "depth" number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table COURSE
--------------------------------------------------------

  CREATE TABLE "ZARA"."COURSE" 
   (   
    "COS_NUM" NUMBER(*,0), 
   "MEM_NO" VARCHAR2(30 BYTE), 
   "COS_CATEGORY" NUMBER(*,0), 
   "COS_TITLE" VARCHAR2(50 BYTE), 
   "COS_CONTENT" CLOB, 
   "HIT" NUMBER(*,0) DEFAULT 0, 
   "CREATE_AT" DATE, 
   "UPDATE_AT" DATE,
    "DELETE_AT" DATE,
    "DEL_YN" char(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 LOB ("COS_CONTENT") STORE AS BASICFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
--------------------------------------------------------
--  DDL for Table FILES
--------------------------------------------------------

  CREATE TABLE "ZARA"."FILES" 
   (   "FID" NUMBER(*,0), 
   "NO" NUMBER(*,0), 
   "TABLE_NAME" VARCHAR2(50 BYTE), 
   "FILE_NAME" VARCHAR2(100 BYTE), 
   "FILE_REAL_NAME" VARCHAR2(100 BYTE), 
   "FILE_PATH" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MEMBER
--------------------------------------------------------

  CREATE TABLE "ZARA"."MEMBER" 
   (
    "MEM_NO" int not null,
    "MEM_ID" VARCHAR2(30 BYTE), 
   "MEM_PASSWORD" VARCHAR2(100 BYTE), 
   "MEM_NAME" VARCHAR2(10 BYTE), 
   "MEM_TEL" VARCHAR2(30 BYTE), 
   "MEM_EMAIL" VARCHAR2(30 BYTE), 
   "MEM_ZIP" VARCHAR2(50 BYTE), 
   "MEM_ROAD" VARCHAR2(50 BYTE), 
   "MEM_ADRDETAIL" VARCHAR2(50 BYTE), 
   "GENDER" VARCHAR2(10 BYTE), 
   "CREATE_AT" DATE, 
   "UPDATE_AT" DATE, 
   "LAST_LOGIN" DATE, 
   "DEL_YN" CHAR(1 BYTE) DEFAULT 'N', 
   "DELETE_AT" DATE, 
   "MEM_POINT" NUMBER, 
   "MEM_TYPE" NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PRODUCT
--------------------------------------------------------

  CREATE TABLE "ZARA"."PRODUCT" 
   (   "PNO" NUMBER(*,0), 
   "MEM_NO" VARCHAR2(30 BYTE), 
   "PRO_CATEGORY" VARCHAR2(10 BYTE), 
   "PRO_NAME" VARCHAR2(50 BYTE), 
   "PRO_PRICE" NUMBER(*,0), 
   "PRO_INFO" VARCHAR2(500 BYTE), 
   "PRO_POINT" NUMBER DEFAULT 0, 
   "PRO_STOCK" NUMBER(*,0) DEFAULT 0, 
   "PRO_WEIGHT" NUMBER(*,0), 
   "PRO_COM" VARCHAR2(30 BYTE), 
   "PRO_STATUS" VARCHAR2(20 BYTE), 
   "PRO_DATE" DATE, 
   "UPDATE_AT" DATE, 
    "DELETE_AT" DATE,
    "DEL_YN" CHAR(2),
   "PRO_SUM" NUMBER(*,0), 
   "PRO_HIT" NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PRO_COMMENTS
--------------------------------------------------------

  CREATE TABLE "ZARA"."PRO_COMMENTS" 
   (   "CNO" NUMBER(*,0), 
   "PNO" NUMBER(*,0), 
   "WRITER" VARCHAR2(20 BYTE), 
   "CONTENT" VARCHAR2(500 BYTE), 
   "CREATE_AT" DATE, 
   "UPDATE_AT" DATE, 
   "DEPTH" NUMBER DEFAULT 0, 
   "PARENT_NO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

--------------------------------------------------------
--  DDL for Index PK_PRODUCT
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."PK_PRODUCT" ON "ZARA"."PRODUCT" ("PNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index COURSE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."COURSE_PK" ON "ZARA"."COURSE" ("COS_NUM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_PRO_COMMENTS
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."PK_PRO_COMMENTS" ON "ZARA"."PRO_COMMENTS" ("CNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_MEMBER
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."PK_MEMBER" ON "ZARA"."MEMBER" ("MEM_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_COMMENT
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."PK_COMMENT" ON "ZARA"."COMMENTS" ("CNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_FILE
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."PK_FILE" ON "ZARA"."FILES" ("FID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_BOARD
--------------------------------------------------------

  CREATE UNIQUE INDEX "ZARA"."PK_BOARD" ON "ZARA"."BOARD" ("BNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table PRO_COMMENTS
--------------------------------------------------------

  ALTER TABLE "ZARA"."PRO_COMMENTS" ADD CONSTRAINT "PK_PRO_COMMENTS" PRIMARY KEY ("CNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."PRO_COMMENTS" MODIFY ("CNO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRO_COMMENTS" MODIFY ("PNO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRO_COMMENTS" MODIFY ("WRITER" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRO_COMMENTS" MODIFY ("CONTENT" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRO_COMMENTS" MODIFY ("CREATE_AT" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MEMBER
--------------------------------------------------------

  ALTER TABLE "ZARA"."MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY ("MEM_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_NO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_PASSWORD" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_TEL" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_EMAIL" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_ZIP" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_ROAD" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("MEM_ADRDETAIL" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("GENDER" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."MEMBER" MODIFY ("CREATE_AT" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FILES
--------------------------------------------------------

  ALTER TABLE "ZARA"."FILES" ADD CONSTRAINT "PK_FILE" PRIMARY KEY ("FID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."FILES" MODIFY ("FID" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."FILES" MODIFY ("NO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."FILES" MODIFY ("TABLE_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."FILES" MODIFY ("FILE_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."FILES" MODIFY ("FILE_REAL_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."FILES" MODIFY ("FILE_PATH" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "ZARA"."BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY ("BNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."BOARD" MODIFY ("BNO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."BOARD" MODIFY ("MEM_NO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."BOARD" MODIFY ("TITLE" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."BOARD" MODIFY ("CONTENT" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."BOARD" MODIFY ("CATEGORY" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."BOARD" MODIFY ("CREATE_AT" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table COURSE
--------------------------------------------------------

  ALTER TABLE "ZARA"."COURSE" ADD CONSTRAINT "COURSE_PK" PRIMARY KEY ("COS_NUM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."COURSE" MODIFY ("COS_NUM" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COURSE" MODIFY ("MEM_NO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COURSE" MODIFY ("COS_CATEGORY" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COURSE" MODIFY ("COS_TITLE" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COURSE" MODIFY ("COS_CONTENT" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COURSE" MODIFY ("CREATE_AT" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PRODUCT
--------------------------------------------------------

  ALTER TABLE "ZARA"."PRODUCT" ADD CONSTRAINT "PK_PRODUCT" PRIMARY KEY ("PNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PNO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("MEM_NO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_CATEGORY" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_PRICE" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_POINT" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_STOCK" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_WEIGHT" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_COM" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_STATUS" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_DATE" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."PRODUCT" MODIFY ("PRO_SUM" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table COMMENTS
--------------------------------------------------------

  ALTER TABLE "ZARA"."COMMENTS" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY ("CNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "ZARA"."COMMENTS" MODIFY ("CNO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COMMENTS" MODIFY ("BNO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COMMENTS" MODIFY ("MEM_NO" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COMMENTS" MODIFY ("CONTENT" NOT NULL ENABLE);
 
  ALTER TABLE "ZARA"."COMMENTS" MODIFY ("CREATE_AT" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "ZARA"."BOARD" ADD CONSTRAINT "BOARD_FK" FOREIGN KEY ("MEM_NO")
     REFERENCES "ZARA"."MEMBER" ("MEM_NO") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COMMENTS
--------------------------------------------------------

  ALTER TABLE "ZARA"."COMMENTS" ADD CONSTRAINT "COMMENTS_FK" FOREIGN KEY ("BNO")
     REFERENCES "ZARA"."BOARD" ("BNO") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COURSE
--------------------------------------------------------

  ALTER TABLE "ZARA"."COURSE" ADD CONSTRAINT "COURSE_FK" FOREIGN KEY ("MEM_NO")
     REFERENCES "ZARA"."MEMBER" ("MEM_NO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRODUCT
--------------------------------------------------------

  ALTER TABLE "ZARA"."PRODUCT" ADD CONSTRAINT "FK_MEMBER_TO_PRODUCT_1" FOREIGN KEY ("MEM_NO")
     REFERENCES "ZARA"."MEMBER" ("MEM_NO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRO_COMMENTS
--------------------------------------------------------

  ALTER TABLE "ZARA"."PRO_COMMENTS" ADD CONSTRAINT "FK_PRODUCT" FOREIGN KEY ("PNO")
     REFERENCES "ZARA"."PRODUCT" ("PNO") ON DELETE CASCADE ENABLE;