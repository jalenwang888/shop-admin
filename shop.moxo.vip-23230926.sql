-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2023 at 10:27 PM
-- Server version: 5.5.62-log
-- PHP Version: 8.0.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop.moxo.vip`
--

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` varchar(255) DEFAULT NULL COMMENT '群ID',
  `introduction` varchar(255) DEFAULT NULL COMMENT '群简介',
  `notification` varchar(255) DEFAULT NULL COMMENT '通告',
  `group_name` varchar(255) DEFAULT NULL COMMENT '群名称',
  `group_type` varchar(255) DEFAULT NULL COMMENT 'Private:好友, Public:公开, AVChatRoom: 直播, ChatRoom:临时会议',
  `website` varchar(255) DEFAULT NULL COMMENT '网站',
  `member_num` int(11) NOT NULL DEFAULT '0' COMMENT '群在线人数',
  `total_member_num` int(11) NOT NULL DEFAULT '0' COMMENT '群在线人数',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `chats`
--

INSERT INTO `chats` (`id`, `group_id`, `introduction`, `notification`, `group_name`, `group_type`, `website`, `member_num`, `total_member_num`, `active`, `created_at`, `updated_at`) VALUES
(1, '@TGS#2VW2LVCNS', '中国-巴西', '世界杯决赛', '世界杯', 'Public', 'vite.moxo.vip', 0, 0, 1, '2023-08-07 18:09:20', '2023-08-07 18:09:20'),
(2, '@TGS#2YSSNVCNV', '中国-阿根廷', '世界杯决赛', '世界杯', 'Public', 'vite.moxo.vip', 0, 0, 1, '2023-08-07 18:24:08', '2023-08-07 18:24:08'),
(3, '@TGS#2Y7SNVCNY', '中国-德国', '世界杯决赛', '世界杯', 'Public', 'vite.moxo.vip', 0, 0, 1, '2023-08-07 18:24:15', '2023-08-07 18:24:15'),
(4, '@TGS#22ARPVCN3', '中国-英国', '世界杯决赛', '世界杯', 'Public', 'vite.moxo.vip', 0, 0, 1, '2023-08-07 18:40:41', '2023-08-07 18:40:41');

-- --------------------------------------------------------

--
-- Table structure for table `filters`
--

