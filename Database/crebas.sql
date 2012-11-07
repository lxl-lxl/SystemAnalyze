/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2012/11/7 14:37:44                           */
/*==============================================================*/


drop table if exists Album;

drop table if exists Album_Singer;

drop table if exists Comment;

drop table if exists Company;

drop table if exists Music;

drop table if exists MusicType;

drop table if exists Music_Album;

drop table if exists Music_MusicType;

drop table if exists Music_Quality;

drop table if exists Quality;

drop table if exists Singer;

drop table if exists Singer_Music;

drop table if exists User;

drop table if exists User_Music;

drop table if exists User_MusicType;

drop table if exists User_Singer;

/*==============================================================*/
/* Table: Album                                                 */
/*==============================================================*/
create table Album
(
   AlbumID              varchar(255) not null,
   AlbumName            varchar(255) not null,
   AlbumTime            date not null,
   AlbumImage           varchar(255),
   primary key (AlbumID)
);

/*==============================================================*/
/* Table: Album_Singer                                          */
/*==============================================================*/
create table Album_Singer
(
   SID                  varchar(255) not null,
   AlbumID              varchar(255) not null,
   primary key (SID, AlbumID)
);

/*==============================================================*/
/* Table: Comment                                               */
/*==============================================================*/
create table Comment
(
   CommentID            varchar(255) not null,
   MID                  varchar(255) not null,
   UID                  varchar(255) not null,
   CommentContent       text not null,
   primary key (CommentID)
);

/*==============================================================*/
/* Table: Company                                               */
/*==============================================================*/
create table Company
(
   CID                  varchar(255) not null,
   CName                varchar(255) not null,
   CAddr                varchar(255) not null,
   CTel                 int not null,
   primary key (CID)
);

/*==============================================================*/
/* Table: Music                                                 */
/*==============================================================*/
create table Music
(
   MID                  varchar(255) not null,
   MName                varchar(255) not null,
   MLength              float not null,
   MDownloadCount       int not null,
   MSearchCount         int not null,
   MListenCount         int not null,
   MLyricUrl            varchar(255),
   primary key (MID)
);

/*==============================================================*/
/* Table: MusicType                                             */
/*==============================================================*/
create table MusicType
(
   TID                  varchar(255) not null,
   TName                varchar(255) not null,
   TIntro               text,
   primary key (TID)
);

alter table MusicType comment '音乐类型。';

/*==============================================================*/
/* Table: Music_Album                                           */
/*==============================================================*/
create table Music_Album
(
   MID                  varchar(255) not null,
   AlbumID              varchar(255) not null,
   primary key (MID, AlbumID)
);

/*==============================================================*/
/* Table: Music_MusicType                                       */
/*==============================================================*/
create table Music_MusicType
(
   MID                  varchar(255) not null,
   TID                  varchar(255) not null,
   primary key (MID, TID)
);

/*==============================================================*/
/* Table: Music_Quality                                         */
/*==============================================================*/
create table Music_Quality
(
   MID                  varchar(255) not null,
   QID                  varchar(255) not null,
   primary key (MID, QID)
);

/*==============================================================*/
/* Table: Quality                                               */
/*==============================================================*/
create table Quality
(
   QID                  varchar(255) not null,
   QUrl                 char(255) not null,
   QDescription         varchar(255) not null,
   primary key (QID)
);

/*==============================================================*/
/* Table: Singer                                                */
/*==============================================================*/
create table Singer
(
   SID                  varchar(255) not null,
   CID                  varchar(255),
   SName                varchar(255) not null,
   SNews                text not null,
   SSex                 char(2),
   SAge                 int,
   SFavourite           varchar(255),
   SOtherInfor          text,
   SImage               varchar(255),
   primary key (SID)
);

/*==============================================================*/
/* Table: Singer_Music                                          */
/*==============================================================*/
create table Singer_Music
(
   SID                  varchar(255) not null,
   MID                  varchar(255) not null,
   primary key (SID, MID)
);

/*==============================================================*/
/* Table: User                                                  */
/*==============================================================*/
create table User
(
   UID                  varchar(255) not null,
   UName                varchar(255) not null,
   URole                bool,
   USex                 char(2),
   UAge                 int,
   UEmail               varchar(255),
   UOtherInfo           text,
   UImage               varchar(255),
   primary key (UID)
);

alter table User comment '包括管理员和用户两种身份
';

/*==============================================================*/
/* Table: User_Music                                            */
/*==============================================================*/
create table User_Music
(
   UID                  varchar(255) not null,
   MID                  varchar(255) not null,
   ListenCounter        int not null,
   FavouriteTag         bool not null,
   primary key (UID, MID)
);

/*==============================================================*/
/* Table: User_MusicType                                        */
/*==============================================================*/
create table User_MusicType
(
   UID                  varchar(255) not null,
   TID                  varchar(255) not null,
   primary key (UID, TID)
);

/*==============================================================*/
/* Table: User_Singer                                           */
/*==============================================================*/
create table User_Singer
(
   UID                  varchar(255) not null,
   SID                  varchar(255) not null,
   primary key (UID, SID)
);

alter table Album_Singer add constraint FK_Album_Singer foreign key (SID)
      references Singer (SID) on delete restrict on update restrict;

alter table Album_Singer add constraint FK_Album_Singer2 foreign key (AlbumID)
      references Album (AlbumID) on delete restrict on update restrict;

alter table Comment add constraint FK_Music_Comment foreign key (MID)
      references Music (MID) on delete restrict on update restrict;

alter table Comment add constraint FK_User_Comment foreign key (UID)
      references User (UID) on delete restrict on update restrict;

alter table Music_Album add constraint FK_Music_Album foreign key (MID)
      references Music (MID) on delete restrict on update restrict;

alter table Music_Album add constraint FK_Music_Album2 foreign key (AlbumID)
      references Album (AlbumID) on delete restrict on update restrict;

alter table Music_MusicType add constraint FK_Music_MusicType foreign key (MID)
      references Music (MID) on delete restrict on update restrict;

alter table Music_MusicType add constraint FK_Music_MusicType2 foreign key (TID)
      references MusicType (TID) on delete restrict on update restrict;

alter table Music_Quality add constraint FK_Music_Quality foreign key (MID)
      references Music (MID) on delete restrict on update restrict;

alter table Music_Quality add constraint FK_Music_Quality2 foreign key (QID)
      references Quality (QID) on delete restrict on update restrict;

alter table Singer add constraint FK_Singer_Company foreign key (CID)
      references Company (CID) on delete restrict on update restrict;

alter table Singer_Music add constraint FK_Singer_Music foreign key (SID)
      references Singer (SID) on delete restrict on update restrict;

alter table Singer_Music add constraint FK_Singer_Music2 foreign key (MID)
      references Music (MID) on delete restrict on update restrict;

alter table User_Music add constraint FK_User_Music foreign key (UID)
      references User (UID) on delete restrict on update restrict;

alter table User_Music add constraint FK_User_Music2 foreign key (MID)
      references Music (MID) on delete restrict on update restrict;

alter table User_MusicType add constraint FK_User_MusicType foreign key (UID)
      references User (UID) on delete restrict on update restrict;

alter table User_MusicType add constraint FK_User_MusicType2 foreign key (TID)
      references MusicType (TID) on delete restrict on update restrict;

alter table User_Singer add constraint FK_User_Singer foreign key (UID)
      references User (UID) on delete restrict on update restrict;

alter table User_Singer add constraint FK_User_Singer2 foreign key (SID)
      references Singer (SID) on delete restrict on update restrict;

