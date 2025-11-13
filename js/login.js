document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const errorMessage = document.getElementById('errorMessageSubmit');

    // Resetea el mensaje de error
    errorMessage.textContent = '';

    // Validacion basica
    if (email.trim() === '' || password.trim() === '') {
        errorMessage.textContent = 'Por favor, completa ambos campos.';
        return;
    }

    /* if (!validateEmail(email)) {
        errorMessage.textContent = 'Por favor, ingresa un correo electronico valido.';
        return;
    } */

    // Si la validacion es exitosa (aqui iria la logica de autenticacion)
    console.log('Formulario valido. Enviando datos...');
    console.log('Email:', email);
    console.log('Password:', password);
    
    // Aqui podrias enviar los datos a un servidor usando fetch()
    // fetch('/login', { method: 'POST', body: JSON.stringify({ email, password }) ... })

    // alert('¡Inicio de sesion exitoso!'); // Simulacion de exito
    window.location.href = 'inicio.html';
});

document.getElementById('email').addEventListener('blur', function(event){
    // console.log(event.target.value);
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (re.test(String(event.target.value).toLowerCase())) {
        event.target.classList.remove('incorrecto');
        document.getElementById('errorMessageEmail').textContent='';
    } else {
        event.target.classList.add('incorrecto');
        if (event.target.value==='') {
            document.getElementById('errorMessageEmail').textContent='Por favor, ingresa tu correo electronico.';
        } else {
            document.getElementById('errorMessageEmail').textContent='Por favor, ingresa un correo electronico valido.';
        }
    }
});
document.getElementById('password').addEventListener('blur', function(event){
    // console.log(event.target.value);
    if (String(event.target.value)==='') {
        event.target.classList.add('incorrecto');
        document.getElementById('errorMessagePassword').textContent='Por favor, ingresa tu contrasena.';
    } else {
        event.target.classList.remove('incorrecto');
        document.getElementById('errorMessagePassword').textContent='';
    }
});
