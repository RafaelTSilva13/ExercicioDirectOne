using Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Repository.DAO
{
    public class RedeSocialDAOImpl : BaseDAOImpl<RedeSocial>
    {
        public RedeSocialDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(RedeSocial entity)
        {
            throw new NotImplementedException();
        }

        public override RedeSocial GetByID(int id)
        {
            throw new NotImplementedException();
        }

        public override List<RedeSocial> ListAll()
        {
            throw new NotImplementedException();
        }

        public override RedeSocial ParseToObject(DataRow row)
        {
            throw new NotImplementedException();
        }

        public override bool Save(RedeSocial entity)
        {
            throw new NotImplementedException();
        }

        public override bool Update(RedeSocial entity)
        {
            throw new NotImplementedException();
        }
    }
}
