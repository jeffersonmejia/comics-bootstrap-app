const toggle = document.getElementById('darkModeToggle')

toggle.addEventListener('click', () => {
	document.body.classList.toggle('bg-dark')
	document.body.classList.toggle('text-white')
	const icon = toggle.querySelector('i')
	icon.classList.toggle('bi-moon-fill')
	icon.classList.toggle('bi-sun-fill')
})
