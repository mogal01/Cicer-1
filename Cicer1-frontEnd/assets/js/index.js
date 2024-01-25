

function sendLoginRequestServer()    {
    let email = document.getElementById('InputUtenteEmailTI').value;
    let password = document.getElementById('InputUserPasswordTI').value;

    const apiUrlLog = 'http://192.168.216.109:8080/Login/' + email + '/' + password;
    fetch(apiUrlLog, {
    method: 'POST'    
    })
    .then(response => {

    if (response.status === 403) 
    {
      Swal.fire({
        title: "Login",
        text: "Ops! Sembra che le credenziali sono errate",
        icon: "error"
      });
      
      throw new Error('Campi errati. Status code: ' + response.status);
    }

    return response.json();
  })
    .then(data => {
        if(data.token != null)  {
          sessionStorage.setItem('token', data.token);
          window.location.href = './dashboard.html';
        }
      })
    .catch(error => console.error('Error:', error));

    return false;
}

function showModifyPasswordToggle() {
    let inputPassword = document.getElementById('InputUserPasswordTI');
    let icon = document.getElementById('toggleEyePass');
    
    if (inputPassword.type === "password") {
        // Cambia il tipo di input da "password" a "text"
        inputPassword.type = "text";
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else {
        // Se il tipo di input non è "password", imposta il tipo di input a "password"
        inputPassword.type = "password";
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
}


let tokk = sessionStorage.getItem('token');
function logOut() {

  const apiUrlLogOut = 'http://192.168.216.109:8080/LogOut/' + tokk;
    fetch(apiUrlLogOut, {
    method: 'POST'    
    })
    .then(response => response.json())
    .then(data => {
          sessionStorage.removeItem('token');
          window.location.href = 'index.html';
      })
    .catch(error => console.error('Error:', error));
}
