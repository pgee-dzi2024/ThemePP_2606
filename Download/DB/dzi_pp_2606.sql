-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране: 14 апр 2026 в 15:51
-- Версия на сървъра: 10.4.32-MariaDB
-- Версия на PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `dzi_pp_2606`
--

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add manicure design', 7, 'add_manicuredesign'),
(26, 'Can change manicure design', 7, 'change_manicuredesign'),
(27, 'Can delete manicure design', 7, 'delete_manicuredesign'),
(28, 'Can view manicure design', 7, 'view_manicuredesign'),
(29, 'Can add user session', 8, 'add_usersession'),
(30, 'Can change user session', 8, 'change_usersession'),
(31, 'Can delete user session', 8, 'delete_usersession'),
(32, 'Can view user session', 8, 'view_usersession');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$hyiGe8Lwut9wQNuJk8nkn2$Nq9Ygr1yXslx4MgZi4KfKya9QJpPOp6zUPhCBTvTAQU=', '2026-04-11 19:01:02.095405', 1, 'user_26', '', '', '', 1, 1, '2026-02-10 00:15:57.676023');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-04-11 12:55:53.734036', '1', 'дизайн 1', 1, '[{\"added\": {}}]', 7, 1),
(2, '2026-04-11 13:23:41.155468', '2', 'дизайн_1', 1, '[{\"added\": {}}]', 7, 1),
(3, '2026-04-11 13:24:22.521327', '3', 'дизайн_2', 1, '[{\"added\": {}}]', 7, 1),
(4, '2026-04-11 14:12:05.428327', '3', 'дизайн_2', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u0437\\u043e\\u0431\\u0440\\u0430\\u0436\\u0435\\u043d\\u0438\\u0435 \\u0437\\u0430 \\u0441\\u0438\\u043c\\u0443\\u043b\\u0430\\u0446\\u0438\\u044f\"]}}]', 7, 1),
(5, '2026-04-11 18:45:16.719785', '4', 'Дизайн 3', 1, '[{\"added\": {}}]', 7, 1),
(6, '2026-04-11 18:45:51.371825', '5', 'дизайн 6', 1, '[{\"added\": {}}]', 7, 1),
(7, '2026-04-11 18:46:28.960446', '6', 'дизайн 9', 1, '[{\"added\": {}}]', 7, 1),
(8, '2026-04-11 18:47:34.251336', '7', 'дизайн 11', 1, '[{\"added\": {}}]', 7, 1),
(9, '2026-04-11 18:50:26.333566', '7', 'дизайн 11', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u0437\\u043e\\u0431\\u0440\\u0430\\u0436\\u0435\\u043d\\u0438\\u0435 \\u0437\\u0430 \\u0441\\u0438\\u043c\\u0443\\u043b\\u0430\\u0446\\u0438\\u044f\"]}}]', 7, 1),
(10, '2026-04-11 18:51:49.396196', '7', 'дизайн 11', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u0437\\u043e\\u0431\\u0440\\u0430\\u0436\\u0435\\u043d\\u0438\\u0435 \\u0437\\u0430 \\u0441\\u0438\\u043c\\u0443\\u043b\\u0430\\u0446\\u0438\\u044f\"]}}]', 7, 1),
(11, '2026-04-11 19:01:35.031673', '8', 'дизайн 11', 1, '[{\"added\": {}}]', 7, 1),
(12, '2026-04-11 19:02:36.199389', '9', 'дизайн 9', 1, '[{\"added\": {}}]', 7, 1),
(13, '2026-04-11 19:03:19.928101', '10', 'дизйн 3', 1, '[{\"added\": {}}]', 7, 1),
(14, '2026-04-11 19:03:37.085048', '11', 'дизайн 1', 1, '[{\"added\": {}}]', 7, 1),
(15, '2026-04-11 19:14:28.088290', '8', 'дизайн 11', 2, '[{\"changed\": {\"fields\": [\"\\u0418\\u0437\\u043e\\u0431\\u0440\\u0430\\u0436\\u0435\\u043d\\u0438\\u0435 \\u0437\\u0430 \\u0441\\u0438\\u043c\\u0443\\u043b\\u0430\\u0446\\u0438\\u044f\"]}}]', 7, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'main', 'manicuredesign'),
(8, 'main', 'usersession'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура на таблица `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-02-10 00:15:10.708943'),
(2, 'auth', '0001_initial', '2026-02-10 00:15:11.159807'),
(3, 'admin', '0001_initial', '2026-02-10 00:15:11.250361'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-02-10 00:15:11.257885'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-10 00:15:11.264902'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-02-10 00:15:11.317946'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-02-10 00:15:11.365431'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-02-10 00:15:11.382467'),
(9, 'auth', '0004_alter_user_username_opts', '2026-02-10 00:15:11.390868'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-02-10 00:15:11.430066'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-02-10 00:15:11.432575'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-02-10 00:15:11.439595'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-02-10 00:15:11.451108'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-02-10 00:15:11.463146'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-02-10 00:15:11.474702'),
(16, 'auth', '0011_update_proxy_permissions', '2026-02-10 00:15:11.481701'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-02-10 00:15:11.497260'),
(18, 'sessions', '0001_initial', '2026-02-10 00:15:11.525473'),
(19, 'main', '0001_initial', '2026-04-11 10:55:12.878898'),
(20, 'main', '0002_alter_manicuredesign_options_and_more', '2026-04-11 11:32:14.536388'),
(21, 'main', '0003_remove_manicuredesign_image_and_more', '2026-04-11 13:21:46.540592'),
(22, 'main', '0004_alter_manicuredesign_gallery_image_and_more', '2026-04-11 13:35:24.314111');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('6l1nud7ppdibpqv1i7aiv798x6g7e07p', '.eJxVjDsOwjAQBe_iGln-xR9K-pzB2vUuOIAcKU4qxN0hUgpo38y8l8iwrTVvnZc8kTgLLU6_G0J5cNsB3aHdZlnmti4Tyl2RB-1ynImfl8P9O6jQ67dmFSgCpBSc0snrFIchRZ-Kj7oQWmU18dWzNkGxQ4M-WvRsrUNC40C8P8DiN0w:1wBdZm:ef_ye1FL1fAy01Kk4cbbVvcc-eLdFdyu-ePVCH7hK0k', '2026-04-25 19:01:02.097914');

-- --------------------------------------------------------

--
-- Структура на таблица `main_manicuredesign`
--

CREATE TABLE `main_manicuredesign` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `gallery_image` varchar(100) NOT NULL,
  `simulation_image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_manicuredesign`
--

INSERT INTO `main_manicuredesign` (`id`, `name`, `created_at`, `gallery_image`, `simulation_image`) VALUES
(8, 'дизайн 11', '2026-04-11 19:01:35.031673', 'designs/gallery/m11_e9tWyVz.jpg', 'designs/simulation/m11_.png'),
(9, 'дизайн 9', '2026-04-11 19:02:36.198388', 'designs/gallery/m9_lnC1SwO.jpg', 'designs/simulation/m9__lOPzr09.jpg'),
(10, 'дизйн 3', '2026-04-11 19:03:19.925737', 'designs/gallery/m3_uGpcBdK.jpg', 'designs/simulation/m3__lkmQe3N.png'),
(11, 'дизайн 1', '2026-04-11 19:03:37.084049', 'designs/gallery/m1.jpg', 'designs/simulation/m1_.png');

-- --------------------------------------------------------

--
-- Структура на таблица `main_usersession`
--

CREATE TABLE `main_usersession` (
  `id` bigint(20) NOT NULL,
  `original_image` varchar(100) NOT NULL,
  `processed_image` varchar(100) DEFAULT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `selected_design_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_usersession`
--

INSERT INTO `main_usersession` (`id`, `original_image`, `processed_image`, `uploaded_at`, `selected_design_id`) VALUES
(39, 'uploads/hand_T5XLaNb.png', 'processed/session_39_processed.jpg', '2026-04-11 19:03:56.515531', 8),
(40, 'uploads/hand_cSCfQPi.png', 'processed/session_40_processed.jpg', '2026-04-11 19:04:21.219558', 10),
(41, 'uploads/hand_a366TNH.png', 'processed/session_41_processed.jpg', '2026-04-11 19:04:46.813672', 9),
(42, 'uploads/hand_ArDe6SW.png', 'processed/session_42_processed.jpg', '2026-04-11 19:05:17.205976', 11),
(43, 'uploads/hand_gjrTpGN.png', 'processed/session_43_processed.jpg', '2026-04-11 19:08:26.275317', 8),
(44, 'uploads/hand_N6GOlsQ.png', 'processed/session_44_processed.jpg', '2026-04-11 19:14:41.289072', 8),
(45, 'uploads/hand_hIS0mF3.png', 'processed/session_45_processed.jpg', '2026-04-11 19:20:59.954506', 8),
(46, 'uploads/hand_JzGhT2E.png', 'processed/session_46_processed.jpg', '2026-04-11 19:27:03.326148', 8),
(47, 'uploads/hand_UM92ycW.png', 'processed/session_47_processed.jpg', '2026-04-11 19:27:35.299351', 8),
(48, 'uploads/hand_C36uHzd.png', 'processed/session_48_processed.jpg', '2026-04-11 19:28:22.909119', 8),
(49, 'uploads/hand_nl0mjB6.png', 'processed/session_49_processed.jpg', '2026-04-11 19:28:43.640326', 10),
(50, 'uploads/hand_jzOCzaA.png', 'processed/session_50_processed.jpg', '2026-04-11 19:29:23.028293', 10),
(51, 'uploads/hand_knLHxUR.png', 'processed/session_51_processed.jpg', '2026-04-11 19:30:25.149282', 10),
(52, 'uploads/hand_vGvVrC8.png', 'processed/session_52_processed.jpg', '2026-04-11 19:35:48.118645', 10),
(53, 'uploads/hand_02jFh9n.png', 'processed/session_53_processed.jpg', '2026-04-11 19:36:45.277900', 10),
(54, 'uploads/hand_l56qlad.png', 'processed/session_54_processed.jpg', '2026-04-11 19:37:28.386805', 10),
(55, 'uploads/hand_KVoHhRj.png', 'processed/session_55_processed.jpg', '2026-04-11 19:42:46.586468', 10),
(56, 'uploads/hand_EcH4Nit.png', 'processed/session_56_processed.jpg', '2026-04-11 19:43:16.507834', 8),
(57, 'uploads/hand_VTBBHHy.png', 'processed/session_57_processed.jpg', '2026-04-11 19:44:13.106374', 8),
(58, 'uploads/hand_ZJB9VM4.png', 'processed/session_58_processed.jpg', '2026-04-11 19:44:36.002884', 10),
(59, 'uploads/hand_7TkfhzA.png', 'processed/session_59_processed.jpg', '2026-04-11 19:47:04.431670', 10),
(60, 'uploads/hand_a1iQL8P.png', 'processed/session_60_processed.jpg', '2026-04-11 19:50:12.396502', 10),
(63, 'uploads/hand_KFkU78c.png', 'processed/session_63_processed.jpg', '2026-04-11 20:02:14.829607', 8),
(64, 'uploads/hand_a7ni3Y0.png', 'processed/session_64_processed.jpg', '2026-04-11 23:27:12.803716', 9);

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индекси за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индекси за таблица `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индекси за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индекси за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индекси за таблица `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индекси за таблица `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Индекси за таблица `main_manicuredesign`
--
ALTER TABLE `main_manicuredesign`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_usersession`
--
ALTER TABLE `main_usersession`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_usersession_selected_design_id_b5c97359_fk_main_mani` (`selected_design_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `main_manicuredesign`
--
ALTER TABLE `main_manicuredesign`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `main_usersession`
--
ALTER TABLE `main_usersession`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_usersession`
--
ALTER TABLE `main_usersession`
  ADD CONSTRAINT `main_usersession_selected_design_id_b5c97359_fk_main_mani` FOREIGN KEY (`selected_design_id`) REFERENCES `main_manicuredesign` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
