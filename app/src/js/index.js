const toggle = document.getElementById('darkModeToggle')
const d = document

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
console.log(data)

        d.getElementById('host').textContent = data.hostname
        d.getElementById('ip').textContent = data.ip
        d.getElementById('db').textContent = data.db

        const box = d.getElementById('server-box')
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
