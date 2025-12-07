const toggle = document.getElementById('darkModeToggle')
const d = document,
      box = d.getElementById('server-box'),
      scrollThreshold = 500

toggle.addEventListener('click', () => {
    d.body.classList.toggle('bg-dark')
    d.body.classList.toggle('text-white')
    const icon = toggle.querySelector('i')
    icon.classList.toggle('bi-moon-fill')
    icon.classList.toggle('bi-sun-fill')
})

const interval = 2000

async function updateServerInfo() {
    try {
        const response = await fetch('server.php')
        const data = await response.json()

        d.getElementById('host').textContent = data.hostname
        d.getElementById('ip').textContent = data.ip
        d.getElementById('db').textContent = data.db

        if(data.db === "Conectada") {
            box.classList.add('success-db-message')
            box.classList.remove('error-db-message')
        } else {
            box.classList.add('error-db-message')
            box.classList.remove('success-db-message')
        }

    } catch (error) {
        console.error('Error updating server info:', error)
    }
}

updateServerInfo()
setInterval(updateServerInfo, interval)

window.addEventListener('scroll', () => {
    const scrollBottom = d.documentElement.scrollHeight - d.documentElement.scrollTop - window.innerHeight
console.log(scrollBottom)
    if(scrollBottom < scrollThreshold) {
	box.classList.add('box-top')
    }else{
      box.classList.remove('box-top')
    }

})


