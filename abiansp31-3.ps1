# Obtener dinámicamente los registros de eventos que tienen registros guardados
$logs = Get-WinEvent -ListLog * | Where-Object { $_.RecordCount -gt 0 }

$opcion = -1

while ($opcion -ne 0) {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "     MENÚ DE REGISTROS DE EVENTOS       " -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan

    # Mostrar el menú numerado dinámicamente a partir de la máquina actual
    for ($i = 0; $i -lt $logs.Count; $i++) {
        $num = $i + 1
        Write-Host "$num. $($logs[$i].LogName)"
    }
    Write-Host "0. Salir"
    Write-Host "----------------------------------------"

    $opcion = Read-Host "Elige una opción"

    # Salir si pulsa 0
    if ($opcion -eq '0') {
        Write-Host "Saliendo del programa..." -ForegroundColor Green
        break
    }

    # Validar que la opción introducida sea un número dentro del rango del menú
    if ($opcion -match '^\d+$' -and [int]$opcion -ge 1 -and [int]$opcion -le $logs.Count) {
        $indice = [int]$opcion - 1
        $nombreLog = $logs[$indice].LogName
        $totalEventos = $logs[$indice].RecordCount

        Clear-Host
        Write-Host "Registro seleccionado: $nombreLog" -ForegroundColor Yellow
        Write-Host "Total de eventos en este registro: $totalEventos"
        Write-Host "----------------------------------------"
        Write-Host "Mostrando los 12 últimos registros:" -ForegroundColor Yellow
        Write-Host ""

        # Mostrar cuántos hay y los 12 últimos registros de forma sencilla
        Get-WinEvent -LogName $nombreLog -MaxEvents 12 -ErrorAction SilentlyContinue | Select-Object TimeCreated, Id, Message

        Write-Host "----------------------------------------"
        Read-Host "Presiona Enter para volver al menú"
    } 
    else {
        # Controlar opción no válida
        Write-Host "Opción no válida. Introduce un número del menú." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}