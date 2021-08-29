import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { BsModalRef } from 'ngx-bootstrap/modal';
import { Cliente } from '../_models/Cliente';


import { ToastrService } from 'ngx-toastr';
import { ClienteService } from '../_services/Cliente.service';
import { CellHoverEvent } from 'ngx-bootstrap/datepicker/models';

@Component({
  selector: 'app-clientes',
  templateUrl: './clientes.component.html',
  styleUrls: ['./clientes.component.css']
})
export class ClientesComponent implements OnInit {
  
  _filtroLista: string;
  get filtroLista() : string {
    return this._filtroLista;
  }
  set filtroLista(value: string){
    this._filtroLista = value;
    this.clientesFiltrados = value ? this.filtrarClientes(value) : this.clientes;
  }


  titulo = 'Clientes';
  clientes: Cliente[];
  clientesFiltrados: Cliente[];
  cliente: Cliente;
  registerForm: FormGroup;
  dataNascimento: string;
  bodyDeletarCliente: string;

  constructor(private fb: FormBuilder, private clienteService: ClienteService, private toastr: ToastrService) { }

  ngOnInit() {
    this.validation();
    this.getClientes();
  }

  filtrarClientes(filtrarPor: string) : Cliente[] {
    filtrarPor = filtrarPor.toLocaleLowerCase();
    return this.clientes.filter(e => e.nome.toLocaleLowerCase().indexOf(filtrarPor) !== -1);
  }

  getClientes(){
      this.clienteService.getAllClientes().subscribe(
        (_cliente: Cliente[]) => {
          this.clientes = _cliente;
          this.clientesFiltrados = _cliente;
        }, error => {
          console.log(error);
          this.toastr.error(`Erro ao carregar clientes: ${error}`);
        }
        );
}

novoCliente(template: any){
  this.openModal(template);
  this.cliente = null;
}

editarCliente(template: any, cliente: Cliente){
  this.openModal(template);
  this.cliente = Object.assign({}, cliente);
  this.registerForm.patchValue(this.cliente);
}

excluirCliente(template: any, cliente: Cliente){
  this.cliente = cliente;
  this.bodyDeletarCliente = `Tem certeza que deseja excluir o Cliente: ${cliente.id} ${cliente.nome}`;
  template.show();
}

confirmeDelete(template: any){
  this.clienteService.deleteCliente(this.cliente).subscribe(
    () =>{
      template.hide();
      this.getClientes();
      this.toastr.success("Cliente deletado com sucesso.");
    },
    error =>{
      console.log(error);
      this.toastr.error(`Erro ao deletar Cliente: ${error}`);
    }    
    );
}

openModal(template: any){
  this.registerForm.reset();
  template.show(template);
}

validation(){
      
  this.registerForm = this.fb.group({
    nome: [ '', [Validators.required]],
    cpf: ['', Validators.required],
    rg: ['', Validators.required],
    dataNascimento: ['', Validators.required],
  });
}

salvarAlteracao(template: any){
  if(this.registerForm.valid)
  {
    if(this.cliente == null)
    {
      this.cliente = Object.assign({}, this.registerForm.value);

      this.clienteService.postCliente(this.cliente).subscribe(
        (novocliente: Cliente) =>{          
          template.hide();
          this.getClientes();
          this.toastr.success("Cliente cadastrado com sucesso.");
        },
        error =>{
          this.cliente = null;
          console.log(error);
          this.toastr.error(`Erro ao cadastrar Cliente: ${error}.`);
        }    
        );
      }
      else
      {
        this.cliente = Object.assign({id: this.cliente.id}, this.registerForm.value);

        this.clienteService.putCliente(this.cliente).subscribe(
          (novoCliente: Cliente) =>{
            template.hide();
            this.getClientes();
            this.toastr.success("Cliente atualizado com sucesso.");
          },
          error =>{
            console.log(error);
            this.toastr.error(`Erro ao atualizar Cliente: ${error}.`);
          }    
          );
        }
      }
    }

}
