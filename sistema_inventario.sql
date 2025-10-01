-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 01-10-2025 a las 01:10:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_inventario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--

CREATE TABLE `almacenes` (
  `id_almacen` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `almacenes`
--

INSERT INTO `almacenes` (`id_almacen`, `nombre`, `ubicacion`, `fecha_creacion`) VALUES
(1, 'Almacén Central', 'CDMX', '2025-09-29 21:23:43'),
(2, 'Almacén Norte', 'Monterrey', '2025-09-29 21:23:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id_auditoria` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(100) NOT NULL,
  `tabla_afectada` varchar(50) NOT NULL,
  `row_id` int(11) DEFAULT NULL,
  `detalles_json` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id_auditoria`, `usuario_id`, `accion`, `tabla_afectada`, `row_id`, `detalles_json`, `fecha`) VALUES
(1, 1, 'login', 'usuarios', NULL, 'null', '2025-09-29 19:12:27'),
(2, 1, 'logout', 'usuarios', NULL, 'null', '2025-09-29 19:23:05'),
(3, 1, 'login', 'usuarios', NULL, 'null', '2025-09-29 19:55:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre_categoria`) VALUES
(1, 'Electrónica'),
(3, 'Limpieza'),
(2, 'Papelería');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `fecha_creacion`) VALUES
(1, 'Laptop', 'Portátil de oficina', 12000.00, 5, 1, '2025-09-29 21:23:43'),
(2, 'Mouse', 'Mouse óptico', 150.00, 50, 1, '2025-09-29 21:23:43'),
(3, 'Cuaderno', 'Cuaderno profesional', 35.00, 100, 2, '2025-09-29 21:23:43'),
(4, 'Detergente', 'Detergente multiusos', 80.00, 20, 3, '2025-09-29 21:23:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_almacenes`
--

CREATE TABLE `productos_almacenes` (
  `id_producto_almacen` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_productos`
--

CREATE TABLE `solicitudes_productos` (
  `id_solicitud` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_registro`
--

CREATE TABLE `solicitudes_registro` (
  `id_solicitud_registro` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  `tipo_usuario` enum('administrador','operador','consulta') DEFAULT 'consulta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `tipo_usuario` enum('administrador','operador','consulta') NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `contrasena`, `tipo_usuario`, `fecha_creacion`) VALUES
(1, 'admin_principal', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'administrador', '2025-09-29 18:25:36'),
(2, 'operador1', '8c91989366e0a771b67f9b0c032c0fcf6a53e9333f756f36574122fe60924505', 'operador', '2025-09-29 21:23:43'),
(3, 'consulta1', '922b05077df60b91f3ea8422109288159e57a6b32a5377e52917f80847df706b', 'consulta', '2025-09-29 21:23:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_almacenes`
--

CREATE TABLE `usuarios_almacenes` (
  `id_usuario_almacen` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_almacen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  ADD PRIMARY KEY (`id_almacen`);

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id_auditoria`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `tabla_afectada` (`tabla_afectada`),
  ADD KEY `fecha` (`fecha`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre_categoria` (`nombre_categoria`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `productos_almacenes`
--
ALTER TABLE `productos_almacenes`
  ADD PRIMARY KEY (`id_producto_almacen`),
  ADD UNIQUE KEY `id_producto` (`id_producto`,`id_almacen`),
  ADD KEY `id_almacen` (`id_almacen`);

--
-- Indices de la tabla `solicitudes_productos`
--
ALTER TABLE `solicitudes_productos`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `solicitudes_registro`
--
ALTER TABLE `solicitudes_registro`
  ADD PRIMARY KEY (`id_solicitud_registro`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`);

--
-- Indices de la tabla `usuarios_almacenes`
--
ALTER TABLE `usuarios_almacenes`
  ADD PRIMARY KEY (`id_usuario_almacen`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`,`id_almacen`),
  ADD KEY `id_almacen` (`id_almacen`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id_almacen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id_auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos_almacenes`
--
ALTER TABLE `productos_almacenes`
  MODIFY `id_producto_almacen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes_productos`
--
ALTER TABLE `solicitudes_productos`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes_registro`
--
ALTER TABLE `solicitudes_registro`
  MODIFY `id_solicitud_registro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios_almacenes`
--
ALTER TABLE `usuarios_almacenes`
  MODIFY `id_usuario_almacen` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);

--
-- Filtros para la tabla `productos_almacenes`
--
ALTER TABLE `productos_almacenes`
  ADD CONSTRAINT `productos_almacenes_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `productos_almacenes_ibfk_2` FOREIGN KEY (`id_almacen`) REFERENCES `almacenes` (`id_almacen`);

--
-- Filtros para la tabla `solicitudes_productos`
--
ALTER TABLE `solicitudes_productos`
  ADD CONSTRAINT `solicitudes_productos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `solicitudes_productos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `usuarios_almacenes`
--
ALTER TABLE `usuarios_almacenes`
  ADD CONSTRAINT `usuarios_almacenes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `usuarios_almacenes_ibfk_2` FOREIGN KEY (`id_almacen`) REFERENCES `almacenes` (`id_almacen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
