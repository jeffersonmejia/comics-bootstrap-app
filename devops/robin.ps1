# Lista de backends y contenedores
$backends = @("web1","web2","web3")
$prefix = "p2lab1mejiajefferson_aso"

foreach ($b in $backends) {
    $container = "$prefix-$b-1"
    Write-Host "Actualizando navbar en $container..."

    # Comando para reemplazar el <ul> en index.html dentro del contenedor
    $cmd = @"
sed -i '/<ul class="navbar-nav ms-auto align-items-center">/,/<\/ul>/c\<ul class="navbar-nav ms-auto align-items-center">\n<li class="nav-item"><a class="nav-link" href="#$b">$b</a></li>\n</ul>' /usr/share/nginx/html/index.html
"@

    # Ejecutar el comando dentro del contenedor
    docker exec $container sh -c $cmd
}

Write-Host "Navbar actualizado en todos los backends: $($backends -join ', ')"
