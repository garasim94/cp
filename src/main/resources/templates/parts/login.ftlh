<#include "security.ftlh">
<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">User Name :</label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control" placeholder="User name" required/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6 input-group">
                <input type="password"  id="password" name="password" class="form-control" placeholder="Password" required onkeyup="checkCapsLock(event)"/>
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility()">
                        <i id="password-icon" class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="alert alert-danger caps-lock-notification" role="alert">Caps Lock включен</div>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <#if !isRegisterForm><a href="/registration">Add new user</a></#if>
        <button class="btn btn-primary" type="submit"><#if isRegisterForm>Create<#else>Login</#if></button>
    </form>
    <script>
        var passwordInput = document.getElementById("password");
        var capsLockNotification = document.querySelector(".caps-lock-notification");

        passwordInput.addEventListener("keyup", function(event) {
            if (event.getModifierState("CapsLock")) {
                capsLockNotification.style.display = "block";
            } else {
                capsLockNotification.style.display = "none";
            }
        });
        // function checkCapsLock(e) {
        //     var capsLockOn = e.getModifierState && e.getModifierState('CapsLock');
        //     var msg = document.getElementById("caps-lock-msg");
        //
        //     if (capsLockOn) {
        //         msg.style.display = 'block';
        //     } else {
        //         msg.style.display = 'none';
        //     }
        // }
        function togglePasswordVisibility() {
            var passwordInput = document.getElementById("password");
            var passwordIcon = document.getElementById("password-icon");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                passwordIcon.classList.remove("fa-eye");
                passwordIcon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                passwordIcon.classList.remove("fa-eye-slash");
                passwordIcon.classList.add("fa-eye");
            }
        }
    </script>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <#if hasRole>
            <button class="btn btn-primary" type="submit">Sign Out</button>
        <#else>

            <button class="btn btn-primary" type="submit">Sign In</button>

        </#if>
    </form>
</#macro>