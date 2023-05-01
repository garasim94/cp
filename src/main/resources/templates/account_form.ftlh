<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="text-center">
        <h2>Your account:</h2>
    </div>
    <form action="/account/update" method="post" style="max-width:700px; margin: 0 auto">
        <input type="hidden" value="${user.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <div class="border border-secondary rounded p-3">
            <div class="form-group row">
                <label class="col-sm-4 col-form-label">Username:</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control" name="username" value="${user.username}" readonly="readonly"/>
                </div>
            </div>
            <div class="form-group row p-auto d-flex justify-content-center">
                <a title="Change password" data-toggle="collapse" href="#collapseForm" role="button" aria-expanded="false" aria-controls="collapseExample">
                    Change password
                </a>
            </div>
            <div class="mr-2">
                <div class="collapse" id="collapseForm">
                    <h3 class="mr-2">Change password:</h3>
                    <div class="form-group mt-3">
                        <input type="hidden" id="userId" name="id" value="${user.id}" />
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                        <div class="form-group">
                            <label for="password">New password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password" required minlength="8" maxlength="64" oninput="checkPassword(document.getElementById('confirmPassword'))">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility('password', 'password-icon')">
                                        <i id="password-icon" class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm the password:</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="confirmPassword" oninput="checkPassword(this)" minlength="8" maxlength="64">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePasswordVisibility('confirmPassword', 'confirm-password-icon')">
                                        <i id="confirm-password-icon" class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-4 col-form-label">Roles:</label>
                <div class="col-sm-7">
                    <span><b><#list user.roles as role>${role}<#sep>, </#list></b></span>
                </div>
            </div>
            <div class="text-center">
                <input type="submit" value="Save" class="btn btn-primary m-3"/>
                <a href="/" type="button" class="btn btn-secondary">Cancel</a>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        function checkPassword(confirmPassword){
            if(confirmPassword.value!= $("#password").val()){
                confirmPassword.setCustomValidity("Passwords are different!");
            }else{
                confirmPassword.setCustomValidity("");
            }
        }
        function togglePasswordVisibility(inputId, iconId) {
            var passwordInput = document.getElementById(inputId);
            var passwordIcon = document.getElementById(iconId);
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
</@c.page>