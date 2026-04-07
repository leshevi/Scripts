# Находим интерфейс по имени и отключаем Forwarding
Get-NetIPInterface -InterfaceAlias "Ethernet" | Set-NetIPInterface -Forwarding Disabled