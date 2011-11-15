drop table country_content;
drop table region_content;
drop table country_incident;
drop table region_incident;
drop table source;
drop table incident;
drop table incident_type;
drop table region_country;
drop table region;
drop table country;
drop table page;
drop table usr;

create table usr (
id varchar(64) not null,
    date_created datetime,
    last_updated datetime,
first_name varchar(255),
last_name varchar(255),
email varchar(255),
    primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table page (
id varchar(64) not null,
    date_created datetime,
    last_updated datetime,
    content text,
    primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table country (
id varchar(2),
name varchar(255),
lat real,
lon real,
bb_nw_lat real,
bb_nw_lon real,
bb_se_lat real,
bb_se_lon real,
primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table region (
id varchar(16),
type varchar(16),
name varchar(255),
lat real,
lon real,
primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table region_country (
region varchar(16),
country varchar(2),
    foreign key (region) references region(id),
    foreign key (country) references country(id),
    primary key (region, country)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table source (
id varchar(16) not null,
name varchar(255) not null,
primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table incident_type (
id varchar(16) not null,
name varchar(255) not null,
class varchar(255),
primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table incident (
    id integer auto_increment not null,
    date_created datetime,
    last_updated datetime,
    type varchar(16),
    source varchar(16),
    source_id varchar(64),
    usr varchar(64),
    descr text,
    lat real,
    lon real,
    foreign key (type) references incident_type(id),
    index incident_sourceid(source_id),
    primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table country_incident (
incident integer,
country varchar(16),
    foreign key (incident) references incident(id),
    foreign key (country) references country(id),
    primary key (incident,country)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table region_incident (
incident integer,
region varchar(16),
    foreign key (incident) references incident(id),
    foreign key (region) references region(id),
    primary key (incident,region)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table country_content (
country varchar(2) not null,
id varchar(16) not null,
    date_created datetime,
    last_updated datetime,
    content text,
    usr varchar(64) not null,
    foreign key (country) references country(id),
    foreign key (usr) references usr(id),
primary key (country, id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table region_content (
region varchar(16) not null,
id varchar(16) not null,
    date_created datetime,
    last_updated datetime,
    content text,
    usr varchar(64) not null,
    foreign key (region) references region(id),
    foreign key (usr) references usr(id),
primary key (region, id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
