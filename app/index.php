<?php
include 'db.php';

$message = '';
$classMessage = '';
$hostname = '';
$ip = '';

function checkDb() {
    global $message, $classMessage;
    $pdo = db();
    $message = $pdo ? "Conectada" : "Desconectada";
    $classMessage = $pdo ? "success-db-message" : "error-db-message";
}

function serverInfo() {
    global $hostname, $ip;
    $hostname = $_SERVER['NGINX_HOST'] ?? gethostname();
    $ip = $_SERVER['NGINX_IP'] ?? trim(shell_exec("hostname -i"));
}

checkDb();
serverInfo();
?>


<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Avengers gallery</title>
		<link rel="shortcut icon" href="./src/assets/icons/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="./src/css/index.css" />
	</head>

	<body>
		<nav class="navbar navbar-expand-lg navbar-dark bg-black sticky-top">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">Avengers gallery</a>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ms-auto align-items-center">
						<li class="nav-item">
							<a class="nav-link active" href="#">Inicio</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#contact-me">Contacto</a>
						</li>
						<li class="nav-item ms-3">
							<button id="darkModeToggle" class="btn btn-outline-light">
								<i class="bi bi-moon-fill"></i>
							</button>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		
<div class="<?= $classMessage ?>">
    <div class="box-text">
        <div class="state-group"><strong>Host:</strong> <span><?= $hostname ?></span></div>
        <div class="state-group"><strong>IP:</strong> <span><?= $ip ?></span></div>
        <div class="state-group"><strong>Base de datos:</strong> <span><?= $message ?></span></div>
    </div>
</div>

               

		<header class="mb-5">
			<figure class="position-relative m-0">
				<img src="./src/assets/cover/cover_home.jpg" class="img-fluid w-100" alt="Cover" style="filter: brightness(50%)" />
				<figcaption class="position-absolute top-50 start-50 translate-middle text-center text-white px-3">
					<h2 class="display-4 fw-bold">Avengers: Endgame</h2>
					<p class="lead">Los héroes restantes unen fuerzas para derrotar a Thanos y restaurar el universo</p>
					<div class="mt-4 d-flex justify-content-center flex-wrap gap-3">
						<a href="#comics" class="btn btn-primary btn-lg">Ver Comics</a>
						<a href="#"  class="btn btn-light btn-lg text-dark fw-bold">Conocer más proyectos</a>
					</div>
				</figcaption>
			</figure>
		</header>

		<main class="container my-5">
			<section class="row g-4">
				<article class="col-12 col-md-8" id="comics">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic _spiderman.jpg" class="img-fluid w-100" alt="Spiderman" loading="lazy" style="height: 420px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-3" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h4 fw-bold">Spiderman</h3>
							<p>El héroe arácnido protege Nueva York enfrentando villanos clásicos y modernos.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-6 col-md-4">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic _tor.jpg" class="img-fluid w-100" alt="Thor" loading="lazy" style="height: 420px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-3" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Thor</h3>
							<p>El dios del trueno lucha con su martillo para proteger los Nueve Reinos.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-12 col-md-4">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_captain_america.jpg" class="img-fluid w-100" alt="Captain America" loading="lazy" style="height: 420px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-2" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Captain America</h3>
							<p>El super soldado lidera a los Avengers con coraje y estrategia en cada batalla.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-12 col-md-8">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_hulk.jpg" class="img-fluid w-100" alt="Hulk" loading="lazy" style="height: 420px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-2" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Hulk</h3>
							<p>El gigante verde combina fuerza descomunal con momentos heroicos inesperados.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-6 col-md-8">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_iron_man.jpg" class="img-fluid w-100" alt="Iron Man" loading="lazy" style="height: 350px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-3" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h4 fw-bold">Iron Man</h3>
							<p>Tony Stark protege al mundo con su ingenio y armaduras de alta tecnología.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-6 col-md-4">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_superman.jpg" class="img-fluid w-100 grid-superman-custom" alt="Superman" loading="lazy" style="height: 350px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-2" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Superman</h3>
							<p>El hombre de acero protege la Tierra con poderes sobrehumanos y ética inquebrantable.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-6 col-md-6">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_wanda.jpg" class="img-fluid w-100" alt="Wanda" loading="lazy" style="height: 320px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-2" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Wanda</h3>
							<p>La Bruja Escarlata combina magia y emoción para alterar la realidad a su favor.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-6 col-md-6">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_woderfull_women.jpg" class="img-fluid w-100" alt="Wonder Woman" loading="lazy" style="height: 320px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-2" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Wonder Woman</h3>
							<p>La amazona guerrera lucha por justicia y paz con fuerza y sabiduría legendarias.</p>
						</figcaption>
					</figure>
				</article>

				<article class="col-12 col-md-12">
					<figure class="position-relative m-0">
						<img src="./src/assets/grid/comic_batman.jpg" class="img-fluid w-100" alt="Batman" loading="lazy" style="height: 350px; object-fit: cover; max-width: 100%" />
						<figcaption class="position-absolute bottom-0 start-0 w-100 text-white p-2" style="background: rgba(0, 0, 0, 0.5)">
							<h3 class="h5 fw-bold">Batman</h3>
							<p>El caballero oscuro protege Gotham con ingenio, estrategia y recursos tecnológicos.</p>
						</figcaption>
					</figure>
				</article>
			</section>
		</main>

		<footer class="bg-black text-white py-4 mt-5 ">
			
				<div class="d-block text-center">
					<span>Jefferson Mejía, Noelia Mendoza</span>
				</div>
			
		</footer>

		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
		<script src="./src/js/index.js"></script>
	</body>
</html>
