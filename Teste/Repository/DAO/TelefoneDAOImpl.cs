using Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Repository.DAO
{
    public class TelefoneDAOImpl : BaseDAOImpl<Telefone>
    {
        public TelefoneDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(Telefone entity)
        {
            throw new NotImplementedException();
        }

        public override Telefone GetByID(int id)
        {
            throw new NotImplementedException();
        }

        public override List<Telefone> ListAll()
        {
            throw new NotImplementedException();
        }

        public override Telefone ParseToObject(DataRow row)
        {
            throw new NotImplementedException();
        }

        public override bool Save(Telefone entity)
        {
            throw new NotImplementedException();
        }

        public override bool Update(Telefone entity)
        {
            throw new NotImplementedException();
        }
    }
}
