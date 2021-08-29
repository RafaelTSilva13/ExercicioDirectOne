namespace Domain
{
    public class Endereco : ModelBase
    {
        public string CEP { get; set; }

        public string Logradouro { get; set; }

        public int Numero { get; set; }

        public string Complemento { get; set; }        

        public bool Ativo { get; set; }

        public TipoEndereco TipoEndereco { get; set; }
    }
}