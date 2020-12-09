const Index = {

    carregarUsuarios(){
        
        document.getElementById("#divtusuarios").classList.remove('d-none')
        var config = {
            method: "GET",
            headers: {
                "Content-Type": "application/json; charset=utf-8"
            },
            credentials: 'include',
        }

        fetch('/cadastraradministradores/usuarios', config)
        .then((dadosJson)=>{
            var obj = dadosJson.json(); 
            return obj;
        })
       .then((dadosObj)=>{
           var tabela = document.getElementById("#tusuarios").classList.remove('d-none'); 
           var text = "";
           var thead  = 
           `
           <th>Usuário</th>
              <th>Nome</th>
              <th>Email</th>
              <th>Status</th>
              <th></th>
              <th></th>
           `;
           dadosObj.forEach(element => {
               text+= `
               <tr>
                    <th scope="row">${element.usuario}</th>
                    <td>${element.administrador.nome}</td>
                    <td>${element.administrador.email}</td>
                    <td>${element.ativo == 1 ? "Ativo":"Inativo"}<td>
                    <td><a href="/cadastraradministradores/usuarios/alterar" class="btn btn-success text-white"><i class="fas fa-user-edit"></i></a><td>
                    <td><a href="#" class="btn btn-danger text-white"><i class="fas fa-trash"></i></a><td>
                </tr>
               `
           });
           document.getElementById("#theadusuarios").innerHTML = thead;
           document.getElementById("#tbodyusuarios").innerHTML = text;
       }).catch((erro)=>{
            document.getElementById("#tusuarios").classList.add('text-center');
            document.getElementById("#tusuarios").innerHTML = `Ocorreu um erro ao carregar os dados"`;
       })
    }
}


Index.carregarUsuarios();