namespace Domain
{
    public class Telefone : ModelBase
    {
        public string DDD { get; set; }

        public string Numero { get; set; }

        public bool Ativo { get; set; }

        public TipoTelefone TipoTelefone { get; set; }
    }
}