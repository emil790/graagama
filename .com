agama/
│── index.html
│── style.css
│── script.js
│── tlo.jpg        ← zdjęcie agamy (to co wysłałeś)
│── hura.mp3       ← dźwięk sukcesu (opcjonalnie)
🦗 40%
🪳 45%
🪱 15%
<!DOCTYPE html>
<html lang="pl">
<head>
  <meta charset="UTF-8">
  <title>Nakarm Agamę</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

<div id="ekran1" class="ekran">
  <button onclick="pokazEkran(2)">Nakarm agamę</button>
</div>

<div id="ekran2" class="ekran hidden">
  <div id="lucky">⬛</div>

  <div class="ramka">
    🦗 40% &nbsp; 🪳 45% &nbsp; 🪱 15%
  </div>

  <button onclick="losuj()">Otwórz</button>
</div>

<div id="ekran3" class="ekran hidden">
  <h1 id="wynik"></h1>
  <button id="retry" onclick="pokazEkran(1)">Spróbuj ponownie</button>
</div>

<audio id="hura" src="hura.mp3"></audio>

<script src="script.js"></script>
</body>
</html>
body {
  margin: 0;
  font-family: Arial;
  background: url("tlo.jpg") no-repeat center center fixed;
  background-size: cover;
  color: white;
  text-align: center;
}

.ekran {
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.hidden {
  display: none;
}

button {
  font-size: 24px;
  padding: 20px 40px;
  background: #1e90ff;
  border: none;
  border-radius: 10px;
  color: white;
  cursor: pointer;
}

#lucky {
  width: 150px;
  height: 150px;
  background: gold;
  margin-bottom: 20px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.ramka {
  border: 2px solid white;
  padding: 15px;
  margin-bottom: 20px;
}
function pokazEkran(nr) {
  document.querySelectorAll(".ekran").forEach(e => e.classList.add("hidden"));
  document.getElementById("ekran" + nr).classList.remove("hidden");
}

function losuj() {
  pokazEkran(3);

  let r = Math.random() * 100;
  let wynik = document.getElementById("wynik");

  if (r < 40) {
    wynik.textContent = "🦗 Udało się! Agama brodata zjadła";
    document.getElementById("hura").play();
  } else if (r < 85) {
    wynik.textContent = "👺 Robak uciekł!";
  } else {
    wynik.textContent = "😴 Agama nie jest głodna";
  }
}
