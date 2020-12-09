const index = {

    cadastrar(){
        var nome = document.getElementById("#inputnome").value; 
        var cpf = document.getElementById("#inputcpf").value; 
        var email = document.getElementById("#inputemail").value;
        var telefone = document.getElementById("#inputtelefone").value; 
        var celular = document.getElementById("#inputcelular").value; 
        var datanascimento = document.getElementById("#inputdatanascimento").value;
        var sexo = document.getElementById("#inputsexo").value.charAt(0);

        var usuario = document.getElementById("#inputusername").value; 
        var nivel = document.getElementById("#inputvisao").value;
        var ativo = document.getElementById("#inputativo").value;
        var senha = document.getElementById("#inputpassword").value; 
        var senharepet = document.getElementById("#inputpasswordrepet").value;

        var valido = true;
        //validação 
        if(nome == "" || nome == undefined){
            document.getElementById('#nomeerror').classList.remove('d-none');
            document.getElementById('#nomeerror').innerHTML = "Nome Inválido"
            valido = false; 
        }
        
        if(cpf == "" || cpf == undefined){
            document.getElementById('#cpferror').classList.remove('d-none');
            document.getElementById('#cpferror').innerHTML = "CPF Inválido"
            valido = false; 
        }

        if(email == "" || email == undefined){
            document.getElementById('#emailerror').classList.remove('d-none');
            document.getElementById('#emailerror').innerHTML = "email inválido"
            valido = false; 
        }

        if(datanascimento == "" || datanascimento == undefined){
            document.getElementById('#datanascimentorerror').classList.remove('d-none');
            document.getElementById('#datanascimentorerror').innerHTML = "Data Inválida"
            valido = false; 
        }

        if(usuario == "" || usuario == undefined){
            document.getElementById('#usernameerror').classList.remove('d-none');
            document.getElementById('#usernameerror').innerHTML = "Username inválido"
            valido = false; 
        }

        if(senha == "" || senha == undefined){
            document.getElementById('#passworderror').classList.remove('d-none');
            document.getElementById('#passworderror').innerHTML = "Sem Senha"
            valido = false; 
        }

        if(senharepet == "" || senharepet == undefined){
            document.getElementById('#passwordrepeterror').classList.remove('d-none');
            document.getElementById('#passwordrepeterror').innerHTML = "Você se esqueceu de digitar a senha"
            valido = false; 
        }

        if(senha.localeCompare(senharepet) != 0){
            document.getElementById('#passwordrepeterror').classList.remove('d-none');
            document.getElementById('#passwordrepeterror').innerHTML = "As senhas não conferem";
            valido = false;  
        }

        if(valido){
            var dados = { 
                administrador: {nome, cpf, datanascimento, sexo, telefone, celular, email},
                usuario: {usuario, senha, nivel, ativo}
            }

            var config = {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=utf-8"
                },
                credentials: 'include',
                body: JSON.stringify(dados) //serializa
            }

            fetch('/cadastraradministradores/cadastrar', config)
            .then((dadosJson)=>{
                obj = dadosJson.json(); 
                return obj;
            })
            .then((dadosObj)=>{
                if(dadosObj.inserido == true){
                    var snippet = document.getElementById("#resultado");
                    snippet.classList.remove('d-none');
                    snippet.innerHTML = dadosObj.msg; 
                    window.setTimeout(function() {
                        snippet.classList.add('d-none');
                    }, 3000);
                    document.getElementById("#inputnome").value = ""; 
                    document.getElementById("#inputcpf").valu = ""; 
                    document.getElementById("#inputemail").value = "";
                    document.getElementById("#inputtelefone").value = ""; 
                    document.getElementById("#inputcelular").value = ""; 
                    document.getElementById("#inputdatanascimento").value = "";
                    document.getElementById("#inputsexo").value = 1;

                    document.getElementById("#inputusername").value = ""; 
                    document.getElementById("#inputvisao").value = 1;
                    document.getElementById("#inputativo").value = 1;
                    document.getElementById("#inputpassword").value = ""; 
                    document.getElementById("#inputpasswordrepet").value = "";
                }else{
                    var snippet = document.getElementById("#resultado"); 
                    snippet.classList.remove('d-none');
                    snippet.classList.remove('bg-success');
                    snippet.classList.add('bg-danger');
                    snippet.innerHTML = dadosObj.msg;
                    window.setTimeout(function() {
                        snippet.classList.add('d-none');
                    }, 3000);
                }
            })
        }
    }
}

