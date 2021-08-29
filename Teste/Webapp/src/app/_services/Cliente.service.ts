import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Cliente } from '../_models/Cliente';

@Injectable({
    providedIn: 'root'
})
export class ClienteService {

    baseURL = 'http://localhost:5000/Cliente';

    constructor(private http: HttpClient) { }

    getAllClientes() : Observable<Cliente[]>{
        return this.http.get<Cliente[]>(this.baseURL);
      }

    postCliente(cliente: Cliente) {
        return this.http.post(this.baseURL, cliente);
      }
    
    putCliente(cliente: Cliente) {
        return this.http.put(this.baseURL, cliente);
      }

    deleteCliente(cliente: Cliente){
        return this.http.delete(`${this.baseURL}/${cliente.id}`);
      }
}
