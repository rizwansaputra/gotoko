/*
 Navicat Premium Data Transfer

 Source Server         : Wamp
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : toko

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 28/11/2023 23:09:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `balance` double NOT NULL,
  `account_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_in` double NULL DEFAULT NULL,
  `total_out` double NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES (1, 'Cash', 'Default account', 3000, '1', 3000, 0, '2021-11-28 12:06:59', '2023-11-28 21:24:08', NULL);
INSERT INTO `accounts` VALUES (2, 'Payable', 'td', 0, '2', 0, 0, '2021-11-28 12:07:21', '2021-12-01 12:02:22', NULL);
INSERT INTO `accounts` VALUES (3, 'Receivable', 'Default account', 0, '3', 0, 0, '2021-11-28 12:07:36', '2021-12-01 15:11:58', NULL);

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `f_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `l_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (1, 'mas', 'wend', 'admin@mwend.com', '628991585001', '$2y$10$ZgiJjvBpK/nE/CG7W//a3.UktMYHjVlc9ypJwXXe5UczuPB96d4DO', NULL, '2023-11-28 16:33:46', '2023-11-28 16:33:46', NULL, NULL);

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (3, 'Test Brand', '2023-10-25-65389205947d0.png', '2023-10-25 10:56:53', '2023-10-25 10:56:53', NULL);

-- ----------------------------
-- Table structure for business_settings
-- ----------------------------
DROP TABLE IF EXISTS `business_settings`;
CREATE TABLE `business_settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of business_settings
-- ----------------------------
INSERT INTO `business_settings` VALUES (1, 'shop_logo', '2021-11-10-618b99fd673d2.png', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (2, 'pagination_limit', '12', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (3, 'currency', 'IDR', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (4, 'shop_name', 'GoToko', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (5, 'shop_address', 'Ujungaris - Widasari - Indramayu', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (6, 'shop_phone', '0123456789', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (7, 'shop_email', 'shop@gmail.com', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (8, 'footer_text', 'Foooter text', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (9, 'country', 'ID', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (10, 'stock_limit', '10', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (11, 'time_zone', 'Asia/Jakarta', NULL, NULL, NULL);
INSERT INTO `business_settings` VALUES (12, 'vat_reg_no', '0000', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int NOT NULL,
  `position` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Test Category', 0, 0, 1, '2023-10-25-653891d1a698a.png', '2023-10-25 10:56:01', '2023-10-25 10:56:01', NULL);
INSERT INTO `categories` VALUES (2, 'Test Sub Category', 1, 1, 1, 'def.png', '2023-10-25 10:56:25', '2023-10-25 10:56:25', NULL);

-- ----------------------------
-- Table structure for companies
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_domain_prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of companies
-- ----------------------------

-- ----------------------------
-- Table structure for coupons
-- ----------------------------
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `coupon_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `user_limit` int NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `min_purchase` decimal(8, 2) NOT NULL DEFAULT 0.00,
  `max_discount` decimal(8, 2) NOT NULL DEFAULT 0.00,
  `discount` decimal(8, 2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupons
-- ----------------------------

-- ----------------------------
-- Table structure for currencies
-- ----------------------------
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `exchange_rate` decimal(8, 2) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currencies
-- ----------------------------
INSERT INTO `currencies` VALUES (1, 'US Dollar', 'USD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (2, 'Canadian Dollar', 'CAD', 'CA$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (3, 'Euro', 'EUR', '€', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (4, 'United Arab Emirates Dirham', 'AED', 'د.إ.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (5, 'Afghan Afghani', 'AFN', '؋', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (6, 'Albanian Lek', 'ALL', 'L', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (7, 'Armenian Dram', 'AMD', '֏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (8, 'Argentine Peso', 'ARS', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (9, 'Australian Dollar', 'AUD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (10, 'Azerbaijani Manat', 'AZN', '₼', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (11, 'Bosnia-Herzegovina Convertible Mark', 'BAM', 'KM', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (12, 'Bangladeshi Taka', 'BDT', '৳', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (13, 'Bulgarian Lev', 'BGN', 'лв.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (14, 'Bahraini Dinar', 'BHD', 'د.ب.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (15, 'Burundian Franc', 'BIF', 'FBu', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (16, 'Brunei Dollar', 'BND', 'B$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (17, 'Bolivian Boliviano', 'BOB', 'Bs', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (18, 'Brazilian Real', 'BRL', 'R$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (19, 'Botswanan Pula', 'BWP', 'P', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (20, 'Belarusian Ruble', 'BYN', 'Br', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (21, 'Belize Dollar', 'BZD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (22, 'Congolese Franc', 'CDF', 'FC', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (23, 'Swiss Franc', 'CHF', 'CHf', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (24, 'Chilean Peso', 'CLP', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (25, 'Chinese Yuan', 'CNY', '¥', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (26, 'Colombian Peso', 'COP', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (27, 'Costa Rican Colón', 'CRC', '₡', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (28, 'Cape Verdean Escudo', 'CVE', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (29, 'Czech Republic Koruna', 'CZK', 'Kč', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (30, 'Djiboutian Franc', 'DJF', 'Fdj', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (31, 'Danish Krone', 'DKK', 'Kr.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (32, 'Dominican Peso', 'DOP', 'RD$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (33, 'Algerian Dinar', 'DZD', 'د.ج.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (34, 'Estonian Kroon', 'EEK', 'kr', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (35, 'Egyptian Pound', 'EGP', 'E£‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (36, 'Eritrean Nakfa', 'ERN', 'Nfk', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (37, 'Ethiopian Birr', 'ETB', 'Br', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (38, 'British Pound Sterling', 'GBP', '£', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (39, 'Georgian Lari', 'GEL', 'GEL', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (40, 'Ghanaian Cedi', 'GHS', 'GH¢', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (41, 'Guinean Franc', 'GNF', 'FG', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (42, 'Guatemalan Quetzal', 'GTQ', 'Q', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (43, 'Hong Kong Dollar', 'HKD', 'HK$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (44, 'Honduran Lempira', 'HNL', 'L', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (45, 'Croatian Kuna', 'HRK', 'kn', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (46, 'Hungarian Forint', 'HUF', 'Ft', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (47, 'Indonesian Rupiah', 'IDR', 'Rp', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (48, 'Israeli New Sheqel', 'ILS', '₪', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (49, 'Indian Rupee', 'INR', '₹', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (50, 'Iraqi Dinar', 'IQD', 'ع.د', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (51, 'Iranian Rial', 'IRR', '﷼', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (52, 'Icelandic Króna', 'ISK', 'kr', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (53, 'Jamaican Dollar', 'JMD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (54, 'Jordanian Dinar', 'JOD', 'د.ا‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (55, 'Japanese Yen', 'JPY', '¥', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (56, 'Kenyan Shilling', 'KES', 'Ksh', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (57, 'Cambodian Riel', 'KHR', '៛', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (58, 'Comorian Franc', 'KMF', 'FC', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (59, 'South Korean Won', 'KRW', 'CF', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (60, 'Kuwaiti Dinar', 'KWD', 'د.ك.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (61, 'Kazakhstani Tenge', 'KZT', '₸.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (62, 'Lebanese Pound', 'LBP', 'ل.ل.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (63, 'Sri Lankan Rupee', 'LKR', 'Rs', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (64, 'Lithuanian Litas', 'LTL', 'Lt', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (65, 'Latvian Lats', 'LVL', 'Ls', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (66, 'Libyan Dinar', 'LYD', 'د.ل.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (67, 'Moroccan Dirham', 'MAD', 'د.م.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (68, 'Moldovan Leu', 'MDL', 'L', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (69, 'Malagasy Ariary', 'MGA', 'Ar', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (70, 'Macedonian Denar', 'MKD', 'Ден', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (71, 'Myanma Kyat', 'MMK', 'K', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (72, 'Macanese Pataca', 'MOP', 'MOP$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (73, 'Mauritian Rupee', 'MUR', 'Rs', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (74, 'Mexican Peso', 'MXN', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (75, 'Malaysian Ringgit', 'MYR', 'RM', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (76, 'Mozambican Metical', 'MZN', 'MT', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (77, 'Namibian Dollar', 'NAD', 'N$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (78, 'Nigerian Naira', 'NGN', '₦', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (79, 'Nicaraguan Córdoba', 'NIO', 'C$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (80, 'Norwegian Krone', 'NOK', 'kr', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (81, 'Nepalese Rupee', 'NPR', 'Re.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (82, 'New Zealand Dollar', 'NZD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (83, 'Omani Rial', 'OMR', 'ر.ع.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (84, 'Panamanian Balboa', 'PAB', 'B/.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (85, 'Peruvian Nuevo Sol', 'PEN', 'S/', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (86, 'Philippine Peso', 'PHP', '₱', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (87, 'Pakistani Rupee', 'PKR', 'Rs', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (88, 'Polish Zloty', 'PLN', 'zł', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (89, 'Paraguayan Guarani', 'PYG', '₲', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (90, 'Qatari Rial', 'QAR', 'ر.ق.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (91, 'Romanian Leu', 'RON', 'lei', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (92, 'Serbian Dinar', 'RSD', 'din.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (93, 'Russian Ruble', 'RUB', '₽.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (94, 'Rwandan Franc', 'RWF', 'FRw', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (95, 'Saudi Riyal', 'SAR', 'ر.س.‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (96, 'Sudanese Pound', 'SDG', 'ج.س.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (97, 'Swedish Krona', 'SEK', 'kr', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (98, 'Singapore Dollar', 'SGD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (99, 'Somali Shilling', 'SOS', 'Sh.so.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (100, 'Syrian Pound', 'SYP', 'LS‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (101, 'Thai Baht', 'THB', '฿', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (102, 'Tunisian Dinar', 'TND', 'د.ت‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (103, 'Tongan Paʻanga', 'TOP', 'T$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (104, 'Turkish Lira', 'TRY', '₺', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (105, 'Trinidad and Tobago Dollar', 'TTD', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (106, 'New Taiwan Dollar', 'TWD', 'NT$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (107, 'Tanzanian Shilling', 'TZS', 'TSh', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (108, 'Ukrainian Hryvnia', 'UAH', '₴', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (109, 'Ugandan Shilling', 'UGX', 'USh', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (110, 'Uruguayan Peso', 'UYU', '$', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (111, 'Uzbekistan Som', 'UZS', 'so\'m', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (112, 'Venezuelan Bolívar', 'VEF', 'Bs.F.', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (113, 'Vietnamese Dong', 'VND', '₫', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (114, 'CFA Franc BEAC', 'XAF', 'FCFA', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (115, 'CFA Franc BCEAO', 'XOF', 'CFA', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (116, 'Yemeni Rial', 'YER', '﷼‏', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (117, 'South African Rand', 'ZAR', 'R', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (118, 'Zambian Kwacha', 'ZMK', 'ZK', 1.00, NULL, NULL);
INSERT INTO `currencies` VALUES (119, 'Zimbabwean Dollar', 'ZWL', 'Z$', 1.00, NULL, NULL);

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `balance` double NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (0, 'walking customer', '1', NULL, 'def.png', NULL, NULL, NULL, NULL, 0, '2021-11-28 12:37:48', '2021-11-28 12:37:48', NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (5, '2021_11_02_095022_create_business_settings_table', 1);
INSERT INTO `migrations` VALUES (6, '2021_11_02_114801_create_admins_table', 1);
INSERT INTO `migrations` VALUES (7, '2021_11_03_044923_create_categories_table', 1);
INSERT INTO `migrations` VALUES (8, '2021_11_03_090927_create_brands_table', 1);
INSERT INTO `migrations` VALUES (9, '2021_11_03_101237_create_products_table', 1);
INSERT INTO `migrations` VALUES (10, '2021_11_06_025604_create_currencies_table', 1);
INSERT INTO `migrations` VALUES (11, '2021_11_06_031804_create_orders_table', 1);
INSERT INTO `migrations` VALUES (12, '2021_11_06_084528_create_order_details_table', 1);
INSERT INTO `migrations` VALUES (13, '2021_11_08_094042_create_customers_table', 1);
INSERT INTO `migrations` VALUES (15, '2021_11_11_051704_create_coupons_table', 1);
INSERT INTO `migrations` VALUES (16, '2021_11_13_100539_create_units_table', 1);
INSERT INTO `migrations` VALUES (17, '2021_11_17_034203_create_accounts_table', 1);
INSERT INTO `migrations` VALUES (20, '2021_11_17_083502_create_transections_table', 2);
INSERT INTO `migrations` VALUES (21, '2021_11_09_064445_create_suppliers_table', 3);
INSERT INTO `migrations` VALUES (22, '2021_06_17_054551_create_soft_credentials_table', 4);
INSERT INTO `migrations` VALUES (23, '2021_12_01_141901_add_phone_col_admin', 4);
INSERT INTO `migrations` VALUES (24, '2021_12_02_092539_add_image_to_admin_tables', 4);
INSERT INTO `migrations` VALUES (25, '2016_06_01_000001_create_oauth_auth_codes_table', 5);
INSERT INTO `migrations` VALUES (26, '2016_06_01_000002_create_oauth_access_tokens_table', 5);
INSERT INTO `migrations` VALUES (27, '2016_06_01_000003_create_oauth_refresh_tokens_table', 5);
INSERT INTO `migrations` VALUES (28, '2016_06_01_000004_create_oauth_clients_table', 5);
INSERT INTO `migrations` VALUES (29, '2016_06_01_000005_create_oauth_personal_access_clients_table', 5);
INSERT INTO `migrations` VALUES (30, '2022_02_06_115834_create_companies_table', 5);
INSERT INTO `migrations` VALUES (31, '2022_02_06_121739_add_company_id_col_admin', 5);
INSERT INTO `migrations` VALUES (32, '2022_02_06_150041_add_company_id_category', 5);
INSERT INTO `migrations` VALUES (33, '2022_02_06_151731_add_company_id_brand', 5);
INSERT INTO `migrations` VALUES (34, '2022_02_06_152243_add_company_id_accounts', 5);
INSERT INTO `migrations` VALUES (35, '2022_02_06_152301_add_company_id_coupon', 5);
INSERT INTO `migrations` VALUES (36, '2022_02_06_152323_add_company_id_users', 5);
INSERT INTO `migrations` VALUES (37, '2022_02_06_152357_add_company_id_orders', 5);
INSERT INTO `migrations` VALUES (38, '2022_02_06_152412_add_company_id_order_details', 5);
INSERT INTO `migrations` VALUES (39, '2022_02_06_152429_add_company_id_products', 5);
INSERT INTO `migrations` VALUES (40, '2022_02_06_152453_add_company_id_suppliers', 5);
INSERT INTO `migrations` VALUES (41, '2022_02_06_152515_add_company_id_transactions', 5);
INSERT INTO `migrations` VALUES (42, '2022_02_06_152943_add_company_id_units', 5);
INSERT INTO `migrations` VALUES (43, '2022_02_06_154752_add_company_id_customers', 5);
INSERT INTO `migrations` VALUES (44, '2022_02_06_160446_add_company_id_business_settings', 5);
INSERT INTO `migrations` VALUES (45, '2022_06_19_194943_rename_columns_to_coupons_table', 5);

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------
INSERT INTO `oauth_access_tokens` VALUES ('09ad903f5f4484ffb7190b1a67b57117c14a8b69b9eb3fa972f76c091565f031b10f5f0f212ad076', 1, 1, 'LaravelPassportClient', '[]', 0, '2023-11-28 18:01:15', '2023-11-28 18:01:15', '2024-11-28 18:01:15');
INSERT INTO `oauth_access_tokens` VALUES ('0d4f40b681f07ddf8346c2933baca5df11d5f5a06c83a84c9ada784bbdbba59da0475634d3ae6dc6', 1, 1, 'LaravelPassportClient', '[]', 0, '2023-11-28 20:59:19', '2023-11-28 20:59:19', '2024-11-28 20:59:19');
INSERT INTO `oauth_access_tokens` VALUES ('aa53e3a86a38d10d26cd1d5777711e5b2e1cc94e6286dd6ae3b131de3d613d57cdc5927a10446a63', 1, 1, 'LaravelPassportClient', '[]', 0, '2023-11-28 21:58:07', '2023-11-28 21:58:07', '2024-11-28 21:58:07');

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_auth_codes_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------
INSERT INTO `oauth_clients` VALUES (1, NULL, 'Laravel Personal Access Client', 'pXnxAxPSKhx4ovCCoO44x3oKqy0opH0N7mhLApV4', NULL, 'http://localhost', 1, 0, 0, '2022-07-27 19:47:21', '2022-07-27 19:47:21');
INSERT INTO `oauth_clients` VALUES (2, NULL, 'Laravel Password Grant Client', 'yuCn4ks9guHGCG2ZBOBa5Y7jPloMveS07BV9JKpN', 'users', 'http://localhost', 0, 1, 0, '2022-07-27 19:47:21', '2022-07-27 19:47:21');

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------
INSERT INTO `oauth_personal_access_clients` VALUES (1, 1, '2022-07-27 19:47:21', '2022-07-27 19:47:21');

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint NULL DEFAULT NULL,
  `order_id` bigint NULL DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `product_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `discount_on_product` double NULL DEFAULT NULL,
  `discount_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'amount',
  `quantity` int NOT NULL DEFAULT 1,
  `tax_amount` double NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 1, 100001, 1000, '{\"id\":1,\"name\":\"Test Product\",\"product_code\":\"74982\",\"unit_type\":1,\"unit_value\":1,\"brand\":\"3\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2}]\",\"purchase_price\":700,\"selling_price\":1000,\"discount_type\":null,\"discount\":0,\"tax\":0,\"quantity\":59,\"image\":\"2023-10-25-65389342b5f12.png\",\"order_count\":10,\"supplier_id\":1,\"created_at\":\"2023-10-25T04:02:10.000000Z\",\"updated_at\":\"2023-11-28T14:24:08.000000Z\",\"company_id\":null}', 0, 'discount_on_product', 1, 0, '2023-11-28 21:24:08', '2023-11-28 21:24:08', NULL);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `order_amount` double NOT NULL DEFAULT 0,
  `total_tax` double NOT NULL,
  `collected_cash` double NULL DEFAULT NULL,
  `extra_discount` double NULL DEFAULT NULL,
  `coupon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `coupon_discount_amount` double NOT NULL DEFAULT 0,
  `coupon_discount_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `payment_id` bigint UNSIGNED NULL DEFAULT NULL,
  `transaction_reference` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (100001, 0, 1000, 0, 5000, 0, NULL, 0, NULL, 1, NULL, '2023-11-28 21:24:08', '2023-11-28 21:24:08', NULL);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_type` int UNSIGNED NULL DEFAULT NULL,
  `unit_value` double(8, 2) NULL DEFAULT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `category_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `purchase_price` double NULL DEFAULT NULL,
  `selling_price` double NULL DEFAULT NULL,
  `discount_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `discount` double(8, 2) NULL DEFAULT NULL,
  `tax` double(8, 2) NULL DEFAULT NULL,
  `quantity` bigint NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order_count` int UNSIGNED NULL DEFAULT NULL,
  `supplier_id` int UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Test Product', '74982', 1, 1.00, '3', '[{\"id\":\"1\",\"position\":1},{\"id\":\"2\",\"position\":2}]', 700, 1000, NULL, 0.00, 0.00, 59, '2023-10-25-65389342b5f12.png', 10, 1, '2023-10-25 11:02:10', '2023-11-28 21:24:08', NULL);

-- ----------------------------
-- Table structure for soft_credentials
-- ----------------------------
DROP TABLE IF EXISTS `soft_credentials`;
CREATE TABLE `soft_credentials`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of soft_credentials
-- ----------------------------

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `due_amount` double NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES (1, 'Test Supplier', '8801122334455', 'supplier@supplier.com', '2023-10-25-653892e145e47.png', 'Dhaka', 'Dhaka', '1000', 'Dhaka, Bangladesh', NULL, '2023-10-25 11:00:33', '2023-10-25 11:00:33', NULL);

-- ----------------------------
-- Table structure for transections
-- ----------------------------
DROP TABLE IF EXISTS `transections`;
CREATE TABLE `transections`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tran_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_id` bigint UNSIGNED NULL DEFAULT NULL,
  `amount` double NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `debit` tinyint(1) NULL DEFAULT NULL,
  `credit` tinyint(1) NULL DEFAULT NULL,
  `balance` double NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `customer_id` int UNSIGNED NULL DEFAULT NULL,
  `supplier_id` int UNSIGNED NULL DEFAULT NULL,
  `order_id` int UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transections
-- ----------------------------
INSERT INTO `transections` VALUES (1, 'Income', 1, 1000, 'POS order', 0, 1, 3000, '2023-11-28', 0, NULL, 100001, '2023-11-28 21:24:08', '2023-11-28 21:24:08', NULL);

-- ----------------------------
-- Table structure for units
-- ----------------------------
DROP TABLE IF EXISTS `units`;
CREATE TABLE `units`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of units
-- ----------------------------
INSERT INTO `units` VALUES (1, 'kg', '2021-11-28 12:34:53', '2021-11-28 12:34:53', NULL);
INSERT INTO `units` VALUES (2, 'Ltr', '2021-11-28 12:35:05', '2021-11-28 12:35:05', NULL);
INSERT INTO `units` VALUES (3, 'Pc', '2021-11-28 12:35:14', '2021-11-28 12:35:14', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
