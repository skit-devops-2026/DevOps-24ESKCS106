// Digital Bank - Signup Form Validation
document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('signupForm');
  const togglePassword = document.getElementById('togglePassword');
  const passwordInput = document.getElementById('password');

  if (togglePassword && passwordInput) {
    togglePassword.addEventListener('click', function () {
      const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordInput.setAttribute('type', type);
      togglePassword.classList.toggle('fa-eye');
      togglePassword.classList.toggle('fa-eye-slash');
    });
  }

  if (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      const name = document.getElementById('fullname')?.value.trim();
      const email = document.getElementById('email')?.value.trim();
      const password = passwordInput ? passwordInput.value : '';

      let hasError = false;

      if (!name) {
        const errName = document.getElementById('errorname');
        if (errName) errName.textContent = 'Please enter your full name.';
        hasError = true;
      }

      if (!email || !email.includes('@')) {
        const errEmail = document.getElementById('erroremail');
        if (errEmail) errEmail.textContent = 'Please enter a valid email address.';
        hasError = true;
      }

      if (!password || password.length < 8) {
        const errPass = document.getElementById('errorpassword');
        if (errPass) errPass.textContent = 'Password must be at least 8 characters.';
        hasError = true;
      }

      if (!hasError) {
        alert('Account created successfully! Welcome to Digital Bank.');
        window.location.href = 'login.html';
      }
    });
  }
});
