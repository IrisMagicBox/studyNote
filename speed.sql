/*
 Navicat MySQL Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : speed

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 15/02/2022 16:30:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tab_asset
-- ----------------------------
DROP TABLE IF EXISTS `tab_asset`;
CREATE TABLE `tab_asset`  (
  `assetId` int(15) NOT NULL AUTO_INCREMENT COMMENT '资产ID',
  `houseId` int(15) NULL DEFAULT NULL COMMENT '房间ID',
  `assetType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资产类型',
  `unitId` int(15) NOT NULL COMMENT '所属单位',
  `assetPrice` float(8, 2) NULL DEFAULT NULL COMMENT '单价',
  `assetAmount` int(3) NULL DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`assetId`) USING BTREE,
  INDEX `houseId`(`houseId` ASC) USING BTREE,
  INDEX `unitId`(`unitId` ASC) USING BTREE,
  CONSTRAINT `tab_asset_ibfk_1` FOREIGN KEY (`houseId`) REFERENCES `tab_house` (`houseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tab_asset_ibfk_2` FOREIGN KEY (`unitId`) REFERENCES `tab_unit` (`unitId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_asset
-- ----------------------------

-- ----------------------------
-- Table structure for tab_assign_house_log
-- ----------------------------
DROP TABLE IF EXISTS `tab_assign_house_log`;
CREATE TABLE `tab_assign_house_log`  (
  `assignId` int(15) NOT NULL COMMENT '主键',
  `userId` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '经办人ID',
  `assignType` bit(1) NULL DEFAULT NULL COMMENT '分配详情：json',
  `houseNames` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分配房间名称s',
  `assignDate` date NULL DEFAULT NULL COMMENT '分配日期',
  `assignArea` float(8, 2) NULL DEFAULT NULL,
  `status` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`assignId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_assign_house_log
-- ----------------------------

-- ----------------------------
-- Table structure for tab_building
-- ----------------------------
DROP TABLE IF EXISTS `tab_building`;
CREATE TABLE `tab_building`  (
  `buildingId` int(15) NOT NULL AUTO_INCREMENT COMMENT '楼宇ID',
  `landId` int(15) NULL DEFAULT NULL COMMENT '所属土地ID',
  `buildingName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '楼宇名称',
  `buildingType` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '楼宇类型',
  `buildingTotalArea` float(8, 2) NULL DEFAULT NULL COMMENT '建筑面积：建筑物各层面积的总和',
  `buildingUseArea` float(8, 2) NULL DEFAULT NULL COMMENT '使用面积',
  `buildingAssetEntry` bit(1) NULL DEFAULT NULL COMMENT '资产入账',
  PRIMARY KEY (`buildingId`) USING BTREE,
  INDEX `tab_building_ibfk_1`(`landId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_building
-- ----------------------------

-- ----------------------------
-- Table structure for tab_campus
-- ----------------------------
DROP TABLE IF EXISTS `tab_campus`;
CREATE TABLE `tab_campus`  (
  `campusId` int(15) NOT NULL AUTO_INCREMENT COMMENT '校区编号',
  `campusName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '校区名称',
  `campusAddress` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校区地址',
  `campusPostcode` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '校区邮编',
  `campusNote` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`campusId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_campus
-- ----------------------------
INSERT INTO `tab_campus` VALUES (1, '燕山大学西校区', '秦皇岛市海港区', '648100', 'test');
INSERT INTO `tab_campus` VALUES (2, '燕山大学东校区', '秦皇岛市海港区', '648100', '主校区');
INSERT INTO `tab_campus` VALUES (3, '华北科技学院北校区', '河北省廊坊市三河市燕郊', '621000', '没什么');

-- ----------------------------
-- Table structure for tab_change_building_log
-- ----------------------------
DROP TABLE IF EXISTS `tab_change_building_log`;
CREATE TABLE `tab_change_building_log`  (
  `id` int(15) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `buildingId` int(15) NOT NULL COMMENT '变动楼宇ID',
  `userId` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '经办人ID',
  `changeContent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '修改内容：存json',
  `changeDate` date NULL DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_change_building_log
-- ----------------------------
INSERT INTO `tab_change_building_log` VALUES (1, 1, '1', '[{oldName:\'chen\',newName:\'li\'},{oldJob:\'guard\',newJob:\'boss\'}]', '2022-01-20');

-- ----------------------------
-- Table structure for tab_change_house_log
-- ----------------------------
DROP TABLE IF EXISTS `tab_change_house_log`;
CREATE TABLE `tab_change_house_log`  (
  `id` int(15) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `houseId` int(15) NOT NULL COMMENT '房间ID',
  `userId` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '经办人ID',
  `changeContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '变更内容',
  `changeDate` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_change_house_log
-- ----------------------------

-- ----------------------------
-- Table structure for tab_house
-- ----------------------------
DROP TABLE IF EXISTS `tab_house`;
CREATE TABLE `tab_house`  (
  `houseId` int(15) NOT NULL AUTO_INCREMENT COMMENT '房间ID',
  `buildingId` int(15) NULL DEFAULT NULL COMMENT '所属楼宇ID',
  `houseFloor` int(3) NULL DEFAULT NULL COMMENT '楼层',
  `houseName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋名称',
  `houseArea` float(6, 2) NULL DEFAULT NULL COMMENT '使用面积',
  `houseNature` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间性质',
  `houseImgAddress` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋图片地址',
  `houseUseStatus` tinyint(2) NULL DEFAULT 0 COMMENT '房间性质',
  `unitId` int(15) NOT NULL COMMENT '使用单位ID',
  `isReport` tinyint(2) NULL DEFAULT 0 COMMENT '是否上报',
  `houseTestScore` int(4) NULL DEFAULT 0 COMMENT '体检分数：作为评测分数来源',
  PRIMARY KEY (`houseId`) USING BTREE,
  INDEX `buildingId`(`buildingId` ASC) USING BTREE,
  INDEX `unitId`(`unitId` ASC) USING BTREE,
  INDEX `houseArea`(`houseArea` ASC) USING BTREE,
  CONSTRAINT `tab_buliding_ibfk` FOREIGN KEY (`buildingId`) REFERENCES `tab_building` (`buildingId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tab_house_ibfk_2` FOREIGN KEY (`unitId`) REFERENCES `tab_unit` (`unitId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_house
-- ----------------------------

-- ----------------------------
-- Table structure for tab_land
-- ----------------------------
DROP TABLE IF EXISTS `tab_land`;
CREATE TABLE `tab_land`  (
  `landId` int(15) NOT NULL AUTO_INCREMENT COMMENT '土地ID/徒弟号',
  `campusId` int(15) NOT NULL COMMENT '所属校区ID',
  `landName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '土地名称',
  `landPurpose` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '土地用途',
  `landUseRightsType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用权类型',
  `landUseDirection` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用方向',
  `landUseStatus` tinyint(2) NOT NULL DEFAULT 0 COMMENT '使用状态',
  `landEntryMethod` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '入账方式',
  PRIMARY KEY (`landId`) USING BTREE,
  INDEX `campusId`(`campusId` ASC) USING BTREE,
  CONSTRAINT `campus_fk` FOREIGN KEY (`campusId`) REFERENCES `tab_campus` (`campusId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_land
-- ----------------------------

-- ----------------------------
-- Table structure for tab_lease_contract_outside_unit
-- ----------------------------
DROP TABLE IF EXISTS `tab_lease_contract_outside_unit`;
CREATE TABLE `tab_lease_contract_outside_unit`  (
  `companyId` int(15) NOT NULL COMMENT '合同单位ID',
  `houseId` int(15) NOT NULL COMMENT '房间ID',
  `companyName` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同单位名称',
  `contractBeginDate` date NULL DEFAULT NULL COMMENT '合同开始时间',
  `contractEndDate` date NULL DEFAULT NULL COMMENT '合同结束时间',
  `partA` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '甲方合同签署人',
  `partB` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '乙方经办人',
  `leaseArea` float(5, 2) NULL DEFAULT NULL COMMENT '租用面积',
  `idCode` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `leaseMonths` int(4) NULL DEFAULT 0 COMMENT '租赁周期（月）',
  `contractTerminateReason` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同终止原因',
  `storeName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '店面名称',
  PRIMARY KEY (`companyId`, `houseId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_lease_contract_outside_unit
-- ----------------------------

-- ----------------------------
-- Table structure for tab_lease_contract_teacher
-- ----------------------------
DROP TABLE IF EXISTS `tab_lease_contract_teacher`;
CREATE TABLE `tab_lease_contract_teacher`  (
  `houseId` int(15) NOT NULL COMMENT '房间ID',
  `userId` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租借人ID',
  `userHousingArea` float(8, 2) NULL DEFAULT NULL COMMENT '可分配用房面积',
  `houseArea` float(8, 2) NULL DEFAULT NULL COMMENT '房屋面积',
  `contractBeginDate` date NULL DEFAULT NULL COMMENT '合同开始时间',
  `contractEndDate` date NULL DEFAULT NULL COMMENT '合同到期时间',
  `contractRent` float(8, 2) NULL DEFAULT NULL COMMENT '租金：根据面积和均价求出',
  PRIMARY KEY (`houseId`, `userId`) USING BTREE,
  INDEX `userHousingArea`(`userHousingArea` ASC) USING BTREE,
  INDEX `houseArea`(`houseArea` ASC) USING BTREE,
  CONSTRAINT `tab_lease_contract_teacher_ibfk_1` FOREIGN KEY (`userHousingArea`) REFERENCES `tab_user` (`userHousingArea`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tab_lease_contract_teacher_ibfk_2` FOREIGN KEY (`houseArea`) REFERENCES `tab_house` (`houseArea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_lease_contract_teacher
-- ----------------------------

-- ----------------------------
-- Table structure for tab_lease_house
-- ----------------------------
DROP TABLE IF EXISTS `tab_lease_house`;
CREATE TABLE `tab_lease_house`  (
  `houseId` int(15) NOT NULL COMMENT '房间ID',
  `buildingId` int(15) NULL DEFAULT NULL COMMENT '所属楼宇',
  `houseFloor` int(3) NULL DEFAULT NULL COMMENT '楼层',
  `houseRent` float(6, 2) NULL DEFAULT NULL,
  `houseImgAddress` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋图片地址',
  `houseUseStatus` tinyint(2) NULL DEFAULT NULL COMMENT '使用状态',
  `isReport` tinyint(2) NULL DEFAULT NULL COMMENT '是否上报',
  PRIMARY KEY (`houseId`) USING BTREE,
  INDEX `buildingId`(`buildingId` ASC) USING BTREE,
  CONSTRAINT `tab_buliding_fk` FOREIGN KEY (`buildingId`) REFERENCES `tab_building` (`buildingId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_lease_house
-- ----------------------------

-- ----------------------------
-- Table structure for tab_outside_unit
-- ----------------------------
DROP TABLE IF EXISTS `tab_outside_unit`;
CREATE TABLE `tab_outside_unit`  (
  `companyId` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '合同单位ID',
  `companyPassword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `unitOfficer` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unitName` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同单位',
  `unitContactsPhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `unitAddress` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位地址',
  PRIMARY KEY (`companyId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_outside_unit
-- ----------------------------

-- ----------------------------
-- Table structure for tab_patrol_detail
-- ----------------------------
DROP TABLE IF EXISTS `tab_patrol_detail`;
CREATE TABLE `tab_patrol_detail`  (
  `id` int(15) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `patrolId` int(15) NOT NULL COMMENT '巡查Id',
  `houseId` int(15) NOT NULL COMMENT '房间Id',
  `houseName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间名称',
  `patrolDate` date NULL DEFAULT NULL COMMENT '巡查日期',
  `patrolResult` int(2) NULL DEFAULT NULL COMMENT '巡查结果',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `patrol_ibfk`(`patrolId` ASC) USING BTREE,
  CONSTRAINT `patrol_ibfk` FOREIGN KEY (`patrolId`) REFERENCES `tab_patrol_plan` (`patrolId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_patrol_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tab_patrol_plan
-- ----------------------------
DROP TABLE IF EXISTS `tab_patrol_plan`;
CREATE TABLE `tab_patrol_plan`  (
  `patrolId` int(15) NOT NULL AUTO_INCREMENT COMMENT '计划ID',
  `userId` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人ID',
  `patrolBeginDate` date NULL DEFAULT NULL COMMENT '开始日期',
  `patrolEndDate` date NULL DEFAULT NULL COMMENT '结束日期',
  `patrolTheme` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '计划主题',
  `patrolPerson` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '巡查人员[{name:\"\",unit:\"\"}.....]',
  `patrolHouseAmount` int(4) NULL DEFAULT NULL COMMENT '巡查房间数',
  `patrolType` bit(1) NULL DEFAULT NULL COMMENT '类型',
  `patrolStatus` tinyint(2) NULL DEFAULT NULL COMMENT '巡查状态',
  PRIMARY KEY (`patrolId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_patrol_plan
-- ----------------------------

-- ----------------------------
-- Table structure for tab_repair
-- ----------------------------
DROP TABLE IF EXISTS `tab_repair`;
CREATE TABLE `tab_repair`  (
  `repairId` int(15) NOT NULL COMMENT '主键',
  `houseId` int(15) NOT NULL COMMENT '维修房间ID',
  `userId` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租借人ID',
  `repairStatus` tinyint(2) NOT NULL COMMENT '状态',
  `repairmanId` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维修人员ID：派单分配后生成',
  PRIMARY KEY (`repairId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_repair
-- ----------------------------

-- ----------------------------
-- Table structure for tab_student
-- ----------------------------
DROP TABLE IF EXISTS `tab_student`;
CREATE TABLE `tab_student`  (
  `studentId` int(18) NOT NULL COMMENT '学号',
  `studentName` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`studentId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_student
-- ----------------------------

-- ----------------------------
-- Table structure for tab_unit
-- ----------------------------
DROP TABLE IF EXISTS `tab_unit`;
CREATE TABLE `tab_unit`  (
  `unitId` int(15) NOT NULL AUTO_INCREMENT COMMENT '单位ID',
  `unitName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位名称',
  PRIMARY KEY (`unitId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_unit
-- ----------------------------

-- ----------------------------
-- Table structure for tab_user
-- ----------------------------
DROP TABLE IF EXISTS `tab_user`;
CREATE TABLE `tab_user`  (
  `userId` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户ID',
  `userPassword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `unitId` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属单位',
  `userRight` int(3) NULL DEFAULT NULL COMMENT '用户权限：系统中用户进行操作的凭证',
  `userDuty` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职务',
  `userHousingArea` float(8, 2) NULL DEFAULT NULL COMMENT '可分配用房面积',
  PRIMARY KEY (`userId`) USING BTREE,
  INDEX `userHousingArea`(`userHousingArea` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab_user
-- ----------------------------
INSERT INTO `tab_user` VALUES ('fsw497108', '888888', '2', 2, '保卫科', 10.00);
INSERT INTO `tab_user` VALUES ('ztz2904536', '123456', '1', 1, '辅导员', 3425.00);

SET FOREIGN_KEY_CHECKS = 1;
