/*
 * Copyright 1999-2018 Alibaba Group Holding Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

CREATE TABLE config_info (
  id bigint NOT NULL AUTO_INCREMENT,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  tenant_id varchar(128) default '',
  app_name varchar(128),
  content LONGTEXT,
  md5 varchar(32) DEFAULT NULL,
  gmt_create timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  gmt_modified timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  src_user varchar(128) DEFAULT NULL,
  src_ip varchar(20) DEFAULT NULL,
  c_desc varchar(256) DEFAULT NULL,
  c_use varchar(64) DEFAULT NULL,
  effect varchar(64) DEFAULT NULL,
  type varchar(64) DEFAULT NULL,
  c_schema LONG VARCHAR DEFAULT NULL,
  constraint configinfo_id_key PRIMARY KEY (id),
  constraint uk_configinfo_datagrouptenant UNIQUE (data_id,group_id,tenant_id));

CREATE INDEX configinfo_dataid_key_idx ON config_info(data_id);
CREATE INDEX configinfo_groupid_key_idx ON config_info(group_id);
CREATE INDEX configinfo_dataid_group_key_idx ON config_info(data_id, group_id);

CREATE TABLE his_config_info (
  id bigint NOT NULL,
  nid bigint NOT NULL AUTO_INCREMENT,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  tenant_id varchar(128) default '',
  app_name varchar(128),
  content LONGTEXT,
  md5 varchar(32) DEFAULT NULL,
  gmt_create timestamp NOT NULL DEFAULT '2010-05-05 00:00:00.000',
  gmt_modified timestamp NOT NULL DEFAULT '2010-05-05 00:00:00.000',
  src_user varchar(128),
  src_ip varchar(20) DEFAULT NULL,
  op_type char(10) DEFAULT NULL,
  constraint hisconfiginfo_nid_key PRIMARY KEY (nid));

CREATE INDEX hisconfiginfo_dataid_key_idx ON his_config_info(data_id);
CREATE INDEX hisconfiginfo_gmt_create_idx ON his_config_info(gmt_create);
CREATE INDEX hisconfiginfo_gmt_modified_idx ON his_config_info(gmt_modified);


CREATE TABLE config_info_beta (
  id bigint NOT NULL AUTO_INCREMENT,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  tenant_id varchar(128) default '',
  app_name varchar(128),
  content LONGTEXT,
  beta_ips varchar(1024),
  md5 varchar(32) DEFAULT NULL,
  gmt_create timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  gmt_modified timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  src_user varchar(128),
  src_ip varchar(20) DEFAULT NULL,
  constraint configinfobeta_id_key PRIMARY KEY (id),
  constraint uk_configinfobeta_datagrouptenant UNIQUE (data_id,group_id,tenant_id));

CREATE TABLE config_info_tag (
  id bigint NOT NULL AUTO_INCREMENT,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  tenant_id varchar(128) default '',
  tag_id varchar(128) NOT NULL,
  app_name varchar(128),
  content LONGTEXT,
  md5 varchar(32) DEFAULT NULL,
  gmt_create timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  gmt_modified timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  src_user varchar(128),
  src_ip varchar(20) DEFAULT NULL,
  constraint configinfotag_id_key PRIMARY KEY (id),
  constraint uk_configinfotag_datagrouptenanttag UNIQUE (data_id,group_id,tenant_id,tag_id));

CREATE TABLE config_info_aggr (
  id bigint NOT NULL AUTO_INCREMENT,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  tenant_id varchar(128) default '',
  datum_id varchar(255) NOT NULL,
  app_name varchar(128),
  content LONGTEXT,
  gmt_modified timestamp NOT NULL DEFAULT '2010-05-05 00:00:00',
  constraint configinfoaggr_id_key PRIMARY KEY (id),
  constraint uk_configinfoaggr_datagrouptenantdatum UNIQUE (data_id,group_id,tenant_id,datum_id));

CREATE TABLE app_list (
 id bigint NOT NULL AUTO_INCREMENT,
 app_name varchar(128) NOT NULL,
 is_dynamic_collect_disabled smallint DEFAULT 0,
 last_sub_info_collected_time timestamp DEFAULT '1970-01-01 08:00:00.0',
 sub_info_lock_owner varchar(128),
 sub_info_lock_time timestamp DEFAULT '1970-01-01 08:00:00.0',
 constraint applist_id_key PRIMARY KEY (id),
 constraint uk_appname UNIQUE (app_name));

CREATE TABLE app_configdata_relation_subs (
  id bigint NOT NULL AUTO_INCREMENT,
  app_name varchar(128) NOT NULL,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  gmt_modified timestamp DEFAULT '2010-05-05 00:00:00',
  constraint configdatarelationsubs_id_key PRIMARY KEY (id),
  constraint uk_app_sub_config_datagroup UNIQUE (app_name, data_id, group_id));


CREATE TABLE app_configdata_relation_pubs (
  id bigint NOT NULL AUTO_INCREMENT,
  app_name varchar(128) NOT NULL,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  gmt_modified timestamp DEFAULT '2010-05-05 00:00:00',
  constraint configdatarelationpubs_id_key PRIMARY KEY (id),
  constraint uk_app_pub_config_datagroup UNIQUE (app_name, data_id, group_id));

CREATE TABLE config_tags_relation (
  id bigint NOT NULL,
  tag_name varchar(128) NOT NULL,
  tag_type varchar(64) DEFAULT NULL,
  data_id varchar(255) NOT NULL,
  group_id varchar(128) NOT NULL,
  tenant_id varchar(128) DEFAULT '',
  nid bigint NOT NULL AUTO_INCREMENT,
  constraint config_tags_id_key PRIMARY KEY (nid),
  constraint uk_configtagrelation_configidtag UNIQUE (id, tag_name, tag_type));

CREATE INDEX config_tags_tenant_id_idx ON config_tags_relation(tenant_id);

CREATE TABLE group_capacity (
  id bigint NOT NULL AUTO_INCREMENT,
  group_id varchar(128) DEFAULT '',
  quota int DEFAULT 0,
  `usage` int DEFAULT 0,
  max_size int DEFAULT 0,
  max_aggr_count int DEFAULT 0,
  max_aggr_size int DEFAULT 0,
  max_history_count int DEFAULT 0,
  gmt_create timestamp DEFAULT '2010-05-05 00:00:00',
  gmt_modified timestamp DEFAULT '2010-05-05 00:00:00',
  constraint group_capacity_id_key PRIMARY KEY (id),
  constraint uk_group_id UNIQUE (group_id));

CREATE TABLE tenant_capacity (
  id bigint NOT NULL AUTO_INCREMENT,
  tenant_id varchar(128) DEFAULT '',
  quota int DEFAULT 0,
  `usage` int DEFAULT 0,
  max_size int DEFAULT 0,
  max_aggr_count int DEFAULT 0,
  max_aggr_size int DEFAULT 0,
  max_history_count int DEFAULT 0,
  gmt_create timestamp DEFAULT '2010-05-05 00:00:00',
  gmt_modified timestamp DEFAULT '2010-05-05 00:00:00',
  constraint tenant_capacity_id_key PRIMARY KEY (id),
  constraint uk_tenant_id UNIQUE (tenant_id));

CREATE TABLE tenant_info (
  id bigint NOT NULL AUTO_INCREMENT,
  kp varchar(128) NOT NULL,
  tenant_id varchar(128)  DEFAULT '',
  tenant_name varchar(128)  DEFAULT '',
  tenant_desc varchar(256)  DEFAULT NULL,
  create_source varchar(32) DEFAULT NULL,
  gmt_create bigint NOT NULL,
  gmt_modified bigint NOT NULL,
  constraint tenant_info_id_key PRIMARY KEY (id),
  constraint uk_tenant_info_kptenantid UNIQUE (kp,tenant_id));
CREATE INDEX tenant_info_tenant_id_idx ON tenant_info(tenant_id);

CREATE TABLE users (
	username varchar(50) NOT NULL PRIMARY KEY,
	password varchar(500) NOT NULL,
	enabled boolean NOT NULL DEFAULT true
);

CREATE TABLE roles (
	username varchar(50) NOT NULL,
	role varchar(50) NOT NULL,
	constraint uk_username_role UNIQUE (username,role)
);

CREATE TABLE permissions (
    role varchar(50) NOT NULL,
    resource varchar(512) NOT NULL,
    action varchar(8) NOT NULL,
    constraint uk_role_permission UNIQUE (role,resource,action)
);

INSERT INTO users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');
