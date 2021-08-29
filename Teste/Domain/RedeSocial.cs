namespace Domain
{
    public class RedeSocial : ModelBase
    {        
        public string URL { get; set; }

        public bool Ativo { get; set; }

        public TipoRedeSocial TipoRedeSocial { get; set; }
    }
}