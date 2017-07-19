net stop "Acronis Managed Machine Service" /y
net stop "Acronis Scheduler2 Service" /y
net stop "Acronis Remote Agent Service" /y
net stop "Acronis Removable Storage Management Service" /y
ping 8.8.8.8
net start "Acronis Managed Machine Service"
net start "Acronis Scheduler2 Service"
net start "Acronis Remote Agent Service"
net start "Acronis Removable Storage Management Service"
