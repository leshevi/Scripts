<?php
     $host = '{{ db }}'; // Или IP-адрес сервера MariaDB
     $dbname = '{{ db_name }}';
     $username = '{{ db_user }}';
     $password = '{{ db_pass }}';

     try {
         $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
         $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
         echo "Подключение к базе данных успешно!";
     } catch(PDOException $e) {
         echo "Ошибка подключения: " . $e->getMessage();
     }
     ?>
