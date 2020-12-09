const index = {

    carregarFormulario(){

        document.getElementById("#body").innerHTML = 
        `
        <div class="d-flex align-items-center justify-content-center my-4">
            <i class="fas fa-user fa-4x"></i>
            <h3 class="ml-3"><b>Alterar Usuario</b></h3>
        </div>
        <div class="container w-50">
            <form role="form">
                <div class="form-group row">
                    <label for="#inputnome" class="control-label col-sm-4 pt-2">Nome: </label>
                    <input type="text" id="#inputnome" class="form-control col-sm-8" aria-describedby="#nomeerror" placeholder="Nome"/>
                    <small id="#nomeerror" class="w-100 text-danger text-right d-none">nome inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputcpf" class="control-label col-sm-4 pt-2">CPF: </label>
                    <input type="text" id="#inputcpf" class="form-control col-sm-8" aria-describedby="#cpferror" placeholder="ex: 454.121.312-13">
                    <small id="#cpferror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputemail" class="control-label col-sm-4 pt-2">Email: </label>
                    <input type="email" id="#inputemail" class="form-control col-sm-8" aria-describedby="emailerror" placeholder="usuario@email.com.br">
                    <small id="#emailerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputtelefone" class="control-label col-sm-4 pt-2">Telefone: </label>
                    <input type="text" id="#inputtelefone" class="form-control col-sm-8" aria-describedby="#telefoneerror" placeholder="ex(18) 1234-5678">
                    <small id="#telefoneerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputcelular" class="control-label col-sm-4 pt-2">Celular: </label>
                    <input type="text"  id="#inputcelular" class="form-control col-sm-8" aria-describedby="#celularerror" placeholder="ex(00) 00000-0000">
                    <small id="#celularerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputdatanascimento" class="control-label col-sm-4 pt-2">Data De Nascimento: </label>
                    <input type="date"  id="#inputdatanascimento" class="form-control col-sm-8">
                    <small id="#datanascimentorerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputsexo" class="control-label col-sm-4 pt-2">Sexo: </label>
                <select class="form-control col-sm-8" id="#inputsexo">
                    <option selected value="M">Masculino</option>
                    <option value="F">Feminino</option>
                </select>
                <small id="#sexoerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div style="height: 15vh;"></div>
                <div class="form-group row">
                    <label for="#inputusername" class="control-label col-sm-4 pt-2">Usuário: </label>
                    <input type="text" id="#inputusername" class="form-control col-sm-8" aria-describedby="helpusername" placeholder="Usuário">
                    <small id="#usernameerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputvisao" class="control-label col-sm-4 pt-2">Visão: </label>
                <select class="form-control col-sm-8" id="#inputvisao">
                    <option selected value="1">Administrador</option>
                    <option selected value="2">Assistente</option>
                    <option value="3">Gestor</option>
                    <option value="4">Loja</option>
                </select>
                <small id="#sexoerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputvisao" class="control-label col-sm-4 pt-2">Ativo: </label>
                <select class="form-control col-sm-8" id="#inputativo">
                    <option selected value="1">Sim</option>
                    <option value="0">Não</option>
                </select>
                <small id="#sexoerror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputpassword" class="control-label col-sm-4 pt-2">Senha: </label>
                    <input type="password" class="form-control col-sm-8" id="#inputpassword" aria-describedby="helpemail">
                    <small id="#passworderror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="form-group row">
                    <label for="#inputpasswordrepet" class="control-label col-sm-4 pt-2">Senha novamente: </label>
                    <input type="password" class="form-control col-sm-8" id="#inputpasswordrepet" aria-describedby="helpemail"/>
                    <small id="#passwordrepeterror" class="w-100 text-danger text-right d-none">cpf inválido</small>
                </div>
                <div class="bg-success w-100 p-3 text-center text-light rounded d-none" id="#resultado"></div>
                <div class="d-flex justify-content-center mt-5">
                    <button type="button" class="btn btn-success mx-3" onclick="index.cadastrar()">Salvar</button>
                    <button type="Reset" class="btn btn-danger">Cancelar</button>
                </div>
        </form>
    </div> 
        `

        document.getElementById("#btnAlteracao").classList.remove('text-white');
        document.getElementById("#btnAlteracao").classList.remove('bg-secondary');
        document.getElementById("#btnAlteracao").classList.add('text-dark');
        document.getElementById("#btnAlteracao").classList.add('bg-white');

        document.getElementById("#btnHistorico").classList.add('text-white');
        document.getElementById("#btnHistorico").classList.add('bg-secondary');
        document.getElementById("#btnHistorico").classList.remove('text-dark');
        document.getElementById("#btnHistorico").classList.remove('bg-white');
    },

    carregarHistorico(){
        document.getElementById("#body").innerHTML = 
        ``;

        document.getElementById("#btnHistorico").classList.remove('text-white');
        document.getElementById("#btnHistorico").classList.remove('bg-secondary');
        document.getElementById("#btnHistorico").classList.add('text-dark');
        document.getElementById("#btnHistorico").classList.add('bg-white');

        document.getElementById("#btnAlteracao").classList.add('text-white');
        document.getElementById("#btnAlteracao").classList.add('bg-secondary');
        document.getElementById("#btnAlteracao").classList.remove('text-dark');
        document.getElementById("#btnAlteracao").classList.remove('bg-white');
    }

}