import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-Titulo',
  templateUrl: './Titulo.component.html',
  styleUrls: ['./Titulo.component.css']
})
export class TituloComponent implements OnInit {

  @Input() title: string;

  constructor() { }

  ngOnInit() {
  }

}