CREATE TABLE `filters` (
  `id` int(10) UNSIGNED NOT NULL,
  `keywords` varchar(255) NOT NULL COMMENT '关键词',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `filters`
--

INSERT INTO `filters` (`id`, `keywords`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '转账', 1, 1, '2023-08-07 06:28:07', NULL),
(2, '微信', 1, 1, '2023-08-07 06:28:07', NULL),
(3, 'wx', 1, 1, '2023-08-07 06:28:07', '2023-11-29 15:45:55'),
(4, 'test', 0, 1, '2023-08-07 06:28:07', '2023-09-11 16:41:27');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(29, '2014_10_12_000000_create_users_table', 1),
(30, '2014_10_12_100000_create_password_resets_table', 1),
(31, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(32, '2023_06_02_114320_create_reports_table', 1),
(33, '2023_06_13_104405_create_filters_table', 1),
(34, '2023_07_12_171501_create_notifies_table', 1),
(35, '2023_07_27_171904_create_chats_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifies`
--

CREATE TABLE `notifies` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'system' COMMENT '类型',
  `status` varchar(255) NOT NULL DEFAULT 'unread' COMMENT '状态 read, unread',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作者',
  `message` varchar(255) NOT NULL COMMENT '内容， JSON格式保存',
  `notifier_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '发送通知',
  `user_id` int(11) DEFAULT NULL COMMENT '接收用户',
  `department_id` varchar(255) DEFAULT NULL COMMENT '接收部门',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notifies`
--

INSERT INTO `notifies` (`id`, `type`, `status`, `operator`, `message`, `notifier_user_id`, `user_id`, `department_id`, `created_at`, `updated_at`) VALUES
(1, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:15:57', '2023-08-07 16:24:01'),
(2, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:16:53', '2023-08-07 19:21:48'),
(3, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:21:42', '2023-09-11 16:48:22'),
(4, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:22:40', '2023-09-11 16:48:22'),
(5, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:23:09', '2023-09-11 16:48:22'),
(6, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:23:55', '2023-09-11 16:48:22'),
(7, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:24:15', '2023-09-11 16:48:22'),
(8, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:24:40', '2023-09-11 16:48:22'),
(9, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:25:38', '2023-09-11 16:48:22'),
(10, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:25:53', '2023-09-11 16:48:22'),
(11, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:25:55', '2023-09-11 16:48:22'),
(12, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:32:15', '2023-09-11 16:48:22'),
(13, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:41:27', '2023-09-11 16:48:22'),
(14, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:41:31', '2023-09-11 16:48:22'),
(15, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:42:34', '2023-09-11 16:48:22'),
(16, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:48:12', '2023-09-11 16:48:22'),
(17, 'system', 'unread', NULL, '警告测试信息', 0, 2, NULL, '2023-08-07 15:53:03', '2023-08-07 15:53:03'),
(18, 'system', 'unread', NULL, '警告测试信息', 0, 2, NULL, '2023-08-07 15:53:34', '2023-08-07 15:53:34'),
(19, 'system', 'unread', NULL, '警告测试信息', 0, 2, NULL, '2023-08-07 15:53:44', '2023-08-07 15:53:44'),
(20, 'system', 'unread', NULL, '警告测试信息', 0, 2, NULL, '2023-08-07 15:54:43', '2023-08-07 15:54:43'),
(21, 'system', 'unread', NULL, '警告测试信息', 0, 2, NULL, '2023-08-07 15:56:42', '2023-08-07 15:56:42'),
(22, 'system', 'unread', NULL, '警告测试信息', 0, 2, NULL, '2023-08-07 15:56:52', '2023-08-07 15:56:52'),
(23, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:57:13', '2023-09-11 16:48:22'),
(24, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:57:21', '2023-09-11 16:48:22'),
(25, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:57:34', '2023-09-11 16:48:22'),
(26, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 15:58:25', '2023-09-11 16:48:22'),
(27, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 16:02:38', '2023-09-11 16:48:22'),
(28, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 16:02:46', '2023-09-11 16:48:22'),
(29, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 16:02:48', '2023-09-11 16:48:22'),
(30, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 16:02:51', '2023-09-11 16:48:22'),
(31, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 16:02:55', '2023-09-11 16:48:22'),
(32, 'system', 'read', NULL, '转账', 0, 1, NULL, '2023-08-07 16:15:49', '2023-09-11 16:48:22'),
(33, 'system', 'read', NULL, 'test', 0, 1, NULL, '2023-08-07 16:19:31', '2023-09-11 16:48:22'),
(34, 'system', 'read', NULL, 'test', 0, 1, NULL, '2023-08-07 16:25:38', '2023-09-11 16:48:22'),
(35, 'system', 'read', NULL, '你愁啥', 0, 1, NULL, '2023-08-07 16:26:13', '2023-09-11 16:48:23');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(128) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `report_user_id` varchar(255) NOT NULL COMMENT '举报者',
  `report_type` varchar(255) NOT NULL COMMENT '举报类型',
  `user_id` varchar(255) NOT NULL COMMENT '被举报ID',
  `user_nick` varchar(255) NOT NULL COMMENT '被举报者姓名',
  `group_id` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `random` varchar(255) NOT NULL COMMENT '信息唯一Random',
  `message_time` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'new',
  `operator` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `report_user_id`, `report_type`, `user_id`, `user_nick`, `group_id`, `message`, `random`, `message_time`, `status`, `operator`, `created_at`, `updated_at`) VALUES
(1, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 14:47:20', '2023-08-07 15:18:31'),
(2, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 14:50:08', '2023-08-07 15:18:42'),
(3, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 14:52:46', '2023-08-07 15:18:18'),
(4, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 14:52:53', '2023-08-07 15:18:25'),
(5, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:00:00', '2023-08-07 15:00:00'),
(6, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:01:27', '2023-08-07 15:01:27'),
(7, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:15:57', '2023-08-07 15:15:57'),
(8, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:16:53', '2023-08-07 15:16:53'),
(9, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:21:42', '2023-08-07 15:21:42'),
(10, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:22:40', '2023-08-07 15:22:40'),
(11, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:23:09', '2023-08-07 15:23:09'),
(12, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:23:55', '2023-08-07 15:23:55'),
(13, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:24:15', '2023-08-07 15:24:15'),
(14, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:24:40', '2023-08-07 15:24:40'),
(15, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:25:38', '2023-08-07 15:25:38'),
(16, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:25:53', '2023-08-07 15:25:53'),
(17, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:25:54', '2023-08-07 15:25:54'),
(18, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:32:15', '2023-08-07 15:32:15'),
(19, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:41:27', '2023-08-07 15:41:27'),
(20, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:41:30', '2023-08-07 15:41:30'),
(21, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:42:34', '2023-08-07 15:42:34'),
(22, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'new', NULL, '2023-08-07 15:48:12', '2023-08-07 15:48:12'),
(23, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'stopSpeaker', 'ADMIN_1', '2023-08-07 15:57:13', '2023-09-11 16:42:40'),
(24, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 15:57:21', '2023-09-11 16:42:19'),
(25, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 15:57:34', '2023-08-14 14:47:55'),
(26, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 15:58:25', '2023-08-14 14:47:47'),
(27, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 16:02:38', '2023-08-07 17:24:22'),
(28, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 16:02:46', '2023-08-07 17:21:21'),
(29, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 16:02:48', '2023-08-07 17:10:13'),
(30, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 16:02:51', '2023-08-07 17:08:10'),
(31, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 16:02:55', '2023-08-07 17:25:34'),
(32, '足球小子_3', '脏话谩骂', '篮球小子_4', '篮球小子', '@TGS#2XNSHTCNH', '瞅你咋地', '70638802', '1691395968', 'warn', 'ADMIN_1', '2023-08-07 16:13:02', '2023-08-07 17:01:12'),
(33, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691395996028', 'stopSpeaker', 'ADMIN_1', '2023-08-07 16:13:20', '2023-08-07 17:00:32'),
(34, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', 'test', '000000', '1691396048429', 'warn', 'ADMIN_1', '2023-08-07 16:14:12', '2023-08-07 17:00:16'),
(35, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691377661796', 'warn', 'ADMIN_1', '2023-08-07 16:15:49', '2023-08-07 17:26:24'),
(36, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', 'test', '000000', '1691396048429', 'warn', 'ADMIN_1', '2023-08-07 16:19:31', '2023-08-07 16:44:06'),
(37, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '<div><br></div><div>转账</div>', '000000', '1691396518645', 'warn', 'ADMIN_1', '2023-08-07 16:22:02', '2023-08-07 16:41:15'),
(38, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', '转账', '000000', '1691396530981', 'warn', 'ADMIN_1', '2023-08-07 16:22:14', '2023-08-07 17:35:49'),
(39, 'system', 'system', '足球小子_3', '足球小子', '@TGS#2XNSHTCNH', 'test', '000000', '1691396734124', 'warn', 'ADMIN_1', '2023-08-07 16:25:38', '2023-08-07 17:35:18'),
(40, '足球小子_3', '脏话谩骂', '篮球小子_4', '篮球小子', '@TGS#2XNSHTCNH', '你愁啥', '13884255', '1691395953', 'warn', 'ADMIN_1', '2023-08-07 16:26:13', '2023-11-29 15:45:36');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `department` varchar(50) NOT NULL DEFAULT 'player' COMMENT 'admin, player, agent, administrator',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `nick` varchar(128) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `department`, `active`, `nick`, `level`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@g.com', '$2y$10$cwTNv2OjOjRG9eSLXTOM9uhsgjaEVcdiqQCqjgjiBYV1IHWCqyyUK', 'administrator', 0, 'ADMIN', 0, NULL, '2023-08-07 06:28:07', NULL),
(2, '旋风小子', 'player1@g.com', '$2y$10$cwTNv2OjOjRG9eSLXTOM9uhsgjaEVcdiqQCqjgjiBYV1IHWCqyyUK', 'player', 0, '旋风小子', 0, NULL, '2023-08-07 06:28:07', NULL),
(3, '足球小子', 'player2@g.com', '$2y$10$cwTNv2OjOjRG9eSLXTOM9uhsgjaEVcdiqQCqjgjiBYV1IHWCqyyUK', 'player', 0, '足球小子', 0, NULL, '2023-08-07 06:28:07', NULL),
(4, '篮球小子', 'player3@g.com', '$2y$10$cwTNv2OjOjRG9eSLXTOM9uhsgjaEVcdiqQCqjgjiBYV1IHWCqyyUK', 'player', 0, '篮球小子', 0, NULL, '2023-08-07 06:28:07', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chats_group_id_index` (`group_id`);

--
-- Indexes for table `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifies`
--
ALTER TABLE `notifies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `filters`
--
ALTER TABLE `filters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `notifies`
--
ALTER TABLE `notifies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
