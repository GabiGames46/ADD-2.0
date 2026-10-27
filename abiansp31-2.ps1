#parametros que espera el script
param (
    [Parameter(Mandatory=$true)]
    [string]$inicio,
    
    [Parameter(Mandatory=$true)]
    [string]$fin
)

# Convertir los parámetros de texto a formato fecha
$fechaInicio = [datetime]$inicio
$fechaFin = [datetime]$fin

Write-Host "Eventos de Inicio de Sesión:"

# Consultar el registro de Seguridad de Windows (ID 4624 = Inicio de sesión correcto)
$eventos = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624; StartTime=$fechaInicio; EndTime=$fechaFin} -ErrorAction SilentlyContinue

# Recorrer cada evento encontrado
foreach ($ev in $eventos) {
    # Obtener los datos del evento en XML para extraer el nombre de usuario
    [xml]$xml = $ev.ToXml()
    $usuario = ($xml.Event.EventData.Data | Where-Object { $_.Name -eq 'TargetUserName' }).'#text'
    
    # Filtrar para excluir al usuario SYSTEM
    if ($usuario -ne 'SYSTEM') {
        $formatoFecha = $ev.TimeCreated.ToString("MM/dd/yyyy HH:mm:ss")
        Write-Host "Fecha: $formatoFecha - Usuario: $usuario"
    }
}