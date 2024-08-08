/*
Navicat MySQL Data Transfer

Source Server         : localhost_9090
Source Server Version : 80012
Source Host           : localhost:3306
Source Database       : credit_management

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2024-08-08 17:03:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'root', '1234');

-- ----------------------------
-- Table structure for `combined_table`
-- ----------------------------
DROP TABLE IF EXISTS `combined_table`;
CREATE TABLE `combined_table` (
  `user_code` bigint(11) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit_recipients` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `operation_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_id` bigint(255) DEFAULT NULL,
  `archive_location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract_id` bigint(20) DEFAULT NULL,
  `handover_time` date DEFAULT NULL,
  `Lending_institution` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_amount` decimal(10,0) DEFAULT NULL,
  `loan_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of combined_table
-- ----------------------------
INSERT INTO `combined_table` VALUES ('684486', '阿道夫', null, '二手房', '531561515', null, '46884861', null, '广东韶关', '6848668', '2024-08-01', '2024-08-31', '[{\"name\":\"用户信息 (1).xlsx\",\"url\":\"http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx\"}]');
INSERT INTO `combined_table` VALUES ('1114728648', '哈哈5', null, '二手房哦', '44951386510', null, '4321668415', null, '曲江', '4118458', '2024-08-06', '2024-08-02', '');
INSERT INTO `combined_table` VALUES ('456', '李四', '法人', '二手房贷款', '8465148651', '位置2', '48651465845', '2024-08-02', null, null, null, null, null);
INSERT INTO `combined_table` VALUES ('123', '张三', '个人', '二手房贷款', '48651486513', '位置1', '486513541', '2024-08-01', null, null, null, null, null);

-- ----------------------------
-- Table structure for `detail`
-- ----------------------------
DROP TABLE IF EXISTS `detail`;
CREATE TABLE `detail` (
  `Lending_institution` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_code` bigint(20) NOT NULL,
  `loan_contract_id` bigint(20) DEFAULT NULL,
  `loan_voucher_id` bigint(20) DEFAULT NULL,
  `business_variety` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_amount` decimal(10,0) DEFAULT NULL,
  `loan_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of detail
-- ----------------------------
INSERT INTO `detail` VALUES ('广东韶关', '阿道夫', '684486', '46884861', '531561515', '二手房', '6848668', '2024-08-01', '2024-08-31', '[{\"name\":\"用户信息 (1).xlsx\",\"url\":\"http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx\"}]');
INSERT INTO `detail` VALUES ('曲江', '哈哈5', '1114728648', '4321668415', '44951386510', '二手房哦', '4118458', '2024-08-06', '2024-08-02', '');

-- ----------------------------
-- Table structure for `management`
-- ----------------------------
DROP TABLE IF EXISTS `management`;
CREATE TABLE `management` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_code` bigint(20) DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit_recipients` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `operation_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `archive_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract_id` bigint(20) DEFAULT NULL,
  `handover_time` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of management
-- ----------------------------
INSERT INTO `management` VALUES ('16', '456', '李四', '法人', '二手房贷款', '8465148651', '位置2', '48651465845', '2024-08-02');
INSERT INTO `management` VALUES ('15', '123', '张三', '个人', '二手房贷款', '48651486513', '位置1', '486513541', '2024-08-01');

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '职位名称',
  `portstype` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '职位类型',
  `salary` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '薪资',
  `degree` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '学历要求',
  `workplace` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '工作城市',
  `ddls` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '截至时间',
  `welfares` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '工作福利',
  `describes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '职位描述',
  `requires` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '任职要求',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '工作地址',
  `companyname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '公司名称',
  `industry` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '公司行业',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '公司类型',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图标',
  `cid` int(11) DEFAULT NULL COMMENT '公司id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('1', '软件工程师', '全职', '7k-9k', ' 本科', '福建福州', '2023-3-10', '五险一金，住房补贴', '这是一份好工作', '本科学历，吃苦耐劳', '福建省福州市台江区1500号', '4399', '软件', '私企', 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg', '1');
INSERT INTO `post` VALUES ('2', '美术设计', '全职', '5k-8k', '本科', '福建厦门', '2023-4-10', '没有福利', '设计作品', '本科学历，艺术专业', '福建省厦门市集美区...', '4399', '设计', '私企', '', '1');
INSERT INTO `post` VALUES ('3', '软件工程师', '全职', '9k-11k', '本科', '福建泉州', '2023-4-8', '包吃包住', '后端开发，使用java', '本科学历，熟练各种框架', '福建省泉州市........', '华为', '软件', '私企', null, '2');
INSERT INTO `post` VALUES ('4', '销售员', '全职', '5K-7K', '大专', '福建福州', '2023-8-9', ' 包吃住，五险一金', '推销产品', '无学历要求，语言表达好', '福建省福州市........', '华为', '软件', '私企', null, '2');
INSERT INTO `post` VALUES ('5', '软件工程师', '全职', '8k-10k', '本科', '福建福州', '2023-6-6', '五险一金', '使用JAVA进行后端编写', '本科学历，会使用Spring等开源框架', '福建省福州市.......', '4399', '软件', '私企', null, '1');
INSERT INTO `post` VALUES ('6', '后端开发工程师', '全职', '9k-13k', '本科', '福建福州', '2023-7-9', '一级国企正编，五险一金', '根据设计图进行后端技术开发和编码实现工作', '本科学历，具备良好的面向对象分析，设计，开发能力思想', '福建省福州市.......', '华为', '软件', '国企', null, '2');

-- ----------------------------
-- Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', 'user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` VALUES ('2', 'house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES ('3', 'menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES ('4', 's-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('5', 's-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` VALUES ('6', 'document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` VALUES ('7', 'coffee', 'el-icon-coffee\r\n', 'icon');
INSERT INTO `sys_dict` VALUES ('8', 's-marketing', 'el-icon-s-marketing', 'icon');
INSERT INTO `sys_dict` VALUES ('9', 'phone-outline', 'el-icon-phone-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('10', 'platform-eleme', 'el-icon-platform-eleme', 'icon');
INSERT INTO `sys_dict` VALUES ('11', 'eleme', 'el-icon-eleme', 'icon');
INSERT INTO `sys_dict` VALUES ('12', 'delete-solid', 'el-icon-delete-solid', 'icon');
INSERT INTO `sys_dict` VALUES ('13', 'delete', 'el-icon-delete', 'icon');
INSERT INTO `sys_dict` VALUES ('14', 's-tools', 'el-icon-s-tools', 'icon');
INSERT INTO `sys_dict` VALUES ('15', 'setting', 'el-icon-setting', 'icon');
INSERT INTO `sys_dict` VALUES ('16', 'user-solid', 'el-icon-user-solid', 'icon');
INSERT INTO `sys_dict` VALUES ('17', 'phone', 'el-icon-phone', 'icon');
INSERT INTO `sys_dict` VALUES ('18', 'more', 'el-icon-more', 'icon');
INSERT INTO `sys_dict` VALUES ('19', 'more-outline', 'el-icon-more-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('20', 'star-on', 'el-icon-star-on', 'icon');
INSERT INTO `sys_dict` VALUES ('21', 'star-off', 'el-icon-star-off', 'icon');
INSERT INTO `sys_dict` VALUES ('22', 's-goods', 'el-icon-s-goods', 'icon');
INSERT INTO `sys_dict` VALUES ('23', 'goods', 'el-icon-goods', 'icon');
INSERT INTO `sys_dict` VALUES ('24', 'warning', 'el-icon-warning', 'icon');
INSERT INTO `sys_dict` VALUES ('25', 'warning-outline', 'el-icon-warning-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('26', 'question', 'el-icon-question', 'icon');
INSERT INTO `sys_dict` VALUES ('27', 'info', 'el-icon-info', 'icon');
INSERT INTO `sys_dict` VALUES ('28', 'remove', 'el-icon-remove', 'icon');
INSERT INTO `sys_dict` VALUES ('29', 'circle-plus', 'el-icon-circle-plus', 'icon');
INSERT INTO `sys_dict` VALUES ('30', 'success', 'el-icon-success', 'icon');
INSERT INTO `sys_dict` VALUES ('31', 'error', 'el-icon-error', 'icon');
INSERT INTO `sys_dict` VALUES ('32', 'zoom-in', 'el-icon-zoom-in', 'icon');
INSERT INTO `sys_dict` VALUES ('33', 'zoom-out', 'el-icon-zoom-out', 'icon');
INSERT INTO `sys_dict` VALUES ('34', 'remove-outline', 'el-icon-remove-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('35', 'circle-plus-outline', 'el-icon-circle-plus-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('36', 'circle-check', 'el-icon-circle-check', 'icon');
INSERT INTO `sys_dict` VALUES ('37', 'circle-close', 'el-icon-circle-close', 'icon');
INSERT INTO `sys_dict` VALUES ('38', 's-help', 'el-icon-s-help', 'icon');
INSERT INTO `sys_dict` VALUES ('39', 'help', 'el-icon-help', 'icon');
INSERT INTO `sys_dict` VALUES ('40', 'minus', 'el-icon-minus', 'icon');
INSERT INTO `sys_dict` VALUES ('41', 'plus', 'el-icon-plus', 'icon');
INSERT INTO `sys_dict` VALUES ('42', 'check', 'el-icon-check', 'icon');
INSERT INTO `sys_dict` VALUES ('43', 'close', 'el-icon-close', 'icon');
INSERT INTO `sys_dict` VALUES ('44', 'picture', 'el-icon-picture', 'icon');
INSERT INTO `sys_dict` VALUES ('45', 'picture-outline', 'el-icon-picture-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('46', 'picture-outline-round', 'el-icon-picture-outline-round', 'icon');
INSERT INTO `sys_dict` VALUES ('47', 'upload', 'el-icon-upload', 'icon');
INSERT INTO `sys_dict` VALUES ('48', 'upload2', 'el-icon-upload2', 'icon');
INSERT INTO `sys_dict` VALUES ('49', 'download', 'el-icon-download', 'icon');
INSERT INTO `sys_dict` VALUES ('50', 'camera-solid', 'el-icon-camera-solid', 'icon');
INSERT INTO `sys_dict` VALUES ('51', 'camera', 'el-icon-camera', 'icon');
INSERT INTO `sys_dict` VALUES ('52', 'video-camera-solid', 'el-icon-video-camera-solid', 'icon');
INSERT INTO `sys_dict` VALUES ('53', 'video-camera', 'el-icon-video-camera', 'icon');
INSERT INTO `sys_dict` VALUES ('54', 'message-solid', 'el-icon-message-solid', 'icon');
INSERT INTO `sys_dict` VALUES ('55', 'bell', 'el-icon-bell', 'icon');
INSERT INTO `sys_dict` VALUES ('56', 's-cooperation', 'el-icon-s-cooperation', 'icon');
INSERT INTO `sys_dict` VALUES ('57', 's-order', 'el-icon-s-order', 'icon');
INSERT INTO `sys_dict` VALUES ('58', 's-platform', 'el-icon-s-platform', 'icon');
INSERT INTO `sys_dict` VALUES ('59', 's-fold', 'el-icon-s-fold', 'icon');
INSERT INTO `sys_dict` VALUES ('60', 's-unfold', 'el-icon-s-unfold', 'icon');
INSERT INTO `sys_dict` VALUES ('61', 's-operation', 'el-icon-s-operation', 'icon');
INSERT INTO `sys_dict` VALUES ('62', 's-promotion', 'el-icon-s-promotion', 'icon');
INSERT INTO `sys_dict` VALUES ('63', 's-home', 'el-icon-s-home', 'icon');
INSERT INTO `sys_dict` VALUES ('64', 's-release', 'el-icon-s-release', 'icon');
INSERT INTO `sys_dict` VALUES ('65', 's-ticket', 'el-icon-s-ticket', 'icon');
INSERT INTO `sys_dict` VALUES ('66', 's-management', 'el-icon-s-management', 'icon');
INSERT INTO `sys_dict` VALUES ('67', 's-open', 'el-icon-s-open', 'icon');
INSERT INTO `sys_dict` VALUES ('68', 's-shop', 'el-icon-s-shop', 'icon');
INSERT INTO `sys_dict` VALUES ('69', 's-flag', 'el-icon-s-flag', 'icon');
INSERT INTO `sys_dict` VALUES ('70', 's-comment', 'el-icon-s-comment', 'icon');
INSERT INTO `sys_dict` VALUES ('71', 's-finance', 'el-icon-s-finance', 'icon');
INSERT INTO `sys_dict` VALUES ('72', 's-claim', 'el-icon-s-claim', 'icon');
INSERT INTO `sys_dict` VALUES ('73', 's-opportunity', 'el-icon-s-opportunity', 'icon');
INSERT INTO `sys_dict` VALUES ('74', 's-data', 'el-icon-s-data', 'icon');
INSERT INTO `sys_dict` VALUES ('75', 's-check', 'el-icon-s-check', 'icon');
INSERT INTO `sys_dict` VALUES ('76', 'share', 'el-icon-share', 'icon');
INSERT INTO `sys_dict` VALUES ('77', 'd-caret', 'el-icon-d-caret', 'icon');
INSERT INTO `sys_dict` VALUES ('78', 'caret-left', 'el-icon-caret-left', 'icon');
INSERT INTO `sys_dict` VALUES ('79', 'caret-right', 'el-icon-caret-right', 'icon');
INSERT INTO `sys_dict` VALUES ('80', 'caret-bottom', 'el-icon-caret-bottom', 'icon');
INSERT INTO `sys_dict` VALUES ('81', 'caret-top', 'el-icon-caret-top', 'icon');
INSERT INTO `sys_dict` VALUES ('82', 'bottom-left', 'el-icon-bottom-left', 'icon');
INSERT INTO `sys_dict` VALUES ('83', 'bottom-right', 'el-icon-bottom-right', 'icon');
INSERT INTO `sys_dict` VALUES ('84', 'back', 'el-icon-back', 'icon');
INSERT INTO `sys_dict` VALUES ('85', 'right', 'el-icon-right', 'icon');
INSERT INTO `sys_dict` VALUES ('86', 'bottom', 'el-icon-bottom', 'icon');
INSERT INTO `sys_dict` VALUES ('87', 'top', 'el-icon-top', 'icon');
INSERT INTO `sys_dict` VALUES ('88', 'top-left', 'el-icon-top-left', 'icon');
INSERT INTO `sys_dict` VALUES ('89', 'top-right', 'el-icon-top-right', 'icon');
INSERT INTO `sys_dict` VALUES ('90', 'arrow-left', 'el-icon-arrow-left', 'icon');
INSERT INTO `sys_dict` VALUES ('91', 'arrow-right', 'el-icon-arrow-right', 'icon');
INSERT INTO `sys_dict` VALUES ('92', 'arrow-down', 'el-icon-arrow-down', 'icon');
INSERT INTO `sys_dict` VALUES ('93', 'arrow-up', 'el-icon-arrow-up', 'icon');
INSERT INTO `sys_dict` VALUES ('94', 'd-arrow-left', 'el-icon-d-arrow-left', 'icon');
INSERT INTO `sys_dict` VALUES ('95', 'd-arrow-right', 'el-icon-d-arrow-right', 'icon');
INSERT INTO `sys_dict` VALUES ('96', 'video-pause', 'el-icon-video-pause', 'icon');
INSERT INTO `sys_dict` VALUES ('97', 'video-play', 'el-icon-video-play', 'icon');
INSERT INTO `sys_dict` VALUES ('98', 'refresh', 'el-icon-refresh', 'icon');
INSERT INTO `sys_dict` VALUES ('99', 'refresh-right', 'el-icon-refresh-right', 'icon');
INSERT INTO `sys_dict` VALUES ('100', 'refresh-left', 'el-icon-refresh-left', 'icon');
INSERT INTO `sys_dict` VALUES ('101', 'finished', 'el-icon-finished', 'icon');
INSERT INTO `sys_dict` VALUES ('102', 'sort', 'el-icon-sort', 'icon');
INSERT INTO `sys_dict` VALUES ('103', 'sort-up', 'el-icon-sort-up', 'icon');
INSERT INTO `sys_dict` VALUES ('104', 'sort-down', 'el-icon-sort-down', 'icon');
INSERT INTO `sys_dict` VALUES ('105', 'rank', 'el-icon-rank', 'icon');
INSERT INTO `sys_dict` VALUES ('106', 'loading', 'el-icon-loading', 'icon');
INSERT INTO `sys_dict` VALUES ('107', 'view', 'el-icon-view', 'icon');
INSERT INTO `sys_dict` VALUES ('108', 'c-scale-to-original', 'el-icon-c-scale-to-original', 'icon');
INSERT INTO `sys_dict` VALUES ('109', 'date', 'el-icon-date', 'icon');
INSERT INTO `sys_dict` VALUES ('110', 'edit', 'el-icon-edit', 'icon');
INSERT INTO `sys_dict` VALUES ('111', 'edit-outline', 'el-icon-edit-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('112', 'folder', 'el-icon-folder', 'icon');
INSERT INTO `sys_dict` VALUES ('113', 'folder-opened', 'el-icon-folder-opened', 'icon');
INSERT INTO `sys_dict` VALUES ('114', 'folder-add', 'el-icon-folder-add', 'icon');
INSERT INTO `sys_dict` VALUES ('115', 'folder-remove', 'el-icon-folder-remove', 'icon');
INSERT INTO `sys_dict` VALUES ('116', 'folder-delete', 'el-icon-folder-delete', 'icon');
INSERT INTO `sys_dict` VALUES ('117', 'folder-checked', 'el-icon-folder-checked', 'icon');
INSERT INTO `sys_dict` VALUES ('118', 'tickets', 'el-icon-tickets', 'icon');
INSERT INTO `sys_dict` VALUES ('119', 'document-remove', 'el-icon-document-remove', 'icon');
INSERT INTO `sys_dict` VALUES ('120', 'document-delete', 'el-icon-document-delete', 'icon');
INSERT INTO `sys_dict` VALUES ('121', 'document-copy', 'el-icon-document-copy', 'icon');
INSERT INTO `sys_dict` VALUES ('122', 'document-checked', 'el-icon-document-checked', 'icon');
INSERT INTO `sys_dict` VALUES ('123', 'document-add', 'el-icon-document-add', 'icon');
INSERT INTO `sys_dict` VALUES ('124', 'printer', 'el-icon-printer', 'icon');
INSERT INTO `sys_dict` VALUES ('125', 'paperclip', 'el-icon-paperclip', 'icon');
INSERT INTO `sys_dict` VALUES ('126', 'takeaway-box', 'el-icon-takeaway-box', 'icon');
INSERT INTO `sys_dict` VALUES ('127', 'search', 'el-icon-search', 'icon');
INSERT INTO `sys_dict` VALUES ('128', 'monitor', 'el-icon-monitor', 'icon');
INSERT INTO `sys_dict` VALUES ('129', 'attract', 'el-icon-attract', 'icon');
INSERT INTO `sys_dict` VALUES ('130', 'mobile', 'el-icon-mobile', 'icon');
INSERT INTO `sys_dict` VALUES ('131', 'scissors', 'el-icon-scissors', 'icon');
INSERT INTO `sys_dict` VALUES ('132', 'umbrella', 'el-icon-umbrella', 'icon');
INSERT INTO `sys_dict` VALUES ('133', 'headset', 'el-icon-headset', 'icon');
INSERT INTO `sys_dict` VALUES ('134', 'brush', 'el-icon-brush', 'icon');
INSERT INTO `sys_dict` VALUES ('135', 'mouse', 'el-icon-mouse', 'icon');
INSERT INTO `sys_dict` VALUES ('136', 'coordinate', 'el-icon-coordinate', 'icon');
INSERT INTO `sys_dict` VALUES ('137', 'magic-stick', 'el-icon-magic-stick', 'icon');
INSERT INTO `sys_dict` VALUES ('138', 'reading', 'el-icon-reading', 'icon');
INSERT INTO `sys_dict` VALUES ('139', 'data-line', 'el-icon-data-line', 'icon');
INSERT INTO `sys_dict` VALUES ('140', 'data-board', 'el-icon-data-board', 'icon');
INSERT INTO `sys_dict` VALUES ('141', 'pie-chart', 'el-icon-pie-chart', 'icon');
INSERT INTO `sys_dict` VALUES ('142', 'data-analysis', 'el-icon-data-analysis', 'icon');
INSERT INTO `sys_dict` VALUES ('143', 'collection-tag', 'el-icon-collection-tag', 'icon');
INSERT INTO `sys_dict` VALUES ('144', 'film', 'el-icon-film', 'icon');
INSERT INTO `sys_dict` VALUES ('145', 'suitcase', 'el-icon-suitcase', 'icon');
INSERT INTO `sys_dict` VALUES ('146', 'suitcase-1', 'el-icon-suitcase-1', 'icon');
INSERT INTO `sys_dict` VALUES ('147', 'receiving', 'el-icon-receiving', 'icon');
INSERT INTO `sys_dict` VALUES ('148', 'collection', 'el-icon-collection', 'icon');
INSERT INTO `sys_dict` VALUES ('149', 'files', 'el-icon-files', 'icon');
INSERT INTO `sys_dict` VALUES ('150', 'notebook-1', 'el-icon-notebook-1', 'icon');
INSERT INTO `sys_dict` VALUES ('151', 'notebook-2', 'el-icon-notebook-2', 'icon');
INSERT INTO `sys_dict` VALUES ('152', 'toilet-paper', 'el-icon-toilet-paper', 'icon');
INSERT INTO `sys_dict` VALUES ('153', 'office-building', 'el-icon-office-building', 'icon');
INSERT INTO `sys_dict` VALUES ('154', 'school', 'el-icon-school', 'icon');
INSERT INTO `sys_dict` VALUES ('155', 'table-lamp', 'el-icon-table-lamp', 'icon');
INSERT INTO `sys_dict` VALUES ('156', 'no-smoking', 'el-icon-no-smoking', 'icon');
INSERT INTO `sys_dict` VALUES ('157', 'smoking', 'el-icon-smoking', 'icon');
INSERT INTO `sys_dict` VALUES ('158', 'shopping-cart-full', 'el-icon-shopping-cart-full', 'icon');
INSERT INTO `sys_dict` VALUES ('159', 'shopping-cart-1', 'el-icon-shopping-cart-1', 'icon');
INSERT INTO `sys_dict` VALUES ('160', 'shopping-cart-2', 'el-icon-shopping-cart-2', 'icon');
INSERT INTO `sys_dict` VALUES ('161', 'shopping-bag-1', 'el-icon-shopping-bag-1', 'icon');
INSERT INTO `sys_dict` VALUES ('162', 'shopping-bag-2', 'el-icon-shopping-bag-2', 'icon');
INSERT INTO `sys_dict` VALUES ('163', 'sold-out', 'el-icon-sold-out', 'icon');
INSERT INTO `sys_dict` VALUES ('164', 'sell', 'el-icon-sell', 'icon');
INSERT INTO `sys_dict` VALUES ('165', 'present', 'el-icon-present', 'icon');
INSERT INTO `sys_dict` VALUES ('166', 'box', 'el-icon-box', 'icon');
INSERT INTO `sys_dict` VALUES ('167', 'bank-card', 'el-icon-bank-card', 'icon');
INSERT INTO `sys_dict` VALUES ('168', 'money', 'el-icon-money', 'icon');
INSERT INTO `sys_dict` VALUES ('169', 'coin', 'el-icon-coin', 'icon');
INSERT INTO `sys_dict` VALUES ('170', 'wallet', 'el-icon-wallet', 'icon');
INSERT INTO `sys_dict` VALUES ('171', 'discount', 'el-icon-discount', 'icon');
INSERT INTO `sys_dict` VALUES ('172', 'price-tag', 'el-icon-price-tag', 'icon');
INSERT INTO `sys_dict` VALUES ('173', 'news', 'el-icon-news', 'icon');
INSERT INTO `sys_dict` VALUES ('174', 'guide', 'el-icon-guide', 'icon');
INSERT INTO `sys_dict` VALUES ('175', 'male', 'el-icon-male', 'icon');
INSERT INTO `sys_dict` VALUES ('176', 'female', 'el-icon-female', 'icon');
INSERT INTO `sys_dict` VALUES ('177', 'thumb', 'el-icon-thumb', 'icon');
INSERT INTO `sys_dict` VALUES ('178', 'cpu', 'el-icon-cpu', 'icon');
INSERT INTO `sys_dict` VALUES ('179', 'link', 'el-icon-link', 'icon');
INSERT INTO `sys_dict` VALUES ('180', 'connection', 'el-icon-connection', 'icon');
INSERT INTO `sys_dict` VALUES ('181', 'open', 'el-icon-open', 'icon');
INSERT INTO `sys_dict` VALUES ('182', 'turn-off', 'el-icon-turn-off', 'icon');
INSERT INTO `sys_dict` VALUES ('183', 'set-up', 'el-icon-set-up', 'icon');
INSERT INTO `sys_dict` VALUES ('184', 'chat-round', 'el-icon-chat-round', 'icon');
INSERT INTO `sys_dict` VALUES ('185', 'chat-line-round', 'el-icon-chat-line-round', 'icon');
INSERT INTO `sys_dict` VALUES ('186', 'chat-square', 'el-icon-chat-square', 'icon');
INSERT INTO `sys_dict` VALUES ('187', 'chat-dot-round', 'el-icon-chat-dot-round', 'icon');
INSERT INTO `sys_dict` VALUES ('188', 'chat-dot-square', 'el-icon-chat-dot-square', 'icon');
INSERT INTO `sys_dict` VALUES ('189', 'chat-line-square', 'el-icon-chat-line-square', 'icon');
INSERT INTO `sys_dict` VALUES ('190', 'message', 'el-icon-message', 'icon');
INSERT INTO `sys_dict` VALUES ('191', 'postcard', 'el-icon-postcard', 'icon');
INSERT INTO `sys_dict` VALUES ('192', 'position', 'el-icon-position', 'icon');
INSERT INTO `sys_dict` VALUES ('193', 'turn-off-microphone', 'el-icon-turn-off-microphone', 'icon');
INSERT INTO `sys_dict` VALUES ('194', 'microphone', 'el-icon-microphone', 'icon');
INSERT INTO `sys_dict` VALUES ('195', 'close-notification', 'el-icon-close-notification', 'icon');
INSERT INTO `sys_dict` VALUES ('196', 'bangzhu', 'el-icon-bangzhu', 'icon');
INSERT INTO `sys_dict` VALUES ('197', 'time', 'el-icon-time', 'icon');
INSERT INTO `sys_dict` VALUES ('198', 'odometer', 'el-icon-odometer', 'icon');
INSERT INTO `sys_dict` VALUES ('199', 'crop', 'el-icon-crop', 'icon');
INSERT INTO `sys_dict` VALUES ('200', 'aim', 'el-icon-aim', 'icon');
INSERT INTO `sys_dict` VALUES ('201', 'switch-button', 'el-icon-switch-button', 'icon');
INSERT INTO `sys_dict` VALUES ('202', 'full-screen', 'el-icon-full-screen', 'icon');
INSERT INTO `sys_dict` VALUES ('203', 'copy-document', 'el-icon-copy-document', 'icon');
INSERT INTO `sys_dict` VALUES ('204', 'mic', 'el-icon-mic', 'icon');
INSERT INTO `sys_dict` VALUES ('205', 'stopwatch', 'el-icon-stopwatch', 'icon');
INSERT INTO `sys_dict` VALUES ('206', 'medal-1', 'el-icon-medal-1', 'icon');
INSERT INTO `sys_dict` VALUES ('207', 'medal', 'el-icon-medal', 'icon');
INSERT INTO `sys_dict` VALUES ('208', 'trophy', 'el-icon-trophy', 'icon');
INSERT INTO `sys_dict` VALUES ('209', 'trophy-1', 'el-icon-trophy-1', 'icon');
INSERT INTO `sys_dict` VALUES ('210', 'first-aid-kit', 'el-icon-first-aid-kit', 'icon');
INSERT INTO `sys_dict` VALUES ('211', 'discover', 'el-icon-discover', 'icon');
INSERT INTO `sys_dict` VALUES ('212', 'place', 'el-icon-place', 'icon');
INSERT INTO `sys_dict` VALUES ('213', 'location', 'el-icon-location', 'icon');
INSERT INTO `sys_dict` VALUES ('214', 'location-outline', 'el-icon-location-outline', 'icon');
INSERT INTO `sys_dict` VALUES ('215', 'location-information', 'el-icon-location-information', 'icon');
INSERT INTO `sys_dict` VALUES ('216', 'add-location', 'el-icon-add-location', 'icon');
INSERT INTO `sys_dict` VALUES ('217', 'delete-location', 'el-icon-delete-location', 'icon');
INSERT INTO `sys_dict` VALUES ('218', 'map-location', 'el-icon-map-location', 'icon');
INSERT INTO `sys_dict` VALUES ('219', 'alarm-clock', 'el-icon-alarm-clock', 'icon');
INSERT INTO `sys_dict` VALUES ('220', 'timer', 'el-icon-timer', 'icon');
INSERT INTO `sys_dict` VALUES ('221', 'watch-1', 'el-icon-watch-1', 'icon');
INSERT INTO `sys_dict` VALUES ('222', 'watch', 'el-icon-watch', 'icon');
INSERT INTO `sys_dict` VALUES ('223', 'lock', 'el-icon-lock', 'icon');
INSERT INTO `sys_dict` VALUES ('224', 'unlock', 'el-icon-unlock', 'icon');
INSERT INTO `sys_dict` VALUES ('225', 'key', 'el-icon-key', 'icon');
INSERT INTO `sys_dict` VALUES ('226', 'service', 'el-icon-service', 'icon');
INSERT INTO `sys_dict` VALUES ('227', 'mobile-phone', 'el-icon-mobile-phone', 'icon');
INSERT INTO `sys_dict` VALUES ('228', 'bicycle', 'el-icon-bicycle', 'icon');
INSERT INTO `sys_dict` VALUES ('229', 'truck', 'el-icon-truck', 'icon');
INSERT INTO `sys_dict` VALUES ('230', 'ship', 'el-icon-ship', 'icon');
INSERT INTO `sys_dict` VALUES ('231', 'basketball', 'el-icon-basketball', 'icon');
INSERT INTO `sys_dict` VALUES ('232', 'football', 'el-icon-football', 'icon');
INSERT INTO `sys_dict` VALUES ('233', 'soccer', 'el-icon-soccer', 'icon');
INSERT INTO `sys_dict` VALUES ('234', 'baseball', 'el-icon-baseball', 'icon');
INSERT INTO `sys_dict` VALUES ('235', 'wind-power', 'el-icon-wind-power', 'icon');
INSERT INTO `sys_dict` VALUES ('236', 'light-rain', 'el-icon-light-rain', 'icon');
INSERT INTO `sys_dict` VALUES ('237', 'lightning', 'el-icon-lightning', 'icon');
INSERT INTO `sys_dict` VALUES ('238', 'heavy-rain', 'el-icon-heavy-rain', 'icon');
INSERT INTO `sys_dict` VALUES ('239', 'sunrise', 'el-icon-sunrise', 'icon');
INSERT INTO `sys_dict` VALUES ('240', 'sunrise-1', 'el-icon-sunrise-1', 'icon');
INSERT INTO `sys_dict` VALUES ('241', 'sunset', 'el-icon-sunset', 'icon');
INSERT INTO `sys_dict` VALUES ('242', 'sunny', 'el-icon-sunny', 'icon');
INSERT INTO `sys_dict` VALUES ('243', 'cloudy', 'el-icon-cloudy', 'icon');
INSERT INTO `sys_dict` VALUES ('244', 'partly-cloudy', 'el-icon-partly-cloudy', 'icon');
INSERT INTO `sys_dict` VALUES ('245', 'cloudy-and-sunny', 'el-icon-cloudy-and-sunny', 'icon');
INSERT INTO `sys_dict` VALUES ('246', 'moon', 'el-icon-moon', 'icon');
INSERT INTO `sys_dict` VALUES ('247', 'moon-night', 'el-icon-moon-night', 'icon');
INSERT INTO `sys_dict` VALUES ('248', 'dish', 'el-icon-dish', 'icon');
INSERT INTO `sys_dict` VALUES ('249', 'dish-1', 'el-icon-dish-1', 'icon');
INSERT INTO `sys_dict` VALUES ('250', 'food', 'el-icon-food', 'icon');
INSERT INTO `sys_dict` VALUES ('251', 'chicken', 'el-icon-chicken', 'icon');
INSERT INTO `sys_dict` VALUES ('252', 'fork-spoon', 'el-icon-fork-spoon', 'icon');
INSERT INTO `sys_dict` VALUES ('253', 'knife-fork', 'el-icon-knife-fork', 'icon');
INSERT INTO `sys_dict` VALUES ('254', 'burger', 'el-icon-burger', 'icon');
INSERT INTO `sys_dict` VALUES ('255', 'tableware', 'el-icon-tableware', 'icon');
INSERT INTO `sys_dict` VALUES ('256', 'sugar', 'el-icon-sugar', 'icon');
INSERT INTO `sys_dict` VALUES ('257', 'dessert', 'el-icon-dessert', 'icon');
INSERT INTO `sys_dict` VALUES ('258', 'ice-cream', 'el-icon-ice-cream', 'icon');
INSERT INTO `sys_dict` VALUES ('259', 'hot-water', 'el-icon-hot-water', 'icon');
INSERT INTO `sys_dict` VALUES ('260', 'water-cup', 'el-icon-water-cup', 'icon');
INSERT INTO `sys_dict` VALUES ('261', 'coffee-cup', 'el-icon-coffee-cup', 'icon');
INSERT INTO `sys_dict` VALUES ('262', 'cold-drink', 'el-icon-cold-drink', 'icon');
INSERT INTO `sys_dict` VALUES ('263', 'goblet', 'el-icon-goblet', 'icon');
INSERT INTO `sys_dict` VALUES ('264', 'goblet-full', 'el-icon-goblet-full', 'icon');
INSERT INTO `sys_dict` VALUES ('265', 'goblet-square', 'el-icon-goblet-square', 'icon');
INSERT INTO `sys_dict` VALUES ('266', 'goblet-square-full', 'el-icon-goblet-square-full', 'icon');
INSERT INTO `sys_dict` VALUES ('267', 'refrigerator', 'el-icon-refrigerator', 'icon');
INSERT INTO `sys_dict` VALUES ('268', 'grape', 'el-icon-grape', 'icon');
INSERT INTO `sys_dict` VALUES ('269', 'watermelon', 'el-icon-watermelon', 'icon');
INSERT INTO `sys_dict` VALUES ('270', 'cherry', 'el-icon-cherry', 'icon');
INSERT INTO `sys_dict` VALUES ('271', 'apple', 'el-icon-apple', 'icon');
INSERT INTO `sys_dict` VALUES ('272', 'pear', 'el-icon-pear', 'icon');
INSERT INTO `sys_dict` VALUES ('273', 'orange', 'el-icon-orange', 'icon');
INSERT INTO `sys_dict` VALUES ('274', 'ice-tea', 'el-icon-ice-tea', 'icon');
INSERT INTO `sys_dict` VALUES ('275', 'ice-drink', 'el-icon-ice-drink', 'icon');
INSERT INTO `sys_dict` VALUES ('276', 'milk-tea', 'el-icon-milk-tea', 'icon');
INSERT INTO `sys_dict` VALUES ('277', 'potato-strips', 'el-icon-potato-strips', 'icon');
INSERT INTO `sys_dict` VALUES ('278', 'lollipop', 'el-icon-lollipop', 'icon');
INSERT INTO `sys_dict` VALUES ('279', 'ice-cream-square', 'el-icon-ice-cream-square', 'icon');
INSERT INTO `sys_dict` VALUES ('280', 'ice-cream-round', 'el-icon-ice-cream-round', 'icon');

-- ----------------------------
-- Table structure for `sys_file`
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) DEFAULT NULL COMMENT '文件大小(kb)',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件md5',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否禁用链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES ('1', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('2', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('3', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('8', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('9', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('10', '1.jpg', 'jpg', '24', 'http://localhost:9090/file/522d19496a214a34aae8e56e9ed84509.jpg', 'd3aea2b12293d2a7783ebffe0dfdbb58', '0', '1');
INSERT INTO `sys_file` VALUES ('11', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('12', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('52', '微信图片_20240807152717.png', 'png', '4', 'http://localhost:9090/file/b94434cd8b524b8b81f7e4fc07e3ce7d.png', '0f8a5cedae9dd4d10efd32d454e22512', '0', '1');
INSERT INTO `sys_file` VALUES ('53', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('54', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('55', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('56', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('57', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('58', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('59', '1.jpg', 'jpg', '24', 'http://localhost:9090/file/522d19496a214a34aae8e56e9ed84509.jpg', 'd3aea2b12293d2a7783ebffe0dfdbb58', '0', '1');
INSERT INTO `sys_file` VALUES ('60', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('61', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('62', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('63', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('64', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('65', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('66', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('67', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('68', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('69', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('70', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('71', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('72', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('73', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('74', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('75', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('76', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('77', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('78', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('79', '微信图片_20240511094253.jpg', 'jpg', '136', 'http://localhost:9090/file/904b9d6661634472860a49d5252f48e3.jpg', '56cbf7b188ea907b6dd4cd8e6be2e280', '0', '1');
INSERT INTO `sys_file` VALUES ('80', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('81', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('82', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('83', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('84', '微信图片_20240807152709.png', 'png', '27', 'http://localhost:9090/file/b34226663ca945ad95a2967d6cae10c1.png', 'f83bdfe5da2b9950377712ad469a59d0', '0', '1');
INSERT INTO `sys_file` VALUES ('85', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('86', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('87', '1.jpg', 'jpg', '24', 'http://localhost:9090/file/522d19496a214a34aae8e56e9ed84509.jpg', 'd3aea2b12293d2a7783ebffe0dfdbb58', '0', '1');
INSERT INTO `sys_file` VALUES ('88', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('89', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('90', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('91', '微信图片_20240511094253.jpg', 'jpg', '136', 'http://localhost:9090/file/904b9d6661634472860a49d5252f48e3.jpg', '56cbf7b188ea907b6dd4cd8e6be2e280', '0', '1');
INSERT INTO `sys_file` VALUES ('92', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('93', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('94', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('95', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('96', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('97', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('98', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('99', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('100', '图片1.png', 'png', '30', 'http://localhost:9090/file/9dace4657ad14273a57362f2b85fe75a.png', 'd7ea73e4b40ead940cf48112be34ba6f', '0', '1');
INSERT INTO `sys_file` VALUES ('101', '微信图片_20240511094253.jpg', 'jpg', '136', 'http://localhost:9090/file/904b9d6661634472860a49d5252f48e3.jpg', '56cbf7b188ea907b6dd4cd8e6be2e280', '0', '1');
INSERT INTO `sys_file` VALUES ('102', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('103', '微信图片_20240807152717.png', 'png', '4', 'http://localhost:9090/file/b94434cd8b524b8b81f7e4fc07e3ce7d.png', '0f8a5cedae9dd4d10efd32d454e22512', '0', '1');
INSERT INTO `sys_file` VALUES ('104', '微信图片_20240410102451.jpg', 'jpg', '159', 'http://localhost:9090/file/054fc0d356394a97acf36a2bffcbca53.jpg', 'ac079942ce9ef567665c3cbc118602ff', '0', '1');
INSERT INTO `sys_file` VALUES ('105', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('106', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('107', '微信图片_20240511094258.jpg', 'jpg', '205', 'http://localhost:9090/file/975bac331d004a9198376bc759d02180.jpg', '0289f4424daf89a9bd960075f0ffdb76', '0', '1');
INSERT INTO `sys_file` VALUES ('108', '图片1.png', 'png', '30', 'http://localhost:9090/file/9dace4657ad14273a57362f2b85fe75a.png', 'd7ea73e4b40ead940cf48112be34ba6f', '0', '1');
INSERT INTO `sys_file` VALUES ('109', '图片1.png', 'png', '30', 'http://localhost:9090/file/9dace4657ad14273a57362f2b85fe75a.png', 'd7ea73e4b40ead940cf48112be34ba6f', '0', '1');
INSERT INTO `sys_file` VALUES ('110', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('111', '图片1.png', 'png', '30', 'http://localhost:9090/file/9dace4657ad14273a57362f2b85fe75a.png', 'd7ea73e4b40ead940cf48112be34ba6f', '0', '1');
INSERT INTO `sys_file` VALUES ('112', '微信图片_20240410102451.jpg', 'jpg', '159', 'http://localhost:9090/file/054fc0d356394a97acf36a2bffcbca53.jpg', 'ac079942ce9ef567665c3cbc118602ff', '0', '1');
INSERT INTO `sys_file` VALUES ('113', '未命名图片.png', 'png', '673', 'http://localhost:9090/file/8b5546f3a5f0402eb7026b6c57991396.png', '4b7c78b52f0f8d7cf8a5b5a8932d1864', '0', '1');
INSERT INTO `sys_file` VALUES ('114', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('115', '1.jpg', 'jpg', '24', 'http://localhost:9090/file/522d19496a214a34aae8e56e9ed84509.jpg', 'd3aea2b12293d2a7783ebffe0dfdbb58', '0', '1');
INSERT INTO `sys_file` VALUES ('116', '2.png', 'png', '524', 'http://localhost:9090/file/5888f5164b47432bbd5d4e00b2df57fa.png', '116b057600e4940c57ef379cd6bf86e8', '0', '1');
INSERT INTO `sys_file` VALUES ('117', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('118', '微信图片_20240410102451.jpg', 'jpg', '159', 'http://localhost:9090/file/054fc0d356394a97acf36a2bffcbca53.jpg', 'ac079942ce9ef567665c3cbc118602ff', '0', '1');
INSERT INTO `sys_file` VALUES ('119', '微信图片_20220919182243.jpg', 'jpg', '389', 'http://localhost:9090/file/1c0c482907f44402bad367b49e872b53.jpg', '9358c69be2504a2725e6649ab61eebb1', '0', '1');
INSERT INTO `sys_file` VALUES ('120', '微信图片_20240511094237.jpg', 'jpg', '460', 'http://localhost:9090/file/85b81916b1c54d86b82a485df6d511b8.jpg', '2f0863f769ed0569a20f9ba7cd79ff0a', '0', '1');
INSERT INTO `sys_file` VALUES ('121', '微信图片_20240511094253.jpg', 'jpg', '136', 'http://localhost:9090/file/904b9d6661634472860a49d5252f48e3.jpg', '56cbf7b188ea907b6dd4cd8e6be2e280', '0', '1');
INSERT INTO `sys_file` VALUES ('122', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('123', '1.png', 'png', '72', 'http://localhost:9090/file/3d8ef08fc49a4fec80bf65342fa465b5.png', '5c051b9f4a448a5580b38d1128fd52fb', '0', '1');
INSERT INTO `sys_file` VALUES ('124', '用户信息 (1).xlsx', 'xlsx', '9', 'http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx', 'cdb1ba07913de01dc9db5f4aeb5eda21', '0', '1');
INSERT INTO `sys_file` VALUES ('125', '档案入库信息表 (2).xlsx', 'xlsx', '10', 'http://localhost:9090/file/4fc0dab87f1e4218beda83a03cb875e9.xlsx', 'f7807b1c28189137a1d25e0aeb897e76', '0', '1');
INSERT INTO `sys_file` VALUES ('126', '微信头像.jpg', 'jpg', '64', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', '60812d34ec1a93593f9ca0525c194014', '0', '1');
INSERT INTO `sys_file` VALUES ('127', '档案入库信息表 (7).xlsx', 'xlsx', '10', 'http://localhost:9090/file/4a32098a1df147f59c1c44419f9c04d9.xlsx', '4b9e77d0bc116ca4046a5a401f956b8b', '0', '1');
INSERT INTO `sys_file` VALUES ('128', '档案入库信息表.xlsx', 'xlsx', '3', 'http://localhost:9090/file/2cd822a25f6144d3a336066403bfbc0f.xlsx', '5b4c74596605fddd23579d8bede91be6', '0', '1');
INSERT INTO `sys_file` VALUES ('129', 'car.png', 'png', '378', 'http://localhost:9090/file/728884f5139b41cbadc0770295784cbd.png', '8367bf833b2e214bb1d63aef89a691ec', '0', '1');
INSERT INTO `sys_file` VALUES ('130', '档案入库信息表 (7).xlsx', 'xlsx', '9', 'http://localhost:9090/file/335ca45904c843c7ae7c96bc022b7a99.xlsx', '8c09ad31cf9a62a3bbab67ca24442e7a', '0', '1');
INSERT INTO `sys_file` VALUES ('131', '档案入库信息表 (7).xlsx', 'xlsx', '9', 'http://localhost:9090/file/335ca45904c843c7ae7c96bc022b7a99.xlsx', '8c09ad31cf9a62a3bbab67ca24442e7a', '0', '1');
INSERT INTO `sys_file` VALUES ('132', '用户信息 (1).xlsx', 'xlsx', '9', 'http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx', 'cdb1ba07913de01dc9db5f4aeb5eda21', '0', '1');
INSERT INTO `sys_file` VALUES ('133', '用户信息 (1).xlsx', 'xlsx', '9', 'http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx', 'cdb1ba07913de01dc9db5f4aeb5eda21', '0', '1');
INSERT INTO `sys_file` VALUES ('134', '邱恝男 web前端工程师.pdf', 'pdf', '1472', 'http://localhost:9090/file/72bff646c7a54610991d223daa4b6abb.pdf', '7049ad326f6828e69e0537a16b40ecde', '0', '1');
INSERT INTO `sys_file` VALUES ('135', '用户信息 (1).xlsx', 'xlsx', '9', 'http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx', 'cdb1ba07913de01dc9db5f4aeb5eda21', '0', '1');
INSERT INTO `sys_file` VALUES ('136', '邱恝男 web前端工程师.pdf', 'pdf', '1472', 'http://localhost:9090/file/72bff646c7a54610991d223daa4b6abb.pdf', '7049ad326f6828e69e0537a16b40ecde', '0', '1');
INSERT INTO `sys_file` VALUES ('137', '用户信息 (1).xlsx', 'xlsx', '9', 'http://localhost:9090/file/24a591d693e743669ea4231e3d3f22aa.xlsx', 'cdb1ba07913de01dc9db5f4aeb5eda21', '0', '1');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '路径',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `pid` int(11) DEFAULT NULL COMMENT '父级id',
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页面路径',
  `sort_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('4', '系统管理', null, 'el-icon-s-grid', null, null, null, '300');
INSERT INTO `sys_menu` VALUES ('5', '用户管理', '/user', 'el-icon-user', null, '4', 'User', '301');
INSERT INTO `sys_menu` VALUES ('6', '角色管理', '/role', 'el-icon-s-custom', null, '4', 'Role', '302');
INSERT INTO `sys_menu` VALUES ('10', '主页', '/home', 'el-icon-user', null, null, 'Home', '0');
INSERT INTO `sys_menu` VALUES ('14', '档案入库', '/detail', 'el-icon-menu', null, null, 'Detail', '999');
INSERT INTO `sys_menu` VALUES ('15', '档案管理', '/management', 'el-icon-menu', null, null, 'Management', '999');
INSERT INTO `sys_menu` VALUES ('16', '未交档案', '/unpaid', 'el-icon-menu', null, null, 'Unpaid', '999');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理员', '对辖内系统用户和权限进行管理和设置', 'role_admin');
INSERT INTO `sys_role` VALUES ('2', '档案人员', '查询和下载报表功能', 'role_archives');
INSERT INTO `sys_role` VALUES ('3', '综合管理', '查看报表功能', 'role_synthesis');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='角色菜单关系表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('1', '5');
INSERT INTO `sys_role_menu` VALUES ('1', '6');
INSERT INTO `sys_role_menu` VALUES ('1', '10');
INSERT INTO `sys_role_menu` VALUES ('1', '14');
INSERT INTO `sys_role_menu` VALUES ('1', '15');
INSERT INTO `sys_role_menu` VALUES ('1', '16');
INSERT INTO `sys_role_menu` VALUES ('2', '10');
INSERT INTO `sys_role_menu` VALUES ('2', '14');
INSERT INTO `sys_role_menu` VALUES ('2', '15');
INSERT INTO `sys_role_menu` VALUES ('2', '16');
INSERT INTO `sys_role_menu` VALUES ('3', '10');
INSERT INTO `sys_role_menu` VALUES ('3', '14');
INSERT INTO `sys_role_menu` VALUES ('3', '15');
INSERT INTO `sys_role_menu` VALUES ('3', '16');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'admin', 'admin', 'admin@qq.com', '13988997788', '广东韶关1', '2023-07-09 21:10:27', 'http://localhost:9090/file/86f9fcc65f0b4733b5135d38875d7e97.jpg', 'role_admin');
INSERT INTO `sys_user` VALUES ('2', 'zhang', '123', '张张', 'zhang@qq.com', '13677889900', '南京', '2023-07-09 22:10:14', 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png', 'role_archives');
INSERT INTO `sys_user` VALUES ('9', 'wang', '12345', '王五1', 'wang@qq.com', '18922334455', '广东', '2024-07-31 08:52:22', null, 'role_archives');
INSERT INTO `sys_user` VALUES ('17', '1234567', '1234567', '1234567', null, null, null, '2024-08-08 16:21:05', null, 'role_synthesis');
