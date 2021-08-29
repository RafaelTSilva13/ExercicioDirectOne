using System;
using System.Collections.Generic;

namespace Domain
{
    public class Cliente : ModelBase
    {
        public string Nome { get; set; }

        public string CPF { get; set; }

        public string RG { get; set; }

        public bool Ativo { get; set; }

        public DateTime DataNascimento { get; set; }

        public List<Telefone> Telefones { get;set; }

        public List<Endereco> Enderecos { get; set; }

        public List<RedeSocial> RedesSociais { get; set; }
    }
}