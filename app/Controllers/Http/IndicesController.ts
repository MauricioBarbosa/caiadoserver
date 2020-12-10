// import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

import View from "@ioc:Adonis/Core/View";

export default class IndicesController {

    async index({session}){
        return View.render('home/home', {
            user: session.get('user'),
            admin: session.get('admin')
        });
    }

    teste(){
        let ab: string = 'oi';
        console.log(ab);
    }
}
