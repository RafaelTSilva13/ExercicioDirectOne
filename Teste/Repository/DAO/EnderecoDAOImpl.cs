using Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Repository.DAO
{
    public class EnderecoDAOImpl : BaseDAOImpl<Endereco>
    {
        public EnderecoDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(Endereco entity)
        {
            throw new NotImplementedException();
        }

        public override Endereco GetByID(int id)
        {
            throw new NotImplementedException();
        }

        public override List<Endereco> ListAll()
        {
            throw new NotImplementedException();
        }

        public override Endereco ParseToObject(DataRow row)
        {
            throw new NotImplementedException();
        }

        public override bool Save(Endereco entity)
        {
            throw new NotImplementedException();
        }

        public override bool Update(Endereco entity)
        {
            throw new NotImplementedException();
        }
    }
}
